# Resources, Links

## Standard Documents

Smart cards are defined in ISO 7816 standards. You need to buy those from ISO,
but [some pages](http://www.ttfn.net/techno/smartcards/standards.html)
have overviews on what is in those standards. There is a [PDF preview (90 pages)](http://webstore.iec.ch/preview/info_isoiec7816-4%7Bed2.0%7Den.pdf) available from IEC.ch Webstore.

[PC/SC Workgroup](https://pcscworkgroup.com/)
defines the PC/SC standard that is used on windows, but
thanks to PC/SC-Lite software also on Linux, Mac OS X and BSD.
You can [download](https://pcscworkgroup.com/specifications/download/)
all parts of the specification.

Important standards are:

* [PKCS #15](https://www.usenix.org/legacy/publications/library/proceedings/smartcard99/full_papers/nystrom/nystrom_html/index.html): Cryptographic Token Information Format Standard
* [PKCS #11](https://docs.oasis-open.org/pkcs11/pkcs11-curr/v2.40/os/pkcs11-curr-v2.40-os.html)l: Cryptographic Token Interface Standard
* [PKCS #7](https://datatracker.ietf.org/doc/html/rfc2315): Cryptographic Message Syntax Standard

Personal Identification Cards (PIV) it an upcoming standard in the USA. NIST has a
[document](https://csrc.nist.gov/pubs/fips/201-3/final) with details.

## Software

[OpenCT](http://www.opensc-project.org/openct/) implements drivers for
several smart card readers. OpenSC can use OpenCT directly without the
need for an additional middleware, and this combination is preferred by
some authors and tested all the time, works perfectly.
