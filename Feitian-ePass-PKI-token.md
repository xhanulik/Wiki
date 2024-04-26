# Feitian ePass PKI token

[Feitian](http://www.ftsafe.com/) offers the "ePass PKI token", also called Feitian FTCOS/PK-01C token.

The Feitian ePass PKI token combines a [Feitian PKI](Feitian-PKI-card) card and a sealed Feitian R-301 CCID reader. Therefore, the token can be used with OpenSC PCSC+CCID standard driver, no need to use any ifup PCSC driver/OpenCT. The driver is fully open source and free software, no binary needed (contrary to the [Feitian ePass3000](Feitian-ePass2003)).

This hardware is mature and can be used in production.

It is a recent cryptographic card, with nice and powerful features:

* Support T=0, T=1 or USB communication.
* Ability to generate 1024 bits or 2048 bits RSA key pair.
* Ability to transfer key pairs and certificates to card.
* Support ISO 7816 compliant cryptographic operations, authentication and access control.
* Support ISO 7816 part 12 contacts USB electrical interface.
* Support cryptographic algorithm of DES, 3DES, MD5, SHA-1, SHA-256, RSA 1024, RSA 2048.

The driver of FTCOS/PK-01C in OpenSC is called "entersafe".

Feitian has their own software for windows, cards written by Feitian can be read by OpenSC, and vice versa.
Since Feitian's software support PKCS11 and windows CAPI, cards written by it can not be written any more by OpenSC, and vice versa.

This product is available as a combination of the Feitian R-301 SIM reader and a Feitian PKI SIM card. This product is exactly the same, except that the PKI SIM can now be extracted and inserted, allowing to change SIM card.

## Thanks

Many thanks to EnterSafe division of [Feitian](http://www.ftsafe.com/), for their technical help in adding support for the FTCOS/PK-01C.
