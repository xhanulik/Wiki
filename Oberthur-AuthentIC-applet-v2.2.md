# Oberthur AuthentIC applet v2.2

The _"oberthur"_ driver supports Oberthur 64k JavaCards in the Versions v4/2.1.1, v5 and v5/2.2.0 and CosmopolIC v5.2/2.2,
that contains applet AuthentIC v2.2.

The driver was written by Viktor Tarasov of OpenTrust. Thanks for donating this driver!

The driver implements pkcs15 and pkcs15init emulation. It means that the OpenSC support is compatible with the native Oberthur's middleware: the cards initialized in one middleware will be recognized by another; the crypto objects created in one middleware will be usable in another.

## Oberthur applet AuthentIC v3.1

Oberthur's card on the _"CosmopolIC v7"_ platform with applet _"AuthentIC v3.1"_ is supported in the [[IAS/ECC branch|IAS-ECC]] of OpenSC.
For this card IAS/ECC branch implements the GlobalPlatform secure messaging (SPC01).

## Oberthur Cosmo JavaCards

Oberthur also provides generic blank JavaCard-s that work with a supported open source applet.
