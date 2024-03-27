# AKiS cards

> The driver for AKiS cards was removed due to no user or developer activity. For further use, the driver needs to be pulled from git history.

AKiS is a smart card operating system which can be used in personal identification, digital sign, health care system, smart logon, secure email, etc.
It is developed within The National Research Institute Of Electronics And Cryptology ([UEKAE](http://www.uekae.tubitak.gov.tr/en/)), a subsidiary of The Scientific & Technological Research Council of Turkey ([TUBITAK](http://www.tubitak.gov.tr/)).

How AKiS works:

* communicates with the PC via card reader according to ISO/IEC 7816-4 T = 1 protocol,
* implements user and interface authentication,
* is capable of binary file operations (open, write, read),
* supports fixed length linear, variable length linear, fixed length cyclic file structures and file operations (open, write record, read record),  
* follows the  life cycles (activation, manufacturing, initialization, personalization, administration, operation and death) and operates functions according to the present life cycle,
* encrypts, decrypts, digitally signs and verifies with RSA (2048)/DES/3DES cryptographic algorithms,
* calculates SHA-1 hash.
* has Common Criteria EAL4+ assurance level.

AKiS support OpenSC featured file level access (select, list, read, write, create, delete, verify), digital signing, and PKCS-15 support (except pkcs15-init).
