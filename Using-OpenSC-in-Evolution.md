# Using OpenSC in Evolution

This page will explain the steps required to use OpenSC crypto devices in [Evolution](http://projects.gnome.org/evolution/).

## Preparations

Make sure the NSS `modutil` tool is installed. If it is not available install it!

For example on Ubuntu 9.10 this can be done with the command:

```bash
sudo apt-get install libnss3-tools
```

## Insert OpenSC into the certificate database

Now you have to insert a link to the PKCS lib into Evolutions certificate database with `modutil`.

The syntax of the command is:

```bash
modutil -add <name> -libfile <path_to_lib> -dbdir <evolution_directory>
```

For example:

```bash
modutil -add "OpenSC" -libfile /usr/lib/opensc-pkcs11.so -dbdir ~/.evolution
```
