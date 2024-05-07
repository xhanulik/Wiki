# PuTTYcard

The idea behind PuTTYcard was to extend the capabilities
of PuTTY without adding dependencies to PuTTY. Therefore
all smart card routines were realized within a separate
DLL (namely PuTTYcard.dll). Pageant.exe would try to open
this DLL. If it could not find it, it would behave like
a "normal" Pageant.

This only needed about 20 lines of codes within the source
of pageant.exe and I was hoping that the PuTTY team would
include this into future PuTTY-packages. They did not.

Therefore I merged the source code of PuTTYcard.dll with
the source code of  pageant.exe and released a smart card
enabled version of pageant.exe. If you are interested you
may download it at <https://smartcard-auth.de/ssh-en.html>.

You must register your public key if you want to use
some features (for example secure PIN entry).
If you used PuTTYcard in the past or are willing to test
my smart card enabled version of pageant.exe with a new
card or a new card reader I will send you a free license.
Just let me know.

PuTTYcard is an extension to PuTTY, the free SSH-client
from Simon Tatham. With this extension PuTTY can use
RSA-keys from external devices, ie. smart cards, usb-tokens.

If pageant is called with one argument, it will interpret
this argument as the name of a key-file. Pageant will then
load this ppk-file into its keylist, or if another instance of
Pageant is already running into the keylist of that instance.

The pageant-version from PuTTYcard-0.58-V1.2.zip (can be downloaded
from OpenSCs contrib area) will do exactly the same thing
with one exception. If the first line of the ppk-file
has the form:

```text
PuTTYcard,<path to DLL>,<arguments for the DLL>
```

then Pageant will NOT read the key from the ppk-file. Instead
it loads the DLL and calls a function from that DLL passing
the arguments from the ppk-file to this function.

The function may then fetch a public RSA key from any
source. Possible choices are: files, smart cards, PKCS11
libraries, Cryptographic Service Providers, etc.

PuTTYcard-0.58-V1.2.zip contains PuTTYiso7816.dll. This
DLL will load an RSA key from any ISO-7816-8 compatible
smart card. PuTTYiso7816 need additional information
from the ppk-file, namely the location of the RSA key
on your specific smartcard.

This information is given as 4 hexadecimal numbers, i.e.
your ppk-file should look like

```text
PuTTYcard,PuTTYiso7816.dll,<path>,AA,BB,CCCC
```

The `<path>` is the DF on your smart card that contains the RSA-key.
This must be specified as a 4,8,12 or 16digit hexadecimal
number. Do NOT prefix the path with 3F00.
AA is the key-reference of the private key, BB is the
pin-reference of the pin that protects your private key.
CCCC is the ID of a file on your card that contains your
public key. This file must either contain the public key
as two ASN1-encoded records or it must be a certificate file
from which the public key will be extracted.

## How do I find the above mentions numbers?

One of the first actions of PuTTYcard
is to change its working DF to the DF given by the
`<path>`-argument. The remaining information
(private and public key, PIN and maybe a certificate)
will then be read from that DF. Try `pkcs15-tool -k`
to list all of your keys and that should give you the
information you need.

Here's the output for my Netkey E4 card:

```text
$ pkcs15-tool -k
Private RSA Key [Signatur-Schlüssel]
        Com. Flags  : 1
        Usage       : [0x204], sign, nonRepudiation
        Access Flags: [0x1D], sensitive, alwaysSensitive, neverExtract, local
        ModLength   : 1024
        Key ref     : 128
        Native      : yes
        Path        : DF015331
        Auth ID     : 04
        ID          : 01

Private RSA Key [Authentifizierungs-Schlüssel]
        Com. Flags  : 1
        Usage       : [0x207], encrypt, decrypt, sign, nonRepudiation
        Access Flags: [0x1D], sensitive, alwaysSensitive, neverExtract, local
        ModLength   : 1024
        Key ref     : 130
        Native      : yes
        Path        : DF015371
        Auth ID     : 04
        ID          : 02

Private RSA Key [Verschlüsselungs-Schlüssel]
        Com. Flags  : 1
        Usage       : [0x207], encrypt, decrypt, sign, nonRepudiation
        Access Flags: [0x1D], sensitive, alwaysSensitive, neverExtract, local
        ModLength   : 1024
        Key ref     : 129
        Native      : yes
        Path        : DF0153B1
        Auth ID     : 03
        ID          : 03
```

This card has three keys all of which are stored in DF `DF01`.
This is your `<path>`-value. Do not include the last component of the
path from the `pkcs15-tool` output as this is the ID of the
private key itself.

