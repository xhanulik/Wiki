# Schlumberger / Axalto Cryptoflex

> Cryptoflex card are **deactivated**. For further usage, it is necessary to enable the card driver in `opensc.conf`.

All Cryptoflex cards are supported by OpenSC.

If you initialize Cryptoflex cards with OpenSC, you need to know the so called transport key for this, and for creating PIN objects as well. The card can later be erased by anyone knowing the transport key only (knowing the SO-PIN or PIN is not required).

Cryptoflex 8k cards however are too small, so the default profile does not fit on the card. Not even the small option is small enough to make it fit on the card. However you could edit the profile file to make it even smaller, then it should work again.

Cryptoflex cards are also available as SchlumbergerEgate - a version of Cryptoflex cards that natively support Full speed USB on their chip and only require a small adapter/connector to interface to the USB bus of the PC, either in token (sim) format of full ISO format.
