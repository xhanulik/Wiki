# Finnish FINeID

The FINeID cards are available to the private citizens and organizations.
All the new personal identity cards are FINeID cards and they are applied from the police.
(The eid certificates are also available to some banking cards and mobile SIM cards)

The eid certificates are issued by the Population Register Centre (VRK).
Naturally, one cannot alter the eid certificates and keys on the cards.

There are two generations of the Finnish eid cards.
OpenSC should work fine with the eid application following the version 1.x specification that is using a PKCS#15 file structure.
The version 2 of the eid specification address the ISO/IEC 7816-15 file structure and somewhat different command parameters to the version 1 specification.

The support for the FINeID is implemented in [`card-setcos.c`](https://github.com/OpenSC/OpenSC/blob/master/src/libopensc/card-setcos.c) driver.
Refer there for the ATRs of supported cards.

The eid application has two PIN codes, one for the identification/encryption
and the other for the signing operations.

The FINeID cards allow storing extra data (say, home-made PKI keypairs).

## References

* [HST wiki](http://linux.fi/wiki/HST)
* [About cards and certificates on The Finnish Digital Agency](https://dvv.fi/tietoa-varmenteista)
