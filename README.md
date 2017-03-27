# Downloading files from JGI

This is an example for downloading assembled (and unmasked) fungi genomes from [MycoCosm][0].
It uses the [API][1] to list files,
and [Snakemake][2] to manage the interaction with the API.

## Steps

- Set up JGI login and password in the Snakefile
- `pip install snakemake lxml`
- `snakemake -k -j32` to use 32 threads to download files. `-k` means "don't stop on errors",
  which is useful because some datasets might be private.

## TODO

- need to run twice: one for generating `urls.txt`,
  and another for the proper download
  (Comment out `url_mapping` in the rule `all` in the first run).
  Need to figure out how to make snakemake manage that (probably [dynamic rules][3]?)

[0]: http://genome.jgi.doe.gov/programs/fungi/index.jsf
[1]: http://genome.jgi.doe.gov/help/download.jsf#api
[2]: https://snakemake.readthedocs.io/en/stable/
[3]: http://snakemake.readthedocs.io/en/stable/snakefiles/rules.html#dynamic-files
