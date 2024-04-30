# Software compatibility

In general all smart cards are incompatible. That is the sad truth.

First, every card has different commands. Some of them conform to the standard ISO 7816 Part 4 and higher, but
most cards have at least some commands, that are special, or the commands require a special data structure.

Second, even if the same card is used, two different software companies tend to use the card in incompatible
ways. However there is hope for this problem: [PKCS #15](https://www.usenix.org/legacy/events/smartcard99/full_papers/nystrom/nystrom.pdf) is a standard designed to solve that issue.

OpenSC implements PKCS#15, so cards initialized with OpenSC should work with other software implementing
it and vice versa. Note however, that usually a card can only be modified with the software that was used
for initializing it in the first place. In that case you can only read the data with the compatible software,
use the keys, and most likely change pin and puk numbers.

Sometimes it is possible to live side by side. Think of a cd or a disk drive, with a picture and a text
file on it. Your text application can only open and change the text, and your graphics application can
only open and change the graphic, but if the medium can hold both files, you can store both on it.

That happens for example with the "Aladdin eToken PRO" (a usb crypto token) and OpenSC and the Aladdin
Software. OpenSC creates the file "2f00" and the directory "5015" as per PKCS#15 standard, and fills
both with data/keys/certificates. Aladdin does the same in the directory "6666". Still no software knows
how to deal with the other ones data/keys/certificates.

## Compatible Software

But at least some software is compatible:

Giesecke & Devrient ship the Starcos
smart card and USB tokens based on that card. The software bundled with both is called StarSign. That software implements
the PKCS#15 standard, too, so it should be fully compatible with OpenSC and vise versa. If there is any issue, please
let us know (the last test was quite a while in the past).

If you know other software implementing PKCS#15, please add a paragraph.

## National ID cards

National ID cards often are a standard of their own. OpenSC has PKCS#15 emulations for these cards, so you can use
them anyway. See NationalIdCards for a list of supported cards.
