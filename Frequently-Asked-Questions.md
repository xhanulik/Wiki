# Frequently Asked Questions

## Generic concepts

### What is PKCS#11?

PKCS#11 is a software API for accessing cryptographic hardware like smart cards or [HSM](http://en.wikipedia.org/wiki/Hardware_security_modules). PKCS#11 is *not* a hardware standard or hardware interface.

Links:

* [PKCS #11 on Wikipedia](https://en.wikipedia.org/wiki/PKCS_11)
* [PKCS #11 Cryptographic Token Interface Base Specification Version 3.0](https://docs.oasis-open.org/pkcs11/pkcs11-base/v3.0/pkcs11-base-v3.0.html)

### What is PKCS#15

PKCS#15 is a format of on-card structures that defines a "filesystem layout" for smart cards. PKCS#15 does not define how those structures are generated or written to the card.

Links:

* [PKCS #15-A Cryptographic-Token Information Format Standard](https://www.usenix.org/legacy/publications/library/proceedings/smartcard99/full_papers/nystrom/nystrom.pdf)

### Can I use PKCS#15 and PKCS#11 simultaneously?

Most probably. The two standards do not conflict with each other. A PKCS#15 compatible smart card may not have a PKCS#11 module for platform X or a smart card might come with a PKCS#11 provider for platform X but format data on the card differently than PKCS#15 defines.

### I have a PKCS#11 compatible smart card. Can I use it with OpenSC?

Not necessarily. PKCS#11 is a software interface, it means the vendor provides a PKCS#11 module with their hardware. You can use all [PKCS#11 compatible software](Using-smart-cards-with-applications) with the vendor PKCS#11 provider. If your card is also supported by OpenSC, you can use the OpenSC PKCS#11 provider, but you may not be able to:

* modify the card content,
* use keys created by OpenSC with the vendor PKCS#11 provider and vice versa.

### I have a blank smart card which claims PKCS#15 support. Can I initialize it with OpenSC?

Only if a pkcs15-init driver exists for the card. PKCS#15 defines how to look for objects, it does not define how the objects get written to the card.

### My smart card comes with a PKCS#11 module. Do I need OpenSC?

No, unless you want your software to be open source or if your vendor does not provide a binary PKCS#11 module for you operating system or platform (for example ARM Linux).

## Smart card reader issues

### Do I need OpenCT to use OpenSC?

No, unless you are using Linux and an USB token or exotic reader which is not CCID compatible, comes without a driver for pcsc-lite and at the same time is supported by OpenCT. The recommended method for accessing smart card readers is PC/SC and thus pcsc-lite.

### I have installed OpenSC, OpenCT, pcsc-lite and ccid and I'm having troubles connecting to my CCID compatible reader

The preferred access method for CCID readers is via pcsc-lite. You have installed two CCID drivers which may compete for resources. You should remove OpenCT.

### I'm using Ubuntu/Debian and OpenSC does not find any PC/SC readers (but pcsc_scan does)

The location of `libpcsclite.so.1` is wrong in OpenSC, which has been fixed in OpenSC SVN ([Ubuntu bug](https://bugs.launchpad.net/ubuntu/+source/opensc/+bug/380936), [Debian bug](http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=531592)). The quick fix to edit `opensc.conf`:

```text
provider_library = libpcsclite.so.1
```

### I have a smart card reader installed but a Java application does not see it

Java looks for smart card readers via `/usr/lib/libpcsclite.so`, which is not present on Debian/Ubuntu. You need to create a symlink, depending on your distribution:

```bash
sudo ln -s /lib/libpcsclite.so.1 /usr/lib/libpcsclite.so      # For Ubuntu
sudo ln -s /usr/lib/libpcsclite.so.1 /usr/lib/libpcsclite.so  # For Debian</code></pre>
```

## Card support / card driver related

### What does "Unsupported INS byte in APDU" mean?

It is a very technical way of saying "Your card is unsupported".

### How can I verify that my card is supported by OpenSC?

Check the [list of supported hardware](Supported-hardware-(smart-cards-and-USB-tokens)). Verify it with `opensc-tool --name` to see if some driver knows how to handle your card. The expected result of the command is a line with a card driver name.

### What does "read only support" mean?

Read-only mode means that OpenSC can be used to use the keys and certificates present on the card but new keys or certificates can not be loaded by OpenSC. PIN codes can still be changed.

### What to do if my card is not supported by OpenSC?

Somebody needs to write a driver for it. You can start by sending as much information as you can about the card to [opensc-devel mailing list](Mailing-lists). Be sure to send the card ATR by sending the output of `opensc-tool --atr`.

## Application support questions

### Is it possible to make GDM automatically ask for the PIN when a card is inserted?

Currently no.

### Can I store my GnuPG key on a smart card? Can I use gnupg with OpenSC?

GnuPG supports OpenPGP card in a direct fashion. That support has nothing to do with OpenSC or PKCS#11. There also exists a PKCS#11 based solution for GnuPG, see [gnupg-pkcs11](https://gnupg-pkcs11.sourceforge.net/) and [gnupg-pkcs11-scd](https://github.com/alonbl/gnupg-pkcs11-scd) for more information.

### Do I need to install both OpenCT and OpenSC ?

OpenSC does not depend on OpenCT. Unless you have a USB token that does not support ICCD or CCID, you don't need OpenCT.

## Mac OS X related questions

### I want to use my smart card on OS X but the system asks me for some password instead of PIN?

OS X apparently always uses "Enter password for Keychain `keychainname`". The "name" for you token can be seen with `pkcs15-tool -D`.

## Miscellaneous questions

### Do you have a privacy policy?

OpenSC will not transfer any information to other networked systems unless specifically requested by the user or the person installing or operating it. Debug information enabled via opensc.conf may contain personal identifying data, such as X.509 certificate data, which you may want to remove before submitting a bug report.

### Where can I buy smart cards ?

* [https://www.javacardos.com](https://www.javacardos.com/store/) - dedicated to building a comprehensive Java Card platform.
* [http://www.aventra.fi](http://www.aventra.fi) - ships from Finland, [Aventra-MyEID-PKI-card](Aventra-MyEID-PKI-card) card
* [http://www.cryptoshop.com](http://www.cryptoshop.com) - ships from Austria
* [http://shop.kernelconcepts.de/](http://shop.kernelconcepts.de/) - ships from Germany, [OpenPGP v2 card](OpenPGP-card) and CryptoStick token
* [http://www.logidata-int.fr](http://www.logidata-int.fr) - ships from France
* [http://www.smartcardfocus.com](http://www.smartcardfocus.com) - ships from UK
