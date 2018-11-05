## Installing PCGR using conda

This is an alternative installation approach that does not require Docker on your machine. At the moment it works only in linux machines.

First, you need conda package manager. Get it with:

```
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
bash miniconda.sh -b -p ./miniconda
```

Run the following to add conda into your PATH. 

```
. ./miniconda/etc/profile.d/conda.sh
```

You can even put that into your `~/.bashrc` or `~/.zshrc` to avoid re-doing it in the future.

Now create a new environment and install "pcgr" conda package into it:

```
conda create -n pcgr -c conda-forge -c bioconda -c vladsaveliev -c pdiakumis -c defaults pcgr
conda activate pcgr
```

Finally you can download reference data bundle for your genome build and you are all set:

```
gdown https://drive.google.com/uc?id=1MREECbygW47ttJySgfibBpX7romBrb_Q -O - | tar xvzf - # grch37
gdown https://drive.google.com/uc?id=1Xsw0WcKPnWgJDolQfrZATU5suEFJ5BKG -O - | tar xvzf - # grch38
```

There is a chance you'll encounter errors during the installation. Due to ongoing updates of the packages in public repositories, some packages might end up conflicting with each other or missing for your system. So try to stick to the dockerized version of PCGR whenever possible.

## Running condarized PCGR

Activate your environment with:

```
conda activate pcgr
```

Run PCGR with `--no-docker` flag. The first agument ("path to pcgr") now doesn't have to contain anything but a `data` directory that you downloaded.

```
pcgr.py --input_vcf examples/tumor_sample.BRCA.vcf.gz . test_out grch37 examples/pcgr_conf.BRCA.toml \
    tumor_sample.BRCA --no-docker
```
