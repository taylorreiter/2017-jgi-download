# Downloading files from JGI

This is an example for downloading fungi genomes from [MycoCosm][0].
It uses the [API][1] to list files,
and [Snakemake][2] to manage the interaction with the API.

## Steps

- Set up JGI login and password in the Snakefile
- `pip install snakemake`
- `snakemake -k -j32` to use 32 threads to download files. `-k` means "don't stop on errors",
  which is useful because some datasets might be private.

[0]: http://genome.jgi.doe.gov/programs/fungi/index.jsf
[1]: http://genome.jgi.doe.gov/help/download.jsf#api
[2]: https://snakemake.readthedocs.io/en/stable/
