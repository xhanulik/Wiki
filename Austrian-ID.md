# Austrian ID Cards

> The Austrian Bürgerkarte was a virtual ID card, served as a legally valid electronic signature on the internet and was equivalent to a handwritten signature.
> It was replaced by the ID Austria in December 2023.
> Further information can be found at [ID Austria](https://www.bmf.gv.at/en/topics/digitalisation/Digitised-Austria/ID-Austria.html).

Austria has several laws for smart cards (most important the "Signaturgesetz"), and all cards conforming to those laws are using the custom-built
[ACOS (AUSTRIACARD’s Operating System)](https://www.austriacard.com/digital-security/solutions/card-solutions/acos-id/) (not to be mixed with [ACOS5](ACOS5) from ACS).
Mostly electronic banking cards (Bankomatkarte) with a new chip and the "a-sign premium" logo on the back can be used to add an official certificate to it.
These certificate can then be used for several government communications (tax reports, electronic receiving of orders, bank logins etc).

[A-Trust](http://www.a-trust.at), the only accredited provider of certificates suitable for the Signaturgesetz (some further [software for downloading](https://www.a-trust.at/de/Support/Downloads/)).

The card itself does not have a PKCS#15 structure on it (will thus need emulation code) and OpenSC only has rudimentary low level support for ACOS cards, meaning it can't be used for anything crypto.

## Austrian e-card

* [Information about the "e-card"](http://www.chipkarte.at)
* [Wikipedia Information](http://de.wikipedia.org/wiki/Elektronische_Gesundheitskarte#e-card_in_.C3.96sterreich)
* [ID Austria at Austria Government](https://www.oesterreich.gv.at/id-austria.html)
