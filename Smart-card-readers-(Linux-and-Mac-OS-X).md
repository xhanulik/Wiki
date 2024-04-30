# Smart card readers (Linux and Mac OS X)

OpenSC targets smart cards, not smart card readers. So to use your smart card, you need a working smart card reader first.

OpenSC is supposed to work with any supported smart card (see [SupportedHardware](Supported-hardware-(smart-cards-and-USB-tokens)) for a list) if you have a driver for your card reader or USB token. If you're unsure, you need a PC/SC driver, which 99.9% of vendors provide for at least Windows platform. CT-API drivers are also supported (only if required and a driver is available from reader vendor, CT-API is a deprecated interface) and OpenCT (on Linux/BSD, if the reader or token does not work with pcsc-lite).

## USB

Most common connector type for smart card readers is USB.

### CCID

Almost all recent USB smart card readers follow the [CCID](https://www.usb.org/sites/default/files/DWG_Smart-Card_CCID_Rev110.pdf) specification. But not all. For USB dongles, a driver is *needed* for the USB connection if the token uses a proprietary protocol.
For a list of CCID smart card readers supported by libccid see <https://ccid.apdu.fr/ccid/section.html>. If you are planning to buy a smart card reader, be sure to check for CCID compliance (and [extended APDU support](https://blog.apdu.fr/posts/2011/11/extended-apdu-support-reported-by-pcsc/) if you want to be somewhat future-proof).

Some readers claim "CCID compatible" in marketing material but are not compliant (don't work with operating system provided CCID drivers) in real life. Readers known to do this are:

* ACS ACR83
* ACS APG8201

### USB tokens (PC/SC)

* Schlumberger/Axalto e-gate pcsc-lite driver: see [Using-Schlumberger-e-gate-on-Linux](Using-Schlumberger-e-gate-on-Linux)

### USB tokens (OpenCT)

* FIXME List of tokens supported by OpenCT

## PIN pad readers

* Notes about CT-API and PinpadReaders

## Bluetooth readers

If someone has experience with any of these, please comment.

* <https://www.apriva.com/mobile-security/apriva-reader/> (SDK available under NDA/license, including for Android)
* <https://www.blackberry.com/solutions/pdfs/SmartCardReaderBrochure.pdf>
* <https://www.hidglobal.com/products/2061> End-of-life (Windows-only PC/SC driver, proprietary/NDA low level protocol)

Information on using existing PC/SC reader over bluetooth on Android: <https://github.com/seek-for-android/pool/wiki/BTPCSC>
