# History of the OpenSC Project

## The Emeritus

The list of past OpenSC developers, in chronological order of retirement:

* 2008-07-27 Chaskiel Grundman (cg2v) last commit was "<http://www.opensc-project.org/opensc/changeset/3540":http://www.opensc-project.org/opensc/changeset/3540>
* 2008-02-25 Nils Larsch (nils) last commit was "<http://www.opensc-project.org/opensc/changeset/3392":http://www.opensc-project.org/opensc/changeset/3392>
* 2007-10-06 Gürer Özen (gurer) last commit was "<http://www.opensc-project.org/opensc/changeset/3278":http://www.opensc-project.org/opensc/changeset/3278>
* 2007-03-21 Andreas Schwier (andreas.schwier) last commit was "<http://www.opensc-project.org/opensc-java/changeset/82":http://www.opensc-project.org/opensc-java/changeset/82>
* 2006-09-26 Henryk Plötz (henryk) last commit was "<http://www.opensc-project.org/opensc/changeset/3028":http://www.opensc-project.org/opensc/changeset/3028>
* 2006-09-20 Stef Hoeben (sth) last commit "<http://www.opensc-project.org/sca/changeset/83":http://www.opensc-project.org/sca/changeset/83>
* 2006-01-02 Juan Antonio Martinez (jonsito) last commit was "<http://www.opensc-project.org/pam_pkcs11/changeset/226":http://www.opensc-project.org/pam_pkcs11/changeset/226>
* 2005-09-21 Bert Vermeulen (bert) last commit was "<http://www.opensc-project.org/opensc/changeset/2612":http://www.opensc-project.org/opensc/changeset/2612>
* 2005-07-29 Marc Bevand (mb) last commit was "<http://www.opensc-project.org/opensc/changeset/2449":http://www.opensc-project.org/opensc/changeset/2449>
* 2005-03-17 Romain Chantereau (rchantereau) last commit was "<http://www.opensc-project.org/csp11/changeset/259":http://www.opensc-project.org/csp11/changeset/259>
* 2005-03-07 Antti Tapaninen (aet) last commit was "<http://www.opensc-project.org/opensc/changeset/2231":http://www.opensc-project.org/opensc/changeset/2231>
* 2004-02-03 Olaf Kirch (okir) last commit was "<http://www.opensc-project.org/opensc/changeset/1751":http://www.opensc-project.org/opensc/changeset/1751>
* 2003-07-12 Juha Yrjölä (jey) last commit was "<http://www.opensc-project.org/opensc/changeset/1255":http://www.opensc-project.org/opensc/changeset/1255>
* 2002-11-11 Timo Teräs (fabled) last commit was "<http://www.opensc-project.org/opensc/changeset/708":http://www.opensc-project.org/opensc/changeset/708>

