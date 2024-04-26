# Using OpenSC

The `opensc-pkcs11.so` and many tools need the opensc config file to work properly.
On Linux and Mac OS X the location of the config file is set when calling
configure and then compiled in. However you can use the `OPENSC_CONF` environment
variable to specify a different config file. See also the EnvironmentVariables page.

On Windows the opensc config file is found using the registry key
`HKML\Software\OpenSC Project\OpenSC\ConfigFile`. If you compile and install OpenSC from
source you need to set this registry key to point to the install file.
Users can set `HKMU\Software\OpenSC Project\OpenSC\ConfigFile` to override the system
wide settings. Also users can use the `OPENSC_CONF` environment variable
to override both registry settings.

## Debug level

The OpenSC configuration (in general `/etc/opensc.conf`) has a debug level variable: `debug`. It is possible to overwrite this value using the `OPENSC_DEBUG` environment variable. For example you can use:

```bash
$ OPENSC_DEBUG=9 pkcs11-tool --list-slots
```

## PKCS #11 Spy

PKCS#11 Spy is a special PKCS#11 Module that sits between your application
and your real PKCS#11 Module, and creates a log file with all functions calls
by the application and return values by the real PKCS#11 Module. It does not
change the communication in any way. Be aware such log files are security
sensitive, as all information is logged, including PIN, PUK, signatures
and so on. So you should only use it for debugging, and preferable only with
test keys.

On Linux and Mac OS X you can use PKCS#11 Spy with environment variables:
by default stderr will be used for logging, but you can set _PKCS11SPY_OUTPUT_
to a filename, and that file will be appended. You need to set PKCS11SPY
to your PKCS#11 Module such as `opensc-pkcs11.so` (but use an absolute
path) to use PKCS#11 Module.

On windows the read PKCS#11 Module is found using `HKLM\Software\OpenSC Project\PKCS11-Spy\Module`
and the output is written to the file specified in `HKLM\Software\OpenSC Project\PKCS11-Spy\Output` (Default: `%TEMP%\pkcs11-spy.log`).
Again users can override these system wide settings using HKLU, and again user
can use environment variables to override the registry settings.

> Note that PKCS#11 Spy no longer reads the OpenSC config file and the settings
> in that config file (up to OpenSC version 0.9.*) are no longer valid. Now it
> is absolutely necessary to set at least the module via environment variables
> (or registry on windows).

Example, with Gnome evolution mail reader:

```bash
PKCS11SPY=/usr/lib/pkcs11/opensc-pkcs11.so \
PKCS11SPY_OUTPUT=logfile \
evolution
```

Inside evolution, select `pkcs11-spy.so` instead of `opensc-pkcs11.so`.

To debug `ssh-agent`, these environment variables needs to be set for the `ssh-agent` process:

```bash
export PKCS11SPY=/usr/lib/pkcs11/opensc-pkcs11.so \
export PKCS11SPY_OUTPUT=logfile `eval ssh-agent`;
ssh-add -s /usr/lib/pkcs11-spy.so
```
