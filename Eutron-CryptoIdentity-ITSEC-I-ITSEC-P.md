# Eutron CryptoIdentity ITSEC-I & ITSEC-P

[Eutron](https://eutron.com/) offered the CryptoIdentity ITSEC-I & ITSEC-P, an USB readerless smart card / crypto token with 32k memory and support for RSA keys up to 1024bit key length.

The CryptoIdentity ITSEC-I & ITSEC-P is fully supported by OpenSC, but has not been tested for a while.

Note that Eutron also offers two other crypto tokens in the CryptoIdentity line, but those
are not supported at all (no documentation available); combo models are also available
offering USB flash memory mass-storage functionality in addiction to smart card features.

The smart card inside is an Infineon Chip with the [Siemens CardOS M4](Siemens-CardOS-M4) smart card operating system ITSEC-I model) or Philips Chip with the [wiki:STARCOS StarCOS SPK 2.3/2.4] operating system (ITSEC-P, model).
The driver is called "etoken" because this was the first device with that smart card that was tested with OpenSC. Only the usb
interface differs, the rest seems to be the same.

One minor feature of the Siemens CardOS M4 is, that a RSA key cannot be used for both signing
and decryption. OpenSC has implemented a workaround: software key generation and storing that
key twice, once marked as decryption key and once marked as signing key. To enable this workaround
specify `--split-key` on the command line, when creating the key.

Eutron has their own software for Windows. This software does not implement PKCS#15 and thus is not
compatible with OpenSC. As long as the card has memory, you can initialize the card with both software
packages, and thus install files and keys side by side - each software can only handle their own structures.

Documentation was not necessary, as the driver for the smart card inside was already implemented.

However there is no official tool to format a token (for example if you lock it up by accident), you must contact Eutron in this case.

For price and availability, please contact Eutron directly.

## Thanks

Big thanks to Eutron, they donated several tokens and a sim card reader. We are working on
improving our support for the cards. Thanks!
