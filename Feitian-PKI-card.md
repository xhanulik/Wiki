# Feitian PKI card

[Feitian](http://www.ftsafe.com/) offers the "ePass PKI token", also called Feitian FTCOS/PK-01C token.

The Feitian PKI card is a cryptographic smartcard, which complies which PKCS#15 and ISO 7816 standards and can be used used for:
authentication, electronic signature, email encryption, single logon, VPN, SSL and disc encryption.

The cards comes blank in PVC, so that it can be printed using retransfer printers or offset.

## Technical details

The Feitian PKI card is a recent cryptographic card, with nice and powerful features:

* Support T=0, T=1 or USB communication,
* Ability to generate 1024 bits or 2048 bits RSA key pair,
* Ability to transfer key pairs and X.509 certificates to card,
* Support ISO 7816 compliant cryptographic operations, authentication and access control,
* Support ISO 7816 part 12 contacts USB electrical interface,
* Support cryptographic algorithm of DES, 3DES, MD5, SHA-1, SHA-256, RSA 1024, RSA 2048,
* 64KB data space.

The Feitian PKI is a full PKCS#15 smart card, it is not an emulated device.

## Smartcard reader

The Feitian PKI is compatible with any CCID smartcard reader. No special settings needed.

## OpenSC support

The driver of FTCOS/PK-01C in OpenSC is called "entersafe".
Entersafe is supported in OpenSC 0.11.8 and later version.
Please use newest release of OpenSC 0.12.0.

## Windows support

The Feitian PKI comes with proprietary drivers signed and accepted by Microsoft.

* Full CSP and CAPI drivers for Windows 2000, 2008, XP, Vista and 7.
* Compatible with Windows 32/64bit.
* Full SDK available on the CD.
* Nice and easy utilities to format and manage certificates.

## Cross-system compatibility

For technical reasons, like any other OpenSC card:

* Cards initialized under GNU/Linux are read-only under Windows CAPI/CSP.
* Cards initialized under Windows using Feitian tools are read-only under GNU/Linux.
* Ability to use proprietary drivers in conjunction with OpenSC.

## Free software initiative

In order to broaden support, GOOZE offers free Feitian PKI cards to Free Software developers.
This make the Feitian PKI a really popular smartcard in Free Software communities.
Choosing free software means that whether you are an individual, a middle range company or a large institution, the Feitian PKI will be actively maintained over the next years.

## Availability

Available from: [Feitian PKI card](http://ftsafe.com/).

## Thanks

Many thanks to EnterSafe division of Feitian, for their technical help in adding support for the FTCOS/PK-01C.

## Notes

* Supports a single PIN code.
* Card can be erased (with `pkcs15-init --erase-card`) without any authorization.
* Card requires the use of a PUK code (initialization fails without a PUK code).
