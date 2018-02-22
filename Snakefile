BASE_URL = 'http://genome.jgi.doe.gov'
JGI_LOGIN = 'XXX'
JGI_PASSWORD = 'YYY'

INPUTS = {}

def url_mapping(w):
	global INPUTS
	if not INPUTS:
		with open('urls.txt', 'rt') as f:
			for url in f.read().splitlines():
				INPUTS[url.split('/')[-1]] = url
	return expand('outputs/{url}', url=INPUTS.keys())

rule all:
    input:
        'urls.txt',
        url_mapping

rule login:
    output: 'cookies'
    shell: """
    curl 'https://signon.jgi.doe.gov/signon/create' \
        --data-urlencode 'login={JGI_LOGIN}' \
        --data-urlencode 'password={JGI_PASSWORD}' \
        -c {output[0]} > /dev/null
    """

rule download_index:
    input: 'cookies'
    output: 'fungi.xml'
    shell: """
        curl -L 'https://genome.jgi.doe.gov/ext-api/downloads/get-directory?organism=fungi' -b {input[0]} > {output[0]}
    """

rule extract_urls:
    input: 'fungi.xml'
    output: 'urls.txt'
    run:
        from lxml import etree

        with open(input[0], 'rb') as f:
            tree = etree.parse(f)

        urls = set()
        assemblies = tree.findall('.//folder[@name="Assembled scaffolds (unmasked)"]')
        for assembly in assemblies:
            for item in assembly:
                urls.add(item.attrib['url'])

        with open(output[0], 'wt') as f:
            for url in urls:
                f.write(url + '\n')

rule download_file:
    input: 'cookies', 'urls.txt'
    output: 'outputs/{dataset}'
    params:
        dataset=lambda w: INPUTS[w.dataset]
    shell: """
        curl -L '{BASE_URL}{params.dataset}' -b cookies > {output[0]}
    """
