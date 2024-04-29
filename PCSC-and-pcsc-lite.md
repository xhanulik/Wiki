# PC/SC and pcsc-lite

PC/SC is the de facto cross-platform API for accessing smart card readers. It is published by [PC/SC Workgroup](http://www.pcscworkgroup.com/) but the "reference implementation" is Windows. Linux and Mac OS X use the open source [pcsc-lite](https://pcsclite.apdu.fr/) package.

PC/SC is well supported by OpenSC and is the preferred access method for smart card readers on all platforms. Features like PinpadReaders are supported if the reader driver has support for it (PC/SC v2 part 10).

Most modern USB smart card readers are CCID/ICCD compatible. Mac OS X and Linux use the [open source CCID driver](https://ccid.apdu.fr/).
