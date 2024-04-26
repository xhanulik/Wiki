# OpenSC Credits

OpenSC was written by (or uses code copied from):

* Alon Bar-Lev
* Andrea Frigido
* Andreas Jellinghaus
* Antonino Iacono
* Antti Partanen
* Antti Tapaninen
* Benjamin Bender
* Bert Vermeulen
* Boris Kröger
* Bud P. Bruegger
* Carlos Prados
* Chaskiel Grundman
* Danny De Cock
* David Corcoran
* Douglas E. Engert
* Eric Dorland
* Franz Brandl
* Geoff Thorpe
* Gürer Özen for TUBITAK / UEKAE
* Jamie Honan
* Jean-Pierre Szikora
* João Poupino
* Joe Phillips
* Juan Antonio Martinez
* Juha Yrjölä
* Jörn Zukowski
* Kevin Stefanik
* Ludovic Rousseau
* Marc Bevand
* Marie Fischer
* Markus Friedl
* Martin Paljak
* Mathias Brossard
* Matthias Brüstle
* Nils Larsch
* Olaf Kirch
* Peter Koch
* Priit Randla
* Robert Bihlmeyer
* Sirio Capizzi
* Stef Hoeben
* Timo Teräs
* Todd C. Miller
* Viktor Tarasov
* Villy Skyttä
* Weitao Sun
* Werner Koch
* William Wanders

and

* Zetes
* g10 Code GmbH
* OpenTrust (ancient Idealx)
* Dominik Fischer

## License

```text
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
```

OpenSC does not include the official PKCS#11 header file, because that file is under a non-free license. Instead OpenSC contains a rewritten header file from scute project under this license:

```text
/* pkcs11.h
   Copyright 2006, 2007 g10 Code GmbH
   Copyright 2006 Andreas Jellinghaus

   This file is free software; as a special exception the author gives
   unlimited permission to copy and/or distribute it, with or without
   modifications, as long as this notice is preserved.

   This file is distributed in the hope that it will be useful, but
   WITHOUT ANY WARRANTY, to the extent permitted by law; without even
   the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
   PURPOSE.  */
```

OpenSC also includes a copy of [my_getopt](http://www.geocities.com/bsittler/):

```text
my_getopt - a command-line argument parser
Copyright 1997-2001, Benjamin Sittler

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use, copy,
modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT.  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.
```

OpenSC can be compiled with OpenSSL:

```text
This product includes software developed by the OpenSSL Project
for use in the OpenSSL Toolkit (http://www.OpenSSL.org/)

This product includes cryptographic software written by Eric Young
(eay@cryptsoft.com).  This product includes software written by Tim
Hudson (tjh@cryptsoft.com).
```

OpenSC uses autoconf m4 macros by

```text
m4/autoconf macros by Bruno Haible
Copyright (C) 2001-2005 Free Software Foundation, Inc.

Copyright (C) 2002, 2003 Free Software Foundation, Inc.

using pkg-config and pkg.,4 autoconf macro by
Copyright (C) 2004 Scott James Remnant
```

OpenSC includes strlcpy.c (from ftp://ftp.openbsd.org/pub/OpenBSD/src/lib/libc/string/) by

```text
 Copyright (c) 1998 Todd C. Miller <Todd.Miller@courtesan.com>

 Permission to use, copy, modify, and distribute this software for any
 purpose with or without fee is hereby granted, provided that the above
 copyright notice and this permission notice appear in all copies.

 THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
```

OpenSC can be compiled with zlib:

```text
This product includes general purpose compression software written by 
Jean-loup Gailly and Mark Adler for the 'Zlib' project 
(http://www.zlib.net).

  Copyright (C) 1995-2010 Jean-loup Gailly and Mark Adler
```

Please see each file for the detailed copyright information.
