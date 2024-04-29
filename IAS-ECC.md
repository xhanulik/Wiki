# IAS-ECC

The French trade association for electronic components, systems, and smart card industries, GIXEL, created a common smart card specification IAS-ECC (*Identification Authentication Signature – European Citizen Card*) that will be used to develop the next French National Identity Card.

IAS-ECC cards comply with the *Advanced Electronic Signature* EU Directive 1999/93/EC and the [European Citizen Card](https://standards.iteh.ai/catalog/tc/cen/d27d3c52-5f23-454c-95f3-ae219c3c817f/cen-tc-224-wg-15) specification initially created by CEN in June 2007 to ensure interoperability of e-Services cards throughout Europe. The interoperability of the cards means that every card is compatible with all IAS-ECC middleware, including middleware developed for the French government.

The base of the IAS-ECC technical specification contains multiple ISO-7816 series, including ISO-7816-15. The specification anticipates the coexistence of multiple cryptographic card (PKCS#15) applications. (see Note 01).

## Support of IAS-ECC cards in OpenSC

* IAS/ECC card manufacturer independence
* compatibility with existing IAS/ECC card middleware
* independence from personalization profile in card usage and easy configuration for the particular personalization profile in card administration
* secure messaging for the administration of "protected" applications, "*Qualified Signature*" and PIN operations
* PIN-pad support
* support for *External Authentication*

## Currently supported cards

* Gemalto *MultiApp ID IAS ECC*
* Oberthur *ID-ONE IAS-ECC*
* Sagem *ypsID S3 IAS/ECC - PKCS#15*
* Oberthur *COSMO v7* with PKI applet *AuthentIC v3*
* Amos *IOP-V6 IAS/ECC*
* IAS/ECC cards with three *Adele* profiles (from Gemalto)

> Gemalto becomes [Thales](https://www.thalesgroup.com/en/canada/press-release/thales-completes-acquisition-gemalto-become-global-leader-digital-security).

The IAS/ECC card from Gemalto [thoroughly implements](IASECC-card-from-Gemalto) specification [IAS/ECC v1.0.1](https://dvv.fi/documents/16079645/17324992/IAS+ECC+v1_0_1UK.pdf). The card is formatted *with generic PKI* application and SM protected application *eID*.

IAS/ECC card from Oberthur is formatted with one *generic PKI* application.

The "ypsID S3 IAS/ECC - PKCS#15" is the multi-application card from Sagem and contains two profiles, *Generic* and protected *ECC-eID*. The second one contains one slot for the *Qualified Signature*.

Oberthur's Java-card "COSMO v7" with PKI applet "AuthentIC v3" is not an IAS/ECC card, but native format of this card, [[based on PKCS#15 specification|Oberthur_AuthentIC_v3]], is not far from the IAS/ECC.
*Global Platform* Secure Messaging can be used to protect the access to the on-card objects.
One of the motivations to support this card here is an attempt to generalize implementation of *SM* and *External Authentication* - both differ from the definitions in the IAS/ECC specification.

IAS/ECC cards with "Adele" profiles are not general purpose cards. They were produced for the interoperability tests of the IAS/ECC cards and middleware from the different producers.

Tested compatibility with the PKCS#11 and CSP from the other middlewares:

* *IAS ECC Middleware v2.0.20* from [ANTS](https://ants.gouv.fr/nos-missions/les-solutions-numeriques/identite-numerique)
* *Classic Client 6.2 005* from Gemalto
* *AWP 4.4* from Oberthur
* *Smart Security Interface 4.9.1* from Charismathics

## To get the source code for SM

**Not active project, changes already integrated in standard OpenSC distribution**

```bash
git clone https://github.com/viktorTarasov/OpenSC-SM.git
# use 'secure-messaging' branch
```

## References

* [IAS/ECC v1.0.1 specification](https://dvv.fi/documents/16079645/17324992/IAS+ECC+v1_0_1UK.pdf)

## Notes

For the interoperability tests, the three IAS/ECC card producers have used 'Adele personalization profiles' where three profiles are defined. For the first *Generic* profile, the administration and usage of the cryptographic objects is protected by User PIN. For the next two profiles, *Administration-2* and *Administration-1*, all operations that change the card content are protected by *Secure Messaging*. The *Administration-1* application holds the non-repudiation sign key for which the 'COMPUTE SIGNATURE' operation is protected by *Sign PIN* and *Secure Messaging*.
