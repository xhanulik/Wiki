# Estonian eID (EstEID)

OpenSC is part of the official software for the Estonian eID card for non-CryptoAPI platforms as well as PKCS#11 provider on all three supported platforms: Windows, Mac OS X, Linux/BSD/*nix. The source code used for the official software comes unmodified from OpenSC SourceCode repository. The card is without PKCS#15 structures (as the card layout was created before PKCS#15 existed) and is read-only synthesized card from OpenSC perspective.

From the public administration point of view the card has been procured by the [Ministry of Interior](http://www.siseministeerium.ee/), is issued by [Police and Border Guard Board](http://www.politsei.ee), is manufactured by Trüb (Trüb Baltic AS) and software has been procured by [Ministry of Economic Affairs and Communications (RIA)](https://www.ria.ee/?lang=en), the current actual contractor being [AS Sertifitseerimiskeskus](https://www.skidsolutions.eu/).

Resources:

* The official home page for the Estonian eID card is [http://www.id.ee](http://www.id.ee).
* **Software can be downloaded from [installer.id.ee](installer.id.ee).**
* Contact [Martin Paljak](http://martinpaljak.net) with any issues and questions regarding EstEID support in OpenSC and other open source software.
* No end-user troubleshooting.
* The eID card and surrounding infrastructure is a key component in the e-voting system. OpenSC PKCS#11 is used for card access on non-windows platforms (Linux, OS X).

## Card capabilities

Estonian eID card is based on [MICARDO](MICARDO-2.1) card driver or a MULTOS application ("Digi-ID") or JavaCard applet ("year 2011 new ID card") mimicking Micardo.

This is what is present on the version 1.0 card (Isikutuvastus = authentication, Allkirjastamine = non-repudiation digital signature):

```bash
$ pkcs15-tool -D
Using reader with a card: SCM SPR 532 00 00
PKCS#15 Card [MARTIN PALJAK]:
	Version        : 2
	Serial number  : A1528610
	Manufacturer ID: AS Sertifitseerimiskeskus
	Flags          : Read-only, PRN generation, EID compliant

PIN [PIN1]
	Com. Flags: 0x0
	ID        : 01
	Flags     : [0x00]
	Length    : min_len:4, max_len:12, stored_len:12
	Pad char  : 0x00
	Reference : 1
	Type      : ascii-numeric
	Path      : 
	Tries left: 3

PIN [PIN2]
	Com. Flags: 0x0
	ID        : 02
	Flags     : [0x00]
	Length    : min_len:5, max_len:12, stored_len:12
	Pad char  : 0x00
	Reference : 2
	Type      : ascii-numeric
	Path      : 
	Tries left: 3

PIN [PUK]
	Com. Flags: 0x40
	ID        : 03
	Flags     : [0x40], unblockingPin
	Length    : min_len:8, max_len:12, stored_len:12
	Pad char  : 0x00
	Reference : 0
	Type      : ascii-numeric
	Path      : 
	Tries left: 3

Private RSA Key [Isikutuvastus]
	Com. Flags  : 1
	User consent: no
	Usage       : [0x3F], encrypt, decrypt, sign, signRecover, wrap, unwrap
	Access Flags: [0x1D], sensitive, alwaysSensitive, neverExtract, local
	ModLength   : 1024
	Key ref     : 1
	Native      : yes
	Path        : 
	Auth ID     : 01
	ID          : 01

Private RSA Key [Allkirjastamine]
	Com. Flags  : 1
	User consent: yes
	Usage       : [0x200], nonRepudiation
	Access Flags: [0x1D], sensitive, alwaysSensitive, neverExtract, local
	ModLength   : 1024
	Key ref     : 2
	Native      : yes
	Path        : 
	Auth ID     : 02
	ID          : 02

X.509 Certificate [Isikutuvastus]
	Flags    : 0
	Authority: no
	Path     : 3f00eeeeaace
	ID       : 01

X.509 Certificate [Allkirjastamine]
	Flags    : 0
	Authority: no
	Path     : 3f00eeeeddce
	ID       : 02
```

## Known ATR-s

* Supported ATRs are listed in `card-mcrd.c` and `card-esteid2018.c`.

## Supported algorithms

* Version 3.0 suports PKCS1 padding and SHA1, SHA-224 (not used as PKCS#11 does not support SHA-224 in v2.20) and SHA-256 hashes with 2048bit RSA keys

## Known issues and incompatibilities

* Application selection, ATR and other generic issues not directly from EstEID application.
  * First 46 issued version 3.0 cards had several problems (missing EstEID application) and were recalled ([source (in Estonian)](http://www.postimees.ee/?id=373211))
  * Version 3.0 cards have the same problem as version 1.1 cards: they happily answer with 0x9000 to all AID selection APDU-s (similar to v1.1 cards, without the "Record not found" extra feature)
* Application issues  
  * Version 3.0 cards react to undocumented APDU-s. For example, once the CAC.tokend on Mac OS X has got hold of the card (after it answers with 0x9000 to the CAC Applet selection) it tries to probe the status of CHV0 by issuing 80:20:00:00 APDU (ISO VERIFY with a proprietary CLA byte) to the card. Version 1.0 and 1.1 cards reject this APDU (either "Wrong CLA" or "Incorrect length") but version 3.0 card decreases the PIN counter and answers with "incorrect reference data" (0x6984), which causes the built-in CAC.tokend to re-try the CAC AID selection (which succeeds) and repeat the CHV0 status request (fails) until the PIN with reference 0 (PUK for EstEID cards) gets blocked.
  * Version 3.0 cards decrease the PIN counter and respond with 0x6984 to incorrect input PIN lengths, which version 1 card responds with 0x6A80 ("incorrect data in command field") and Version 1.1 card correctly responds with 0x63CX and decrease the retry counter.
  * Version 3.0 cards respond with 0x630X for failing PIN verifications instead of 0x63CX like other cards (and ISO standard). This breaks most standard software.
  * Version 1.0 and 1.1 cards require any new PIN (when changing or unblocking a PIN code) to be different from the on-card PIN. This is not the case with v3.0 cards.
  * Version 3.0 cards respond with a double 0x62 FCI tag to a SELECT FILE, which causes problems for parsing the response. This breaks tag parsing.
  * Version 1.1 and 3.0 cards respond to key operations (like INTERNAL AUTHENTICATE) if the required PIN has not been verified with 0x6985 "Conditions of use not satisfied" instead of 0x6982 "Security status not satisfied". This breaks standard PIN caching code.
  * Version 3.0 cards have the personal data file (3F00/EEEE/5004) records padded with spaces. Version 1.0 cards have the records with the exact length.