But many other people have contributed to OpenSC as well, see [the team](Getting-involved-in-OpenSC-development#the-team).

## Project chronology

### OpenCT 0.6.20 and OpenSC 0.11.13

On 2010-02-16 OpenCT 0.6.20 and OpenSC 0.11.13 were released,
both with small fixes for the Rutoken S driver and other small
bugfixes.

### OpenCT 0.6.19 and Engine_PKCS!#11 0.1.8

On 2010-01-07 OpenCT 0.6.19 was released with improved `udev` rules
to help the transition back from hal to `udev`. Engine_PKCS#11
0.1.8 was released with a fix for finding certificates and keys.

### OpenSC 0.11.12

On 2009-12-18 OpenSC 0.11.12 was released with a fix for a 
regression in OpenSC 0.11.5 and later, that made some cards
initialized with older versions of OpenSC no longer work
with newer versions.

### OpenSC 0.11.11

On 2009-10-26 OpenSC 0.11.11 was released with updates for "myeid"
driver and fixing compile issues with OpenSSL 0.9.7 and 1.0.0.

### OpenSC 0.11.10

On 2009-10-20 OpenSC 0.11.10 was released with a new driver "westcos"
and support for MyEid cards by Aventra (currently limited to using
cards initialized with Aventras software). Rutoken driver was extended
to include GOST algorithm support.

### Engine_pkcs11 0.1.7, Libp11 0.2.7

For both libp11 and engine_pkcs11 a patch fixing a small bug
was posted. Since no other development happens with these
packages, new releases were created on 2009-10-20 to push the
bugfixes to the users.

### OpenCT 0.6.18

On 2009-09-25 OpenCT 0.6.18 was released with support for Rutoken S,
fixes for usb on BSD systems and fixes for combining OpenCT with
pcsc-lite.

### OpenSC 0.11.9 and OpenCT 0.6.17

On 2009-07-29 new versions of OpenSC and OpenCT were released,
mostly with several smaller bug fixes, but also including updates
to the piv card driver and support for the Rutoken ECP.

### Libp11 0.2.6

On 2009-07-22 libp11 0.2.6 was released fixing the exports file,
which prior to this release was missing the symbol for the new
function included in libp11 0.2.5.

### New engine_pkcs11 and libp11 releases

New release of libp11 with an extra functions (thus increased library
interface version), and a new version of engine_pkcs11 using it, with
other small fixes too.

### New OpenSC release 0.11.8 with security updates

On 2009-05-07 RSA keys are not secure if the public
exponent is 1. It should be at least 3, better 65537
or higher. OpenSC PKCS#11 always sets it to a proper
value, but a bug in OpenSC 0.11.7 caused pkcs11-tool
to ask for public exponent 1 when creating new keys.
Only the combination of pkcs11-tool from OpenSC 0.11.7
with a third party PKCS#11 Module and a card ignoring
this bad value would create such an insecure key.

### New OpenCT release 0.6.16

On 2009-05-04 Better hal support, several smaller fixes,
improved polling loop for reduced power consumption
and building/packaging fixes to make packaging easier
were included in the new OpenCT release 0.6.16.

### Improved Security Updates and new OpenSC and Pam_P11

On 2008-08-27 The Security Advisory was updated and OpenSC
0.11.6 was released with a security relevant fix.
Pam_p11 was updated to 0.1.5 with fixed documentation
(wiki to html export).

### SCB obsolete, new windows binaries

On 2008-08-01 New windows binary packages version 001 were made
public. These new packages were build using MinGW setup. The
old SCB installer package for windows is now obsolete, as there
is no one left to maintain it.

### Security Updates and new versions

On 2008-07-31 A security update was found and a security Advisory was
released. Also OpenCT 0.6.15, OpenSC 0.11.5, Libp11 0.2.4,
Pam_P11 0.1.4 and Engine_Pkcs11 0.1.5 were released.

### Smart Card Bundle 0.10

On 2007-09-11 SCB 0.10 was released with OpenSC updated to 0.11.4.

### OpenSC 0.11.4

On 2007-09-10 OpenSC 0.11.4 was released with some support for CardOS M4 cards initialized with siemens software, and with the new AKIS driver.

### OpenCT 0.6.14

On 2007-08-30 OpenCT 0.6.14 was released fixing `openct_udev` script.

### OpenCT 0.6.13

On 2007-08-23 OpenCT 0.6.13 was released with hot plug improvements

### OpenCT 0.6.12

On 2007-07-11 OpenCT 0.6.12 with many improves and merging the rfid support.

### OpenSC 0.11.2

On 2007-05-04 OpenSC 0.11.2 was released, with bugfixes, a free
pkcs11.h header file, muscle support (in testing) and updated
card drivers.

### pkcs11-helper 1.02

On 2007-01-05 pkcs11-helper 1.02 was released, first standalone
library for developers who wish to use PKCS#11 in their applications,
but found it to be too complex.

### OpenCT 0.6.11

On 2006-11-22 OpenCT 0.6.11 was released fixing non linux compiles.

### OpenCT 0.6.10

On 2006-11-11 OpenCT 0.6.10 was released with minor bugfixes only.

### OpenCT 0.6.9

On 2006-09-20 OpenCT 0.6.9 was released, the biggest change was
moving to `udev` instead of hot plug for usb hot plug support.

### OpenCT 0.6.8

On 2006-06-19 OpenCT 0.6.8 was released, fixing only a single
small, but very annoying bug that caused spurious failures. Now
OpenCT works well, e.g. 1000 remote ssh logins in a row work
without any failure.

### LinuxTag 2006

From 2006 May 3rd to 6st we had a booth at
LinuxTag (in Wiesbaden, Germany).

### OpenSC, OpenCT and Web renewed

On 2006-05-01 the new web pages was launched and new versions
OpenSC 0.11.0 and OpenCT 0.6.7 were released.

### opensc-project.org

On 2006-01-20 the web page was moved to opensc-project.org due to
dns problems with our old domain name opensc.org.

### libp11 0.2.1 and engine_pkcs11 0.1.3

Both released on 2005-11-23 fixed a few bugs.

### OpenSC 0.10.0 and friends

To make maintenance of OpenSC easier it was split up into several
subprojects - the core OpenSC stayed, but some code used on top
of the PKCS#11 module was moved into a new library libp11,
and the OpenSSL engine was moved into a new project engine_pkcs11.
Also the pam module was abandoned in favor of the new Pam P11 and
the well known Pam PKCS#11 modules. The windows installer was
updated and a new installer for Mac OS X saw the light of the day.
OpenSC 0.10.0, Libp11 0.2.0, Pam_p11 0.1.2, Engine_pkcs11 0.1.2,
SCB 0.5 and SCA 0.1 were announced at the same time.

### Pam PKCS#11 0.5.3

Pam PKCS#11 was developed already for a long time. But in 2005 the
project migrated to the opensc server and with Pam-pkcs11 0.5.3
a new version with several bug fixes was released on 2005-09-12.

### OpenCT 0.6.6

OpenCT 0.6.6 was released 2005-09-11 and added several new drivers
including pcmcica based drivers.

### Windows Installer SCB 0.4

Smart Card Bundle 0.4 was released 2005-06-16, now with a working
version of Putty and Pageant, and applications like WinCVS had
been successful used with smart card authentication.

### OpenCT 0.6.5

OpenCT 0.6.5 was released 2005-05-17 and added several new drivers,
Solaris support and many bug fixes.

### Windows Installer SCB 0.3

Smart Card Bundle 0.3 was released 2006-05-10.

### OpenSC 0.9.6

OpenSC 0.9.6 was released 2005-04-26. At the same time work
on a new installer for windows was started.

### OpenCT 0.6.4

OpenCT 0.6.4 was released 2005-04-26.

### Merry Christmas OpenSC

Belgium has chosen OpenSC as software basis for their national ID
card and the source code changes to OpenSC have been published
under LGPL license. Their modified version is published under the
name "Belpic".

### OpenSC 0.9.4

OpenSC 0.9.4 was released 2004-10-31.

### Alpha and beta releases

OpenCT 0.6.0-alpha and OpenSC 0.9.0-alpha were released
2004-07-01 for testing.

OpenSC 0.9.1 and OpenCT 0.6.1 were announced as preview version on
2004-07-21.

OpenSC 0.9.2 was released as beta 2004-07-25.

### OpenCT 0.5.0

OpenCT 0.5.0 was announced 2003-11-24.

### OpenCT 0.1.0

OpenCT 0.1.0 was announced 2003-08-16.

### OpenSC 0.8.0

OpenSC 0.8.0 was announced 2003-08-15. New card drivers for Aladdin
eToken, Micardo 2 and Starcos were in this release, improved support
for Windows and Mac OS X. Also this release included native support
for accessing several usb crypto tokens, but that support was already
deprecated by the new OpenCT 0.1.0 framework for card readers.

### IPSEC with Smart cards

On 2003-07-09 Andreas Steffen released the X.509 patch version 1.40
for freeswan 2.00 which introduced support for smart cards.

### OpenSC 0.7.0

OpenSC 0.7.0 was created 2002-06-3. It was the first version to work
with OpenSSH without any patching. Also the opensc signer plugin
for mozilla and netscape was integrated with the OpenSC source code.

### OpenSC 0.6.1

OpenSC 0.6.1 was created 2002-03-20. The PKCS#11 Module was improved
so it could be used in Mozilla for signing and decrypting emails.

### OpenSC 0.6.0

OpenSC 0.6.0 was created 2002-03-13 by Juha Yrjölä, Antti Tapaninen,
Timo Teräs and Olaf Kirch. PKCS #15 support was rewritten for this
release and support for several cards was added. Also an abstraction
layer for card readers was added.

### OpenSC 0.5.0

OpenSC 0.5.0 was created 2002-01-24 by Juha Yrjöla, Antti Tapaninen
and Timo Teräs, with additional thanks to David Corcoran for
inspiration, moral support and valuable information. This releases
added PKCS #15 generation support and a rewritten PKCS#11 module,
as well as support for the Cryptoflex 16k card.

### OpenSC 0.4.0

OpenSC 0.4.0 was created 2001-12-29 by Juha Yrjölä, Antti Tapaninen
and Timo Teräs. Among other changes it added abstract card handling,
so adding support for new cards became a whiz. With this release
the libopensc and opensc-apps was merged into one package. Also opensc-signer 0.1.1 was
published at the same day.

### libopensc 0.3.5

libopensc 0.3.5 and opensc-apps 0.3.5 was created 2001-12-15
by Juha Yrölä and Timo Teräs. Also opensc-signer 0.1.0 was
published, a netscape plugin to generate digital signatures
with smart cards.

### libopensc 0.3.2

libopensc 0.3.2 and opensc-apps 0.3.2 were created 2001-11-28
by Juha Yrölä and Timo Terräs.
It was the first version to use GNU Autotools.

### OpenSC 0.3

OpenSC 0.3 was created 2001-11-23 by Juha Yrjölä and Timo Teräs.

### OpenSC 0.2

OpenSC 0.2 was created on 2001-11-06 by Juha Yrjölä and Timo Teräs.
