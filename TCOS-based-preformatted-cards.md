# TCOS based preformatted cards

![TCOS](./attachments/wiki/TCOS/Card-Images.gif "TCOS")

TeleSec (now part of Deutsche Telekom AG), Deutsche Post and DATEV are german companies that sold TCOS 2 based preformatted cards until 2007, i.e NetKey E4 cards, SignTrust 1024bit cards and DATEV-cards. All these cards had a TCOS 2.03 operating system and an almost PKCS#15 compatible file-layout. OpenSC has read-only support for these kind of cards.

Since late 2006 TCOS 3.0 cards are available from TeleSec and a test card plus excellent doku reached the OpenSC team in december 2006. Besides 2048 bit keys TCOS 3.0 has some other new features. In december 2007 the TCOS 2.0 driver was extended such that it supports TCOS 3.0 cards as well. OpenSC 0.11.5 was the first version that had TCOS3 support.

The 2048 bit NetKey card was named NetKey E4 V3. The signature key of this card can be used only with secure messaging. Since OpenSC does not have support for secure messaging the signature key will not be supported soon. 

If OpenSC would fully support TCOS, one could erase the preformatted card and initialize the card with a fresh PKCS#15 filesystem. This is not possible right now as OpenSC lacks support for initializing a PKCS#15 layout on an empty card with TCOS operation system.

The good news are: With the help of an emulation layer OpenSC can use cards that are almost PKCS#15 compatible. For the above mentioned cards such an emulation layer exists. The emulation cannot store certificates, keys or PINs on the card, but you can use whatever is visible through the emulation layer.

All other trust center that were using TCOS2 cards until the end of 2007 do not offer TCOS based cards anymore. SignTrust now uses [STARCOS](STARCOS) based card and Datev cards are available to members of Datev only (they also use STARCOS now).

## NetKey E4 filesystem layout

NetKey E4 cards contain different applications. Two of them, namely application NKS and application SIGG, are made visible through the NetKey emulation layer. The NKS application contains 3 keypairs (4 on TCOS3-cards), 3 read only certificates, 6 empty certificate files, 2 PINs and one signature-counter. The SigG application contains one keypair that can be used according to german signature law, 1 certificate and 1 PIN. The NetKey emulation layer will show you all these keys and certificates. With TCOS2-cards you can use all of them, with TCOS3-cards you can only use the keys within the NKS application. To use the signature key on TCOS3-cards a secure channel MUST be created and this is something OpenSC does not support yet.

```bash
pkcs15-tool -c
```

will list all certificates. It will not list empty certificate files. Here's the output for my NetKey E4 V3 card:

```bash
$ pkcs15-tool -c
X.509 Certificate [Telesec Signatur Zertifikat]
        Flags    : 0
        Authority: no
        Path     : df02c000
        ID       : 45

X.509 Certificate [Telesec Verschluesselungs Zertifikat]
        Flags    : 0
        Authority: no
        Path     : df02c200
        ID       : 46

X.509 Certificate [Telesec Authentifizierungs Zertifikat]
        Flags    : 0
        Authority: no
        Path     : df02c500
        ID       : 47

X.509 Certificate [Telesec 1024bit Zertifikat]
        Flags    : 0
        Authority: no
        Path     : df02c201
        ID       : 48

X.509 Certificate [SigG Zertifikat 1]
        Flags    : 2
        Authority: no
        Path     : df01c000
        ID       : 49
```

The public-keys on NetKey cards are record-based transparent files and cannot be used for cryptographic operations. They are on the card for convenience only. OpenSC extracts the public keys from the certificates and does not use the public key files.

The Signature-Key can do signature-operations only. All other private keys can be used for decryption- and signature operations.

### How do I store additional certificates into the above mentioned empty certificate-files?

You (and OpenSC) don't see the empty certificate files through the emulation layer. One consequence is that you cannot store your own certificates into these files with pkcs11-tool or pkcs15-init.

