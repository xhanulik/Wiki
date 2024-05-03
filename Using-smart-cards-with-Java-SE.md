# Using smart cards with Java SE

## JNI wrappers

Access to native PKCS#11 providers. Requires JNI and necessary host-side software.

* [OpenSC-Java](https://github.com/OpenSC/OpenSC-Java)
* [IAIK](https://jce.iaik.tugraz.at/products/core-crypto-toolkits/pkcs11-wrapper/)
* Sun PKCS#11 in 1.5+
* [jPCSC](https://github.com/klali/jpcsc)

## javax.smartcardio in 1.6+

List of "interesting" applications and libraries that make use of javax.smartcardio

* Low level PC/SC bridge (replaces and obsoletes jPCSC) <http://java.sun.com/javase/6/docs/jre/api/security/smartcardio/spec/javax/smartcardio/package-summary.html>
* PKCS#15 support (OpenSC-Java)
* [GPJ](https://sourceforge.net/projects/gpj/)
* [scuba](https://scuba.sourceforge.net/)
* [OpenCard Framework](https://www.openscdp.org/ocf/)
* [Smart Card Shell](https://www.openscdp.org/scsh3/index.html)
* [OpenPGP](https://sourceforge.net/projects/javaopenpgpcard/)
* [Generic APDU sending GUI](https://sourceforge.net/projects/jsmartcard/)
* [NFC link for ACR122U](https://code.google.com/archive/p/nfcip-java/)

### Tips

* On Mac OS X 10.6 and 10.7 run the JRE with _-d32_ to force it into 32bit mode, otherwise smart card events won't work or a crash happens:

```sh
java(2885,0x104c77000) malloc: *** mmap(size=140454020517888) failed (error code=12)
*** error: can't allocate region
*** set a breakpoint in malloc_error_break to debug
Invalid memory access of location 0x0 rip=0x10c0d766e
Segmentation fault: 11
```

* [card.disconnect()](https://docs.oracle.com/javase/6/docs/jre/api/security/smartcardio/spec/javax/smartcardio/Card.html#disconnect(boolean)) has an [inverse logic bug](https://bugs.openjdk.java.net/show_bug.cgi?id=100151), _true_ leaves the card and _false_ resets the card.

## JVM system properties (-D)

* pcsc-lite library location. If no PC/SC implementation is found by default (exception) path to the library location might be needed (on Debian for example)
* `sun.security.smartcardio.library` = `/usr/lib/libpcsclite.so`
* Automatic GET RESPONSE issuing. Cards that behave in a certain way, might need to have the automatic GET RESPONSE issuing turned off (for example see [problem description](https://ridrix.wordpress.com/2009/07/12/design-error-in-javax-smartcardio/)
* `sun.security.smartcardio.t0GetResponse` = `false`
* `sun.security.smartcardio.t1GetResponse` = `false`

## PKCS#15 in Java

Similar to the PKCS#15 generation/parsing software in OpenSC, but implemented in Java. Both use [Bouncy Castle](https://www.bouncycastle.org/java.html) for actual ASN.1 encoding/decoding. Both use javax.smartcardio instead of the pcsc/openct/ctapi layer of OpenSC.

* in OpenSC-Java
* In javacardsign
* Alternative: use [Java ASN.1 compiler](https://sourceforge.net/projects/jac-asn1/) instead.

## GlobalPlatform in Java

GlobalPlatform deals with loading and managing JavaCard applets. There are currently two known implementations of GlobalPlatform specific functionality:

* GPJ (see above) uses javax.smartcardio and does not provide a GUI. Ideal for integrating purposes.
* jcManager uses jPCSC (see above) and provides a rudimentary GUI.
