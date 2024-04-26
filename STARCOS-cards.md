# STARCOS cards

STARCOS is a card operating system family from [Giesecke & Devrient](https://www.gi-de.com/en/digital-security/identity-technology/enterprise-security/signature-card).

## Versions

### Version 2.3

Version 2.3 is supported by OpenSC (to be precise: iKey 3000 which contains Starcos).
The StarKey 100 (USB) token from G&D  doesn't seem to work. It features Starcos SPK 2.3, but adding
usb:096e/0005 to the ikey3k driver ids in `openct.conf` still won't access the card.

### Version 3.0

Version 3.0 is supported by the OpenSC Starcos driver.

### Version 3.1

There also seems to be Version 3.1 which only does ECC signatures instead of RSA. This is not yet supported by OpenSC as well.

G&D is a very nice company, their APDU manuals are public available, all you need to do
is send an email asking for them, and they send you the latest version. This is great!
Thanks G&D!

### Version 3.2

This OS version is used in the current (2010) signature cards (Card 3.2, MCard 3.2, MCard100 3.2) offered by SignTrust. It appears to support RSA up to 2048b key length.

### Version 3.4

Initial support for German D-Trust cards is available from the patch in [pull request #357](https://github.com/OpenSC/OpenSC/pull/357).

### Version 3.5

Supported since [pull request #1272](https://github.com/OpenSC/OpenSC/pull/1272)

## Erasing cards

Only test cards with StarCOS are erasable. If the last byte of the return
value of `opensc-tool -s 80:f6:00:01` is 0x00 the card is afaik not
erasable, if it's 0xc0 it should be erasable.

[Eutron CryptoIdendity ITSEC-P](Eutron-CryptoIdentity-ITSEC-I-ITSEC-P) tokens contain normal cards and thus are not erasable.
