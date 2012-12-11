h1. Using smart cards with Java SE


h2. JNI wrappers

Access to native PKCS#11 providers. Requires JNI and necessary host-side software.
 * OpenSC-Java "https://www.opensc-project.org/opensc-java/browser/trunk/pkcs11":https://www.opensc-project.org/opensc-java/browser/trunk/pkcs11
 * IAIK "http://jce.iaik.tugraz.at/sic/Products/Core-Crypto-Toolkits/PKCS-11-Wrapper":http://jce.iaik.tugraz.at/sic/Products/Core-Crypto-Toolkits/PKCS-11-Wrapper
 * Sun PKCS#11 in 1.5+ "http://java.sun.com/j2se/1.5.0/docs/guide/security/p11guide.html":http://java.sun.com/j2se/1.5.0/docs/guide/security/p11guide.html
Access to PC/SC for Java versions before 1.6. Should not be used for new applications, use Java 1.6 and javax.smartcardio instead
 * jPCSC - "http://www.linuxnet.com/middle.html":http://www.linuxnet.com/middle.html

h2. javax.smartcardio in 1.6+

List of "interesting" applications and libraries that make use of javax.smartcardio
 * Low level PC/SC bridge (replaces and obsoletes jPCSC) "http://java.sun.com/javase/6/docs/jre/api/security/smartcardio/spec/javax/smartcardio/package-summary.html":http://java.sun.com/javase/6/docs/jre/api/security/smartcardio/spec/javax/smartcardio/package-summary.html
 * PKCS#15 support (OpenSC-Java)
 * GPJ "http://sourceforge.net/projects/gpj/":http://sourceforge.net/projects/gpj/
 * scuba "http://scuba.sourceforge.net/":http://scuba.sourceforge.net/
 * OpenCard Framework "http://www.openscdp.org/ocf/":http://www.openscdp.org/ocf/
 * Smart Card Shell "http://www.openscdp.org/scsh3/index.html":http://www.openscdp.org/scsh3/index.html
 * wiki:OpenPGP GUI "http://sourceforge.net/projects/javaopenpgpcard/":http://sourceforge.net/projects/javaopenpgpcard/
 * Generic APDU sending GUI "http://sourceforge.net/projects/jsmartcard/":http://sourceforge.net/projects/jsmartcard/
 * NFC link for ACR122U "http://code.google.com/p/nfcip-java/":http://code.google.com/p/nfcip-java/
 * Serbian eID interface: "https://gitorious.org/freesteel/jfreesteel":https://gitorious.org/freesteel/jfreesteel
 * MOCCA - applet for digital signatures for several eID cards with direct APDU-s "http://mocca.egovlabs.gv.at/BKUOnline/":http://mocca.egovlabs.gv.at/BKUOnline/

h3. Tips

 * On Mac OS X 10.6 and 10.7 run the JRE with _-d32_ to force it into 32bit mode, otherwise smart card events won't work or a crash happens:
 <pre><code>java(2885,0x104c77000) malloc: *** mmap(size=140454020517888) failed (error code=12)
*** error: can't allocate region
*** set a breakpoint in malloc_error_break to debug
Invalid memory access of location 0x0 rip=0x10c0d766e
Segmentation fault: 11
</code></pre>
 * Applets and out-of-browser windows: "http://my.opera.com/daniel/blog/2010/05/31/new-opera-with-ns4-javaplugin":http://my.opera.com/daniel/blog/2010/05/31/new-opera-with-ns4-javaplugin
 * "card.disconnect()":http://docs.oracle.com/javase/6/docs/jre/api/security/smartcardio/spec/javax/smartcardio/Card.html#disconnect(boolean) has an "inverse logic bug":https://bugs.openjdk.java.net/show_bug.cgi?id=100151, _true_ leaves the card and _false_ resets the card. 

h2. JVM system properties (-D)

 * pcsc-lite library location. If no PC/SC implementation is found by default (exception) path to the library location might be needed (on Debian for example)
  * _sun.security.smartcardio.library_=_/usr/lib/libpcsclite.so_
 * Automatic GET RESPONSE issuing. Cards that behave in a certain way, might need to have the automatic GET RESPONSE issuing turned off (for example see "problem description":https://ridrix.wordpress.com/2009/07/12/design-error-in-javax-smartcardio/)
  * _sun.security.smartcardio.t0GetResponse_=_false_
  * _sun.security.smartcardio.t1GetResponse_=_false_

h2. PKCS#15 in Java

Similar to the PKCS#15 generation/parsing software in OpenSC, but implemented in Java. Both use "Bouncy Castle":http://www.bouncycastle.org/java.html for actual ASN.1 encoding/decoding. Both use javax.smartcardio instead of the pcsc/openct/ctapi layer of OpenSC.
 * in OpenSC-Java "https://www.opensc-project.org/opensc-java/browser/trunk/pkcs15":https://www.opensc-project.org/opensc-java/browser/trunk/pkcs15
 * In javacardsign "http://javacardsign.svn.sourceforge.net/viewvc/javacardsign/pkihostapi/src/net/sourceforge/javacardsign/iso7816_15/":http://javacardsign.svn.sourceforge.net/viewvc/javacardsign/pkihostapi/src/net/sourceforge/javacardsign/iso7816_15/
 * Alternative: use "Java ASN.1 compiler":http://sourceforge.net/projects/jac-asn1 instead.

h2. GlobalPlatform in Java

GlobalPlatform deals with loading and managing JavaCard applets. There are currently two known implementations of GlobalPlatform specific functionality:
 * GPJ (see above) uses javax.smartcardio and does not provide a GUI. Ideal for integrating purposes.
 * jcManager "http://www.brokenmill.com/2010/03/java-secure-card-manager/":http://www.brokenmill.com/2010/03/java-secure-card-manager/ uses jPCSC (see above) and provides a rudimentary GUI.
