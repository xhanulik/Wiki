# EMV (Europay, Mastercard, VISA)

> OpenSC does not support EMV cards!

OpenSC versions before v0.12 included a dummy EMV driver. EMV cards (bank cards with a chip) are usually not capable of doing crypto operations, unless they have support for DDA (Dynamic Data Authentication). Not many cards, even if issued recently, support DDA.