You must use opensc-explorer and store the certificate directly into the right position or use `netkey-tool`, a small program, that I wrote exactly for that purpose. Since version 0.7 of SCB `netkey-tool` is contained in the Windows version too. As of march 2009 `netkey-tool` does support NetKey E4 cards only.

In general (and in particular with TCOS-cards) it's a lot more complicated to create a new file on a smartcard than updating an existing one. That's the reason why there are empty certificate files on a NetKey E4 card. They contain 1536 0xFF-bytes and you can overwrite them with your own certificate (if your certificate has at most 1536 bytes).

There is one problem with many PKCS#11 or PKCS#15 smartcard-applications. They assume that the ID of a certificate uniquely identifies the certificate itself. This is wrong as the ID only identifies the private/public keypair that belongs to the certificate. So if you have more than one certificate for the same keypair all these certificates will share the same ID-value. OpenSC has this problem with NetKey cards too. Have a look at the -r option of pkcs15-tool. In order to select a certificate you can only specify its ID and pkcs15-tool will output the first certificate from the card that has such an ID-value.

If you have stored a certificate on your NetKey card, you most likely want to use this certificate (and not the readonly-one). Therefore the emulation will add the user-certificates first into its internal list.

h3. Some remarks about the PINs of NetKey cards

There are two global PINs on TCOS2 based NetKey-cards and some of the directories contain further PINs. TCOS3-based cards are slightly different but since `netkey-tool` does not support TCOS3-cards yet I will not explain the differences.

The NetKey emulation will list the two global PINs (PIN and PUK) and the two local PINs contained in directory DF01 (PIN0 and PIN1). The TCOS card operation system can protect a private key by more than one PIN. OpenSC does NOT support this and will always ask for one specific PIN. If a key is protected by both a global PIN and a local PIN OpenSC will always ask for the local one.

Now that you know that you MUST use local PIN0 or local PIN1 and cannot use your global PIN instead you probably want to know the initial value of those local PINs. But these local PINs were set to a random 6-digit number when TeleSec Gmbh produced your card. So you cannot know them until you changed them.

You can change local PIN0 only if you know either local PIN0 itself or your global PIN. And you cannot change a PIN once it was blocked. So if your local PIN0 is blocked (for example because you provided you global PIN when OpenSC asked you for the local one and you did that for at least three times) then you must unblock it first.

Here's an example about how to unblock your local PIN0, how to change its value to 111111 with your global PIN and then change its value from 111111 to 222222. It assumes that your global PIN is 123456

```bash
netkey-tool --PIN 123456 unblock PIN0
netkey-tool --PIN 123456 change PIN0 111111
netkey-tool --PIN0 111111 change PIN0 222222
```

One more hint: Your global PUK was set to an 8-digit random number at production time of your TCOS2-based NetKey card. This random number is stored on your card in a transparent file. This transparent file is read-protected by your global PIN. If you ever block your global PIN you will need your global PUK. But once your global PIN is blocked you cannot read the initial value of your global PUK anymore.

`netkey-tool --PIN <your_global_PIN>` will print out the initial PUK-value. If you changed your global PUK to some other value the transparent file on your card will still contain the initial value.

`netkey-tool` does not support the SigG application.

## SignTrust layout

The following information applies to 1024 bit SignTrust cards only. 2048 bit SignTrust cards do not contain a TCOS chip but are 3.0 based. Their layout is very similar, but this information won't help OpenSC-users as OpenSC does not support [STARCOS](STARCOS) 3.0 as of may 2011.

SignTrust cards contain three applications (i.e. directories). Each of them contain one certificate, one private key and one PIN.

The signature-key is restricted such that it can create signatures only, the other keys can be used for decryption- and signature operations. There are no empty certificate files on a SignTrust card (as with NetKey cards) so you cannot store your own certificates on a SignTrust card.

The certificate from the signature-application can be used to create SigG (german signature law) conforming digital signatures.
Neither the CA-certificate nor the Root-Certificate is stored on the card.

Here's some output that shows the SigG-certificate of my 1024bit SignTrust card, which expired in 2007:

