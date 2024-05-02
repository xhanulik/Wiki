# Wireless authentication

> Processes on this pages were not tested in recent years.

Wireless network used to be protected by the WEP standard, but WEP turned out to be insecure and thus useless.
These days wireless networks are usually protected using WPA - Wi-Fi Protected Access.
Unfortunately WPA is available in several flavors and versions.

If your wireless network is set up to ask for authentication using client certificates,
then you can use it with those certificates and keys on your smart card.

For Windows, the Windows build in WPA client should work well, if you have a CSP installed that works with OpenSC.
This is untested, please report your results.

For linux you can use the [WPA Supplicant](http://hostap.epitest.fi/wpa_supplicant/) or [Xsupplicant](http://www.open1x.org/) with OpenSC.
The support for smart cards is implemented in both via the [PKCS#11 Engine for OpenSSL](https://github.com/OpenSC/libp11).

## WPA Supplicant

To use WPA Suppplicant with smart card authentication you need to compile it with smart card support. Your config file should include this line:

```text
# Smartcard support (i.e., private key on a smartcard), e.g., with openssl
# engine.
CONFIG_SMARTCARD=y
```

Also you need to edit wpa_supplicant.conf like this:

```text
# OpenSSL Engine support
# These options can be used to load OpenSSL engines.
# make the pkcs11 engine available
pkcs11_engine_path=/usr/lib/engine/engine_pkcs11.so
# configure the path to the pkcs11 module required by the pkcs11 engine
pkcs11_module_path=/usr/lib/engine/opensc-pkcs11.so
```

## X Supplicant

It looks like xsupplicant is always compiled with smart card support.

To enable it, edit the xsupplicant.conf config file and look for lines
like these:

```text
     # this section configures the smartcard used with eap-tls
     # for now the smartcard PIN is handled the same way as the 
     # password for a private key
     smartcard {
        # this line actually enables the smartcard and makes xsupplicant use
        # the opensc engine
        engine_id = pkcs11
        # set the path to the engine
        opensc_so_path = "/usr/lib/engine/engine_pkcs11.so"
        # set the key id on the smartcard
        key_id = 45
     }
```
