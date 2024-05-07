# Aladdin eToken PRO

[Aladdin](http://www.ealaddin.com/) offers the [eToken PRO](http://www.aladdin.com/etoken/devices/pro-usb.aspx), an USB crypto token with 32k or 64k memory and support for RSA keys up to 2048bit key length.

The eToken PRO is fully supported by OpenSC and is well tested.

> Note: some 72k Java cards "do not work":<https://github.com/OpenSC/OpenSC/issues/461>.

![Aladdin eToken PRO](./attachments/wiki/AladdinEtokenPro/eToken.gif "Aladdin eToken PRO")

## Models

The precise model of your token can be determined from the text moulded in the plastic enclosure.

### Unsupported models

There is a rare version of the Aladdin eToken PRO with a G&D Starcos smart card inside. This version never went into mass production as far as we know, and  is not supported by OpenSC.

Also there are some smart cards with the "Aladdin eToken" Name on them too. These cards are too old, they are not supported by OpenSC, as they lack some required features.

### eToken R1 and R2

Those were the first generation of tokens produced.  They use a proprietary protocol for communication between the host and token.

* **USB IDs:** 0529:030b through 0529:042a
* **Memory:** (?)
* **Maximum RSA key size:** (?)
* **Crypto chip:** (?)
* **On-Chip OS:** (?)

### eToken PRO 4.2B

This is the second public release of the device, that use a proprietary protocol for communication.  These can still (2009) be found on the cheap on EBay or otherwise.

* **USB IDs:** 0529:0600
* **Memory:** 32k
* **Maximum RSA key size:** 2048 bits (it takes a long while to generate one such key, and the LED turns black while it does.  Don't panic!)
* **Crypto chip:** Infineon
* **On-Chip OS:** Siemens CardOS M4.2B

### Aladdin eToken PRO 64k

* **USB IDs:** 0529:0600 Vendor=0529 ProdID=0600 Rev=01.00
* **Memory:** 64k (46506 Free)
* **Maximum RSA key size:** 2048 bits
* **Crypto chip:** (?)
* **On-Chip OS:** CardOS V4.2B (C) Siemens AG 1994-2005
* **ATR:** [3B F2 18 00 02 C1 0A 31 FE 58 C8 09 75](https://smartcard-atr.apdu.fr/parse?ATR=3BF2180002C10A31FE58C80975)

### eToken PRO (Java)

* **Microcontroller:** Atmel AT90SC25672RCT-USB Revision D
* **Memory:** 72KB EEPROM (64~67KB usable?; ~8KB reserved for firmware/patches?)
* **Software (default):** GlobalPlatform v2.1.1, Java Card v2.2.2, Athena OS755 IDProtect v0106.x.x, Aladdin eToken Applet v1.x
* **USB IDs:** 0529:0620
* **ATR:** [3B D5 18 00 81 31 3A 7D 80 73 C8 21 10 30](https://smartcard-atr.apdu.fr/parse?ATR=3BD5180081313A7D8073C8211030)
* **FIPS:**
  * 140-1 Level 2 for USB and smart card versions.
  * 140-1 Level 3 for HD (hardened) USB versions.

#### Supported Cryptographic Services

* **Random Number Generator:** DRNG (ANSI X9.31 two key TDES deterministic RNG seeded with the hardware RNG)
* **Message Digests:** SHA-1, SHA-256
* **Signatures:** RSA PKCS#1 (1024- to 2048-bit in 32-bit increments)
* **Ciphers:** TDES (112- and 168-bit ECB and CBC), TDES MAC (vendor affirmed), AES (128-, 192- and 256-bit ECB and CBC), RSA (1024- to 2048-bit in 32-bit increments)
* **On-Card Key Generation:** RSA PKCS#1 (1024- to 2048-bit in 32-bit increments)
* **Key Establishment:** RSA (1024- to 2048-bit in 32-bit increments [strength 80-bits for RSA 1024 to 112-bits for RSA 2048])

There seems to be three different physical versions available: the regular PRO, the PRO HD (a hardened version offering additional physical security compliant with FIPS 140-1 Level 3 requirements), and the PRO SC (a smart card). However, differentiating between the PRO and PRO HD is difficult, as there is little info specific to the HD version available online, and the image used in the FIPS Security Policy documents is identical for the PRO and PRO HD.

### eToken NG-OTP

This device (and the others below) are compliant with the USB CCID (Chip/Smart Card Interface Devices) standard. As such, they don't require a proprietary driver to work with OpenSC.

* **USB IDs:** (?)
* **Memory:** (?)
* **Maximum RSA key size:** (?)
* **Crypto chip:** (?)
* **On-Chip OS:** Siemens CardOS M4.20 (?)

## Support

Aladdin is maybe the oldest player in the USB token field, and their hardware and software predates the standards such as CCID and  PKCS#15, so you can't really blame them for not conforming to these standards (especially for older token hardware).
See also the *Thanks* section below, they are a fair player!

Aladdin has an SDK with Documentation on their ftp server for public download, but to implement the OpenSC driver further documentation was necessary (by Siemens and available only under NDA as far as we know).

### CardOS-based versions

CardOS versions up to and including M4.20 are supported. (Is CardOS M4.3b also working?)  This includes all the CardOS-based token versions listed above except the evaluation boards.  In order to make these work with OpenSC, one has to install the proprietary middleware; the proprietary key manager is not needed.
See [below](#installation-notes).

One minor misfeature of the Siemens CardOS M4 is that an RSA key cannot be used for both signing and decryption. OpenSC has implemented a workaround: software key generation and storing that key twice, once marked as decryption key and once marked as signing key. To enable this workaround specify "--split-key" on the command line, when creating the key.

## Installation Notes

Aladdin provides their own software, which comprises both the middleware (necessary for all CardOS-based tokens) and the key-management tool which is not compatible with PKCS#15.
(However, as long as enough memory is available on the chip, it is possible to initialize the token with both OpenSC and this proprietary key manager, and thus install files and keys side by side - each software can then only handle their own structures.)

### Mac OS X

Download the [ftp://ftp.aladdin.com/pub/etoken/PKI%20Client/PKI_Client_4_55_Mac/eToken_PKI_Client_4_55_Mac.zip] PKIClient 4.55 software package (link outdated).
If you are only interested in the middleware (and not the proprietary key manager), don't install everything at once; rather, follow these steps:

1. unpack and mount the `pkiclient.4.55.41.dmg` file
2. explore the `eToken PKI Client 4.55.mpkg` directory on it (Ctrl-click then `Show package contents`), then open `Contents` and `Packages`
3. double-click on the following packages in this order so as to install them:

* `etokenframework.pkg`: those are the shared libraries (that will go into `/Library/Frameworks/eToken.framework`) needed by all the other packages;
* `etokendriversleopard.pkg` (for Mac OS 10.5.x) or `etokendriverstiger.pkg` (for Mac OS 10.4.x): this is the middleware, that goes under `/usr/libexec/SmartCardServices/drivers/eTokenIfdh.bundle/` .  It consists of an auxiliary daemon that will be run by `pcscd` in order to perform the necessary USB I/O.

To test this setup, plug your token in, then open a terminal and type the following commands:

```bash
sudo killall pcscd
sudo /usr/sbin/pcscd -a -d -f
```

The `pcscd` should start chatting, and the diode on the token should turn on.
If `pcscd` instead says:

```bash
Error loading /usr/libexec/SmartCardServices/drivers/eTokenIfdh.bundle/Contents/MacOS/eTokenIfdh:  dlopen(/usr/libexec/SmartCardServices/drivers/eTokenIfdh.bundle/Contents/MacOS/eTokenIfdh, 262)
```

it means that the middleware is correctly installed, but `etokenframework.pkg` is not.
This happens when one installs the former first. In that case, run the `Uninstall eToken PKI Client 4.55` program from the .`dmg` image and start over.

### Linux

The middleware for Linux is available here:  [ftp://ftp.ealaddin.com/pub/etoken/Linux] (link outdated); and a third party provides the "key-management tool for Linux (you don't need the latter if you just want your token to work with OpenSC).

## Thanks

Big thanks to [Aladdin](http://www.aladdin.com), they sponsored an OpenSC workshop in 2003 by donating 30 Aladdin eToken PRO!

Big thanks to [Startcom](http://www.startcom.org) and Eddy Nigg for lots of time and support in adding support
for the Aladdin eToken PRO 64, for lots of testing and for donating one to us.

Big thanks to [ASW](http://www.aswsyst.cz/), they donated two Aladdin eToken PRO 64, so we could test our support for
those Tokens (not yet released, will be included in the next release).

Big thanks to Josef Gillhuber from [Aladdin](http://www.aladdin.com). He donated two eToken PRO (32k and 64k) on LinuxTag 2006.

Thanks to Roman Stahl, he donated two Aladdin eToken PRO 32k (4.2B), so we could verify the functionality.