```bash
$ pkcs15-tool -r 45 | openssl x509 -noout -text -certopt no_pubkey,no_sigdump
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number: 32322 (0x7e42)
        Signature Algorithm: sha1WithRSAEncryption
        Issuer: C=DE, O=Deutsche Post Com GmbH, OU=Signtrust, CN=CA DP Com 5:PN
        Validity
            Not Before: Sep 21 10:19:04 2005 GMT
            Not After : Sep 21 10:19:04 2007 GMT
        Subject: CN=Peter Koch, SN=Koch, GN=Peter, C=DE/serialNumber=1
        X509v3 extensions:
            X509v3 Authority Key Identifier: 
                keyid:22:BB:26:65:07:57:15:DE:06:EB:10:1E:CC:77:82:A7:13:79:74:C6
                DirName:/C=DE/O=Bundesnetzagentur/CN=10R-CA 1:PN
                serial:AE
            X509v3 Key Usage: critical
                Non Repudiation
            X509v3 Certificate Policies: 
                Policy: 1.3.36.8.1.1
            X509v3 CRL Distribution Points: 
                URI:ldap://dir.signtrust.de/o=Deutsche%20Post%20Com%20GmbH,c=de
                CRLissuer:<UNSUPPORTED>
            Authority Information Access: 
                OCSP - URI:http://dir.signtrust.de/Signtrust/OCSP/servlet/httpGateway.PostHandler
```

The remaining certificates (from the authentication and encryption application) are signed by
a selfsigned Root-certificate from Deutsche Post.

## University cards

There are two universities in Germany (that I know of) which use TCOS2-cards. These cards have their own layout and the emulation tries its best to support them. One card is the[student card of the Technical University of Darmstadt and the other on is the student card of the University of Giessen. Both cards contain one application with one private key, one public key file and one certificate, protected by one global PIN and PUK.

Here's some output that shows the layout of a TCOS2 TUD-card:

```bash
$ pkcs15-tool -D
PKCS#15 Card [TUD Card]:
        Version        : 0
        Serial number  : 8949017200003335855
        Manufacturer ID: TU Darmstadt
        Flags          :

PIN [PIN]
        Com. Flags: 0x3
        ID        : 01
        Flags     : [0x51], case-sensitive, initialized, unblockingPin
        Length    : min_len:6, max_len:16, stored_len:16
        Pad char  : 0x00
        Reference : 0
        Type      : ascii-numeric
        Path      : 5000
        Tries left: 3

PIN [PUK]
        Com. Flags: 0x3
        ID        : 02
        Flags     : [0xD1], case-sensitive, initialized, unblockingPin, soPin
        Length    : min_len:8, max_len:16, stored_len:16
        Pad char  : 0x00
        Reference : 1
        Type      : ascii-numeric
        Path      : 5008
        Tries left: 2

Private RSA Key [Schluessel 1]
        Com. Flags  : 1
        Usage       : [0x7], encrypt, decrypt, sign
        Access Flags: [0x1D], sensitive, alwaysSensitive, neverExtract, local
        ModLength   : 1024
        Key ref     : 131
        Native      : yes
        Path        : 41015103
        Auth ID     : 01
        ID          : 45

X.509 Certificate [Zertifikat 1]
        Flags    : 2
        Authority: no
        Path     : 41014352
        ID       : 45
```

Since TCOS2-cards are not produced anymore both universities must use different cards now. As of may 2011 the university of Giessen is using [Siemens-CardOS-M4](Siemens-CardOS-M4) based cards and the university of Darmstadt has replaced all of their TCOS2 cards by a different card.

## DATEV cards

Datev does not run a Trustcenter anymore, so the following information is of historical interest only:

DATEV offered different smart cards. Some were NetKey cards (those that can create signatures in accordance with the german signature law) and will be detected as such. One model was not (named DATEV Smartcard classic) and this card has a separate emulation. It contains two application. One application has one certificate and one keypair while the other application contains two certificates and two keypairs. There's only one global PIN that protects all keys.
