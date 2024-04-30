# Serbian EID

There are two versions of EID cards. Cards issued after Aug 18 2014 are "new" cards.
The Serbian EID is currently not supported by OpenSC.

## "Old" card

The EID is based on ApolloOS 2.43. Old patches for driver for thi card are in [vigsterkr/OpenSC](https://github.com/vigsterkr/OpenSC).
It supports reading EF from the card, reading the card's serial number and extract ID information (e.g. name, address, issue date etc.) from the card with `eidenvtool`.

## "New" card

The EID is based on Gemalto Sealys MultiApp ID v2.1. This is a Java Card supporting Global Platform 2.1.1.
Card ATR is `3BFF9400008131804380318065B0850201F3120FFF82900079`.