The next information you need is the key reference. This value
is included as a decimal number in the above output (ie. 128, 130 and 129).
This value must be converted to a 2-digit hexadecimal number. Let's
use the second key, so your AA-value is 82.

Your private key is protected by a PIN and the `pkcs15-tool -k` output
contains the Auth-ID of this PIN. Here it is 04. This is not
your PIN-reference. Use `pkcs15-tool --list-pins` to list all
your PINs and use the PIN-reference of the PIN that has the same Id
as the Auth-Id of your key.

```text
$ pkcs15-tool --list-pins
PIN [globale PIN]
        Com. Flags: 0x3
        ID        : 01
        Flags     : [0x51], case-sensitive, initialized, unblockingPin
        Length    : min_len:6, max_len:16, stored_len:16
        Pad char  : 0x00
        Reference : 0
        Type      : ascii-numeric
        Path      : 5000
        Tries left: 3

PIN [globale PUK]
        Com. Flags: 0x3
        ID        : 02
        Flags     : [0xD1], case-sensitive, initialized, unblockingPin, soPin
        Length    : min_len:8, max_len:16, stored_len:16
        Pad char  : 0x00
        Reference : 1
        Type      : ascii-numeric
        Path      : 5001
        Tries left: 3

PIN [lokale PIN0]
        Com. Flags: 0x3
        ID        : 03
        Flags     : [0x13], case-sensitive, local, initialized
        Length    : min_len:6, max_len:16, stored_len:16
        Pad char  : 0x00
        Reference : 128
        Type      : ascii-numeric
        Path      : DF015080
        Tries left: 3

PIN [lokale PIN1]
        Com. Flags: 0x3
        ID        : 04
        Flags     : [0xD3], case-sensitive, local, initialized, unblockingPin, soPin
        Length    : min_len:6, max_len:16, stored_len:16
        Pad char  : 0x00
        Reference : 129
        Type      : ascii-numeric
        Path      : DF015081
        Tries left: 3
```

Again the PIN-reference is given in decimal (here it is 129) and must be
converted to a 2-digit hexadecimal number, namely 81. This is
your BB-value.

Finally you need the file-ID of the public key or a certificate file
from which he public key could be extracted.

So either use `pkcs15-tool --list-public-keys` or
`pkcs15-tool -c`. With my Netkey card `pkcs15-tool --list-public-keys`
does not show any keys. This is because my Netkey card
contains the public key, but it cannot be used for cryptographic
operations. From other sources (ie. card doku) I know that
the public key is stored in file DF01:4571, so one possible
CCCC-value is 4571.

If I list all my certificates I get:

```text
$ pkcs15-tool -c                
X.509 Certificate [Telesec Signatur Zertifikat]
        Flags    : 0
        Authority: no
        Path     : DF01C000
        ID       : 01

X.509 Certificate [User Signatur Zertifikat 1]
        Flags    : 2
        Authority: no
        Path     : DF014331
        ID       : 01

X.509 Certificate [User Signatur Zertifikat 2]
        Flags    : 2
        Authority: no
        Path     : DF014332
        ID       : 01

X.509 Certificate [Telesec Authentifizierungs Zertifikat]
        Flags    : 0
        Authority: no
        Path     : DF01C100
        ID       : 02

X.509 Certificate [User Authentifizierungs Zertifikat 1]
        Flags    : 2
        Authority: no
        Path     : DF014371
        ID       : 02

X.509 Certificate [Telesec Verschlüsselungs Zertifikat]
        Flags    : 0
        Authority: no
        Path     : DF01C200
        ID       : 03

X.509 Certificate [User Verschlüsselungs Zertifikat 1]
        Flags    : 2
        Authority: no
        Path     : DF0143B1
        ID       : 03
```

A certificate contains the right public key, if it has the
same ID as the private key (here 02). My card has two such
certificates namely DF01:C100 and DF01:4371 so two other
possible CCCC-values are C100 and 4371

On a Netkey card a private key may be protected by more than
one PIN. So instead of PIN-reference 81 (which references
local PIN1) I may alternatively use PIN-reference 00 (which
references global PIN0)

So all of the following six lines will work:

```text
PuTTYcard,PuTTYiso7816.dll,DF01,82,81,4571
PuTTYcard,PuTTYiso7816.dll,DF01,82,81,C100
PuTTYcard,PuTTYiso7816.dll,DF01,82,81,4371
PuTTYcard,PuTTYiso7816.dll,DF01,82,00,4571
PuTTYcard,PuTTYiso7816.dll,DF01,82,00,C100
PuTTYcard,PuTTYiso7816.dll,DF01,82,00,4371
```
