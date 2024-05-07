# Schlumberger / Axalto Cyberflex

> Cryptoflex card are **deactivated**. For further usage, it is necessary to enable the card driver in `opensc.conf`.

Earlier versions of Cyberflex cards have the same or a very similar filesystem interface like the Cryptoflex cards.
Those cards work well with OpenSC.

Newer versions however are pure JavaCards and will not work without a JavaApplet.

[MuscleCard](http://www.musclecard.com/) is an open source software containing a Java Card applet for several smart cards
implementing the JavaCard standard. Starting with OpenSC 0.11.2 support for MuscleCard has been added.

Current Test Status: Only for the brave! This might kill your card! No warranty whatsoever! But initialization with OpenSC works.

## Reader configuration

If you have an e-gate token, you need to [configure it for PC/SC](Using-Schlumberger-e-gate-on-Linux) properly, as the tools used for loading the applet into the card only speak PC/SC.

## Installing GlobalPlatform tools

First you need to install `gpshell` from the [GlobalPlatform open source project](http://sourceforge.net/projects/globalplatform/):

```sh
wget http://heanet.dl.sourceforge.net/sourceforge/globalplatform/globalplatform-5.0.0.tar.gz
tar xfvz globalplatform-5.0.0.tar.gz
cd globalplatform-5.0.0
./configure --prefix=/usr
make
sudo make install
cd ..

wget http://heanet.dl.sourceforge.net/sourceforge/globalplatform/gpshell-1.4.0.tar.gz
tar xfvz gpshell-1.4.0.tar.gz
cd gpshell-1.4.0
./configure --prefix=/usr
make
sudo make install
cd ..
```

Note: `gpshell` 1.4.1 and later **do not** work with these instructions and give an error:

```sh
install -file CardEdgeII.ijc -nvDataLimit 12000 -instParam 00 -priv 2
Command --> 80E602001B05A00000000107A0000000030000000AEF08C6023100C8022EE00000
Wrapped command --> 84E602002305A00000000107A0000000030000000AEF08C6023100C8022EE0002C197064B44B6AC700
Response <-- 6A80
install_for_load() returns 0x80206A80 (6A80: Wrong data / Incorrect values in command data.)
```

## Loading MuscleCard Applet

The Muscle Web page is at <https://muscle.apdu.fr/musclecard.com/>. You can directly download `CardEdgeII.ijc` from wiki [attachments](./attachments/wiki/Cyberflex/CardEdgeII.ijc).

You need to run `gpshell` with these commands:

```sh
$ gpshell
mode_201
enable_trace
establish_context
card_connect -readerNumber 1 // Depends on your reader
select -AID a0000000030000
open_sc -security 1 -keyind 0 -keyver 0 -mac_key 404142434445464748494a4b4c4d4e4f -enc_key 404142434445464748494a4b4c4d4e4f // Open secure channel
delete -AID A0000003230101
delete -AID A00000032301
delete -AID A00000000101
delete -AID A000000001
install -file CardEdgeII.ijc -nvDataLimit 12000 -instParam 00 -priv 2
card_disconnect
release_context
```

Note:  On the Cyberflex 64k, you need to use the following:

```sh
>mode_201
enable_trace
establish_context
card_connect
select -AID a000000003000000
open_sc -security 1 -keyind 0 -keyver 0 -mac_key 404142434445464748494a4b4c4d4e4f -enc_key 404142434445464748494a4b4c4d4e4f 
delete -AID A0000003230101
delete -AID A00000032301
delete -AID A00000000101
delete -AID A000000001
install_for_load -pkgAID A000000001 -nvCodeLimit 13500 -sdAID A000000003000000
load -file CardEdgeCflex.ijc
install_for_install -instParam 00 -priv 02 -AID A00000000101 -pkgAID A000000001 -instAID A00000000101 -nvDataLimit 12000
card_disconnect
release_context
```

The last two "delete" commands will remove an older version of the applet.

Next you need to set the PIN codes to `00000000`, so you can initialize the card.

```sh
opensc-tool -s 00:A4:04:00:06:A0:00:00:00:01:01  -s B0:2A:00:00:38:08:4D:75:73:63:6C:65:30:30:04:01:08:30:30:30:30:30:30:30:30:08:30:30:30:30:30:30:30:30:05:02:08:30:30:30:30:30:30:30:30:08:30:30:30:30:30:30:30:30:00:00:17:70:00:02:01
```

Now the token has a working MuscleCard Applet and is ready for use with OpenSC.

## Using the Token with OpenSC

```sh
pkcs15-init -EC -p pkcs15+onepin
```

If you're asked for `Unspecified PIN [reference 1] required`, use `00000000`.

```sh
$ pkcs15-init -EC -p pkcs15+onepin --pin 1234 --puk 12345678
Using reader with a card: Eutron SIM Pocket Combo 01 00
Unspecified PIN [reference 1] required.
Please enter Unspecified PIN [reference 1]: 
$ pkcs15-tool -D
Using reader with a card: Eutron SIM Pocket Combo 01 00
PKCS#15 Card [MUSCLE]:
    Version        : 1
    Serial number  : 0000
    Manufacturer ID: Identity Alliance
    Last update    : 20081207120153Z
    Flags          : EID compliant

PIN [User PIN]
    Com. Flags: 0x3
    ID        : 01
    Flags     : [0x10], initialized
    Length    : min_len:4, max_len:8, stored_len:8
    Pad char  : 0x00
    Reference : 1
    Type      : ascii-numeric
    Path      : 3f005015
```

## FAQ

### What to do on Windows?

[GlobalPlatform](http://sourceforge.net/projects/globalplatform) has a download package of GPShell.exe for Windows, so no need to compile it on your own.

Download

* `GPShell.exe`
* `CardEdgeII.ijc` (from wiki [attachments](./attachments/wiki/Cyberflex/CardEdgeII.ijc))

and unzip both in the current directory. Run the same commands mentioned above and you should be fine. Note however that this is 100% untested,
please report back if it works (or not) into GitHub issues/discussions or to [mailing list](Mailing-lists). Thanks for your feedback!

### Is there a tool for it?

Historically, there was a small tool to get some information about the cards - `jcop-opensc-0.2`.
It was written for IBM JCop cards but should work as well with Cyberflex cards.
Note: Does not work with latest OpenSC as `sc_check_sw` symbol is not exported from libopensc.

### How can I format or update cards with the old applet?

If you use ID Ally - it will delete the old applet before installation of the new. The `gpshell` should allow you to delete:

* first `A00000000101`
* then `A000000001`

### What can I do if I specified a too small size?

Delete `A00000000101` (instance) and reinstantiate to a larger size.
(this will delete all data / key / ... )

### I'm asked about Unspecified PIN [Reference 1]

There are two APDUs that have to be run first if you use GPShell (which sets the default PINs, PUKs, etc):

* `00 A4 04 00 06 A0 00 00 00 01 01` and
* `B0 2A 00 00 38 08 4D 75 73 63 6C 65 30 30 04 01 08 30 30 30 30 30 30 30 30 08 30 30 30 30 30 30 30 30 05 02 08 30 30 30 30 30 30 30 30 08 30 30 30 30 30 30 30 30 00 00 17 70 00 02 01`.

Both need to be send in one go - without card reset in between. The first selects the muscle applet, the second sets the default pins to `00000000`. You can copypaste the above `opensc-tool` line to execute these commands.
