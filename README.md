# Downloading files from JGI

- Set up JGI login and password in the Snakefile
- `pip install snakemake`
- `snakemake -k -j32` to use 32 threads to download files. `-k` means "don't stop on errors",
  which is useful because some datasets might be private.
