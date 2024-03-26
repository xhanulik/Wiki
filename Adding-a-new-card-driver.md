# Adding a new card driver

## Card driver creation

Basic tasks to hook up a new driver to the OpenSC framework:

1. create `card-example.c` (based on the structure of some existing driver),
2. add `example` to the list of `internal_card_drivers` in `ctx.c`,
3. add `extern sc_card_driver_t *sc_get_example_driver(void);` to `cards.h`,
4. add `card-example.c` to the end of the lists in `Makefile.am` and `Makefile.mak`,
5. re-create Autotools scripts: `./bootstrap`.

Creating the skeleton card driver:

1. identify any card revisions, to be included in ATR map etc,
2. add to the end of enum list in cards.h (+1000 base).

PKCS#15 driver hookup:

* PKCS#15 card formats should need minimal or no modifications, to allow `sc_pkcs15_bind` to scan the card and populate in-memory structures,
* non-PKCS#15 cards need to create a `pkcs15-example.c`, hook it to `builtin_emulators` list in `pkcs15-syn.c` and add to lists in `Makefile.am` and `Makefile.mak`,
* `pkcs15-example.c` creates the in-memory structure by linking right objects with their counterparts based on ID codes or whatever information that is necessary.

## Windows `minidriver` support

Microsoft Windows probes the Smart Card security drivers and loads it related features thanks to the ATRs that should registered (see regedit) from the minidriver framework.
You should carefully register the ATRs using the [OpenSC installer customization](https://github.com/OpenSC/OpenSC/blob/master/win32/customactions.cpp) based on the [following rules](https://docs.microsoft.com/en-us/windows/win32/api/winscard/nf-winscard-scardintroducecardtypea).

### `pbAtrMask` bitmask

Optional bitmask to use when comparing the ATRs of smart cards to the ATR supplied in `pbAtr`.
If this value is non-NULL, it must point to a string of bytes the same length as the ATR string supplied in `pbAtr`.
When a given ATR string A is compared to the ATR supplied in `pbAtr`, it matches if and only if `A & M = pbAtr`, where `M` is the supplied mask, and `&` represents bitwise `AND`.

## Examples

* [[New card driver: EnterSafe card example]]
