# Muscle applet

## Source code

OpenSC supports the Muscle applet, available from Debian SVN:

```bash
svn co svn://svn.debian.org/muscleplugins/trunk/MCardApplet
```

An updated version, targeting recent JavaCard 2.2.2 cards with extended APDUs is available from GitHub [martinpaljak/MuscleApplet in AppletPlayground](https://github.com/martinpaljak/AppletPlayground#applet-playground) as it was outdated code.

A "relatively recent" build of the 2.2.2 version is attached to this page, it can be loaded to compatible cards as instructed on the JavaCard page.

## Applet initialization (API version 1.3)

Currently the applet needs to be initialized (initial PINs and ACL-s set) manually, with `opensc-tool` (see #219):

```bash
opensc-tool -s 00:A4:04:00:06:A0:00:00:00:01:01 \
-s B0:2A:00:00:38:08:4D:75:73:63:6C:65:30:30:04:01:08:30:30:30:30:30:30:30:30:08:30:30:30:30:30:30:30:30:05:02:08:30:30:30:30:30:30:30:30:08:30:30:30:30:30:30:30:30:00:00:17:70:00:02:01
```

The *two send APDU* commands do the following:

* Select the MuscleApplet (not needed if the applet is installed as default selected).
* Call the setup method of the applet, changing the built-in `Muscle00` PIN0 with `00000000`, setting default ACL-s and memory size.

----

> The following is an opinionated view of the Muscle Applet's history.
> The original MuscleApplet repository was archived, source code can be found in [AppletPlayground](https://github.com/martinpaljak/AppletPlayground#applet-playground).

## Overview of MuscleApplet

OpenSC has historically grown into a library that incorporates drivers for different cards, both documented and standardized as well as proprietary/NDA/reverse-engineered cards. Usually the cards (or specifications and APDU manuals) are considered static, as it is usually not possible to change the COS-s (Card Operating System-s). One notable exception here is the JavaCard, which is an open platform where anyone can basically invent their own APDU protocol and implement it in a secure smart card. There are different cards with different capabilities and in fact, many current smart cards specifications (like PIV or IAS-ECC) are implemented as JavaCard applets, but the applets don't come with the source code, which makes no real difference.

MuscleApplet, the open source JavaCard applet, dates back several years and as a result is pretty old and outdated. From the MUSCLE movement only pcsc-lite (and the accompanying CCID driver) has proven to be viable while the libmuscle/muscleframework/plugins can be considered as stagnated and outdated software. The MuscleApplet has seen some sporadic updates during the last few years (Karsten Ohme, Joao Poupino, others as well .. ?) but the evolution seems to continue separately from the rest of "the stack". For the applet to be useful, the host side software (tools to create objects and tools and libraries to use them afterwards) need to match the applet on the card. OpenSC also gained support for a version of MuscleApplet (FIXME: insert link to changeset).

The JavaCard world has also evolved a lot, with the JC 2.1.1 specification from 2000 (which the applet still primarily targets and can be used with) to JC 2.2.2 in 2006 with important and modern additions like extended APDU-s, which is supported by several recent cards. Memory sizes and the capabilities of the Java runtimes on cards have improved as well, with cards commonly having 72K or more of EEPROM and often real garbage collection. Some parts of the MuscleApplet have seen updates (like rudimentary extended APDU support) whereas some parts of it have not. There is a fork of MuscleApplet (CoolkeyApplet) which builds upon MuscleApplet and adds several interesting features like secure messaging, but is also outdated and the APDU interface is different from MuscleApplet. Most importantly, the applet that has been circulating can be compiled with different options whereas there is no testing for features on the host side.

### Applet components

MuscleApplet could be layered as follows:

* APDU specification and implementation
* Internal object layer and related machinery (ACL-s, Key objects, data objects) (also in CardEdge.java)
* Object manager with helpers for dealing with objects, on same terms as they are exposed to the outside world
* Memory manager that deals with allocating and re-allocating the memory, which is grabbed as a huge block when the applet is initialized. This is to overcome the absence of garbage collection in older JavaCard-s.

#### Memory manager

Memory manager has probably been created because JavaCard-s did not use to have garbage collection capabilities. It allocates a huge block of memory for storing the objects created by object manager.

* Modern cards have garbage collection
* By default JC-s use short-s (which are unsigned 16 bit values in Java) thus the maximum amount of memory available for applet objects is 32K. Modern cards usually have 64K, 72K or 128K of EEPROM which means that a single applet instance can't use all available resources of the card.
* The implementation is internal to the applet and is not visible to the outside world.

#### Object manager

Object manager deals with creating, locating, reading, writing, iterating and controlling access to the objects that are exposed to the outside world. Internally it uses the memory manager for allocating the EEPROM for objects. Objects consist of identifiers, ACL-s and content. Objects are identified with two short-s. Some identifiers are reserved for special purposes (like I/O objects (0xFFFF:FFFE and 0xFFFF:0xFFFF) or semantics for representing DF-s in OpenSC ISO7816 filesystem emulation (like 0x3F00:0x3F00 for the MF)).

* The object abstraction is simple and robust. A single object can contain up to 32K (unsigned short) of data.

#### Internal objects

In addition to data objects, MuscleApplet manages the following internal objects:

* PIN-s
  * And accompanying PUK-s
    * MuscleApplet uses PIN0 as the "super PIN". The PIN is set to an initial value in source code, "Muscle00".
* Key pairs
  * Can be generated on the card or imported. Plaintext exporting is also possible.
* Keys
  * Arbitrary Key objects, some of them reference the KeyPair-s

* ACL-s
MuscleApplet has ACL-s for reading, writing and using (crypto objects) and ACL-s are associated with keys and data objects. Internally each ACL is a short, which is a bit map of required identities (for example, to use a specific key you need to specify two PIN codes).  The current mapping of Key objects and KeyPair objects is somewhat messy and broken (both arrays have the same size but there are 2x more Key objects than there are KeyPair objects in real life). The ACL system needs careful review and possibly upgrading, as a well functioning ACLS system is the core of the applet functionality.

#### APDU interface

* MuscleApplet implements a proprietary (well, open, but incompatible with everything else) APDU interface, it does not use (except for PIN verification, to be compatible with pinpad readers) common ISO commands.
* OpenSC works with ISO7816 file system cards and related basic commands; MuscleApplet implements a proprietary "object interface".
* MuscleApplet uses objects, which are identified by two shorts. The filesystem emulation code in OpenSC uses special numbering to emulate folders, objects 0xXXXX:0x0000 denote a DF under MF with id 0xXXXX.
* Because there is no filesystem interface, the filesystem needs to be emulated in host software and this makes the MuscleApplet only work with the correct filesystem emulation code.
* The monolithic ComputeCrypt with several steps (init, update, final) could need an improvement to be able to do operations in a single step and to make the code more readable.

Balancing the approach of simplicity (as in a simple, self-defined card interface definition) vs compatibility (the related ISO7816-* standards are pretty complex and arguably also historic) is not easy. Nor is it easy to please a variety of cards (old JavaCard 2.0.1 vs newer 2.2.2 cards, features like extended APDU-s, garbage collection etc). Upgrading the applet requires upgrading the OpenSC driver and without a new host driver, older cards become unusable or at least unstable. MuscleApplet has a GetStatus APDU which can be used to fetch the applet version from the card, so that a driver version could be frozen and another one, "Muscle 2" be created alongside the old implementation.

#### Possible improvements

The following could be made to make the applet more compatible with PKCS#15 and ISO world:

* Add ISO7816-4 filesystem APDU handling to the applet, keeping the existing object based storage structure beneath it for actual storage
* Where appropriate, use ISO7816 SW-s instead of proprietary status codes. Changing this in the applet breaks other possible host side implementations
* Implement ISO7816-8 compatible command interfaces for crypto operations with the on-card objects.

In addition to changing the APDU interface for a "generic cryptographic token" the capabilities of programmable JavaCard-s can do more, like:

* AES-128/192/256 encryption and decryption
  * proper key wrapping on the card
* Custom security mechanisms
  * Policies for exporting key material outside from the card.
  * Duress passwords for wiping the key material/hiding some keys
  * User consent PIN codes
  * etc.

#### Steps taken

* JavaCard 2.2.2 and Extended APDU
* Support only 1024 and 2048 RSA keys (the "shooting from the hip" sizes), removing (3)DES and DSA
* Some ISO7816-4 file system related commands (SELECT FILE, READ BINARY) support
* PIN entry counters
* Cleanup of SW-s used.
* Cleanup of Key and Keypair objects
* Internal applet state bookkeeping (FACTORY/PERSONALIZATION/FINALIZED/LOCKED)
* Rudimentary parametrization of applet operating mode ("standard token" (allow export of raw keys), "secure token" (only allow to export wrapped keys), "stealth token" (do something from the optional list above))

#### Resources

* [Emanuele Gringeri Master Degree thesis](http://etd.adm.unipi.it/theses/available/etd-11092009-161046/)
