# Athena ASEPCOS / ASEKey

Athena ASEPCOS smartcards and tokens are supported from OpenSC-0.11.6:

* **ATR:** [ASECard Crypto](https://smartcard-atr.apdu.fr/parse?ATR=3BD6180081B1807D1F038051006110308F): `3B D6 18 00 81 B1 80 7D 1F 03 80 51 00 61 10 30 8F`
* Full PKCS#15 emulation is supported.

Athena cooperates with the OpenSC project and provides any required information.

If you are interested in Athena's tokens (ASEKey), make sure you order the CCID compliant version.

Another issue you may encounter is failure to initialize the PKCS#15 structure.
This may be due to pre-formatted smartcard using Athena proprietary provider.
If you have this issue, ask for help in OpenSC MailingList.

Athena also makes [Java Cards](JavaCards), which require a supported applet.
