# Feitian ePass2003

[Feitian](http://www.ftsafe.com/) offers the ePass2003, a USB crypto token with high performance smart card chip and CCID interface.

The ePass2003 is the successor of the ePass PKI and the ePass3000, and was released to the public in December 2011.
The ePass2003 relies on one single ST Microelectronics chip, designed in Europe with Common Criteria EAL 5+ certification.
It weights only 6 gr and fits very well into a key ring with only 53 mm length, thus being one of the smallest tokens available to date.

The ePass2003 was designed for Free Software communities, especially the OpenSC community to provide a “universal” cryptographic token.

Feitian offers Windows CSP drivers and also provides Linux and Mac OS X drivers.

On the other hand, Feitian takes an active part in the development of OpenSC, offering a free software driver to the OpenSC community. The driver of ePass2003 in OpenSC is called “epass2003”.

This gives users the ability to use either proprietary or open-source software, which is the best to answer all needs. For example, under Windows7, drivers(Microsoft Minidriver) are distributed using Windows update, requiring no actions from users.

Links:

* [Product page](http://ftsafe.com/products/PKI/Standard)
* [Buy samples](https://www.ftsafe.com/onlinestore/index)

## Setting up the token

The token can be set up using standard OpenSC tools, such as `pkcs15-init`. The token is using default transport keys (unless changed) so we can start with erasing the card:

```bash
$ pkcs15-init -E -T
```

After that we need to create the PKCS#15 filesystem and PINs:

```bash
$ pkcs15-init --create-pkcs15 -T -p pkcs15+onepin --pin 123456 --puk 12345678
```

To generate RSA key pair on the token:

```bash
$ pkcs15-init --generate-key rsa/2048 -l "RSA2k key" -a 01 -i 01 --so-pin 12345678 --pin 123456
$ pkcs15-init --generate-key rsa/2048 -l "RSA2k encryption key" -a 01 -i 02 --pin 123456 --key-usage decrypt
```

The newer tokens support also Elliptic curves. To generate a EC key, use the similar command:

```bash
$ pkcs15-init --generate-key ec/prime256v1 -a 01 -i 03 --pin 123456
```

The driver also supports loading existing keys to the token with the following command:

```bash
$ pkcs15-init --store-private-key rsa-key.pem -a 01 --key-usage sign,decrypt --pin 123456
```

## FAQ

For users which get the error "*Failed to erase card: Security status not satisfied*" while erasing card, please download `fix-tool` from below. After running `fix-tool` as root, please do remove and re-plug the token/card.

Refer to issue [#1803](https://github.com/OpenSC/OpenSC/issues/1803);

Links to the `Fix_Tool.tar.gz` archives:

* With x86 and x64: [Download fix_tool](http://download.ftsafe.com/files/ePass/Fix_Tool.tar.gz)
* With armhf arch: [Download fix_tool](http://download.ftsafe.com/files/reader/SDK/Fix_Tool_20200604.zip)

## Thanks

Big thanks to GOOZE and [Feitian](http://www.ftsafe.com/), for their technical help and donating hardware tokens.
