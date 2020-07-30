# nftbuild
Docker based build system for nftables

The goal of nftbuild is to make it trivial to create an nftables
coding/building/testing environment.  By using docker it is independent from
the host operating system and can be launched within minutes.

# Building the image

The docker image that contains all the tools necessary can be built using
the following command:

```
$ ./nftbuild/rules image
```

NOTE: later this might be built automatically on dockerhub, which would make
it only a docker pull away.

# Using the image

To bootstrap/compile nftables, one normally logs into the image
interactively, using the following command:

```
$ ./nftbuild/rules shell
```

This will launch a bash shell inside the container, the /source directory
pointing to the same directory where nftbuild is located.  The assumption is
that the nftables source code with all its dependencies (libmnl et al) will
be checked out in this directory.

# Checking out the sources

For now, it is assumed that you, the user of nftbuild would clone the git
repositories yourself into the same directory where nftbuild is located. 
For instance, my nftbuild directory looks like this:

```
bazsi@bzorp:~/src/netfilter$ ls -l
total 52
drwxrwxr-x  9 bazsi bazsi  4096 Jul 13 09:29 libmnl
drwxrwxr-x  8 bazsi bazsi  4096 Jul 13 09:25 libnetfilter_acct
drwxrwxr-x 11 bazsi bazsi  4096 Jul 13 09:25 libnetfilter_conntrack
drwxrwxr-x  8 bazsi bazsi  4096 Jul 13 09:25 libnetfilter_log
drwxrwxr-x  8 bazsi bazsi  4096 Jul 13 09:24 libnfnetlink
drwxrwxr-x 10 bazsi bazsi  4096 Jul 13 09:24 libnftnl
-rw-r--r--  1 bazsi bazsi 18092 Jul 29 13:36 LICENSE
drwxrwxr-x 12 bazsi bazsi  4096 Jul 13 09:31 nftables
drwxr-xr-x  6 bazsi bazsi  4096 Jul 29 13:36 nftbuild
```

Everything except nftbuild is the direct clone of the corresponding git repository from `git.netfilter.org`.

NOTE: later we might supply a script that clones these repositories
automatically to make this step a lot easier.

# Bootstrapping the sources

Once the sources are available, they will be mounted in `/source` when
within the container.  Just invoke the `bootstrap` command to autogen,
configure and install the dependencies into `/install` automatically.

# Editing/Building the source

You can change the source code either 
  #. on the host (by running your favourite editor and changing the files in the nftbuild directory).
  #. within the container (by changing the files in `/source`)
  
Once you are done, you can simply rebuild with your changes using:

```
$ cd /build/<component such as libmnl or nftables>
$ make install
```

Your intermediate build artifacts will always be in `/build`, installed
binaries will be deployed in `/install` when within the container.  Both
`/build` and `/install` are mounted from the host: `nftbuild/build` and
`nftbuild/install` respectively.  This means that these files are available
on the host and remain available at the next restart of the container.

# Running tests

