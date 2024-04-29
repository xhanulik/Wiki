# Using Schlumberger e-gate on Linux

You have two options: PC/SC or OpenCT.

## Using OpenCT as a PC/SC reader

```text
cat > /etc/reader.conf.d/openct <<EOF
FRIENDLYNAME    OpenCT
DEVICENAME      /dev/null
LIBPATH         /usr/lib/openct-ifd.so
CHANNELID       0
EOF
update-reader.conf
/etc/init.d/pcscd restart
opensc-tool -l
opensc-tool -a -r 0
```

`/etc/reader.conf.d/` feature is available on debian/ubuntu and on fedora as far as I know, users of other distributions will want
to edit (NOT OVERWRITE) `/etc/reader.conf` directly. Also only debian/ubuntu users need to run update-reader.conf command.
opensc-tool -l should show the OpenCT reader via pcsc, and be able to read the atr from it.
