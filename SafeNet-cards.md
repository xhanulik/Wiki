# SafeNet cards

## SafeNet iKey 3000

> Support and token sales have been discontinued.

SafeNet offered the iKey 3000 (known as Rainbow iKey before), an USB crypto token with 32k memory and support for RSA keys up to 1024bit key length.

The iKey 3000 is fully supported by OpenSC and is well tested. You need to obtain a USB driver for the token, you can use OpenCT on Linux.

The smart card inside is a [Starcos card by Giesecke & Devrient](STARCOS-cards).

One minor feature of Starcos is that a PIN can only be unblocked if it is blocked. For this reason the regression test `pin0002` fails, but this is a harmless and known issue, so please ignore.

iKey 3000 is bundled with StarSign software by A.E.T. (to be exact the A.E.T. middleware is called SafeSign) which follows the PKCS#15 standard. Thus key can be initialized with either OpenSC or StarSign and will work with both.

Documentation for the Starcos Smartcard is available upon request from G&D.

## iKey 4000 / SafeNet eToken 5000

The SafeSign iKey 4000 (SafeNet eToken 5000) is not supported by OpenSC.
To add support someone would need the APDU level documentation
and the time and energy to write a new driver.

## SafeNet 5110+ FIPS token

Support added in [#3048](https://github.com/OpenSC/OpenSC/pull/3048).
