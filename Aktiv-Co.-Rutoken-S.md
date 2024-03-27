# Aktiv Co. Rutoken S

The [Aktiv Co.](http://www.aktiv-company.ru/) offers the [Rutoken S](https://www.rutoken.ru/products/all/rutoken-s/), an USB crypto token with 8K, 32K, 64K or 128K memory.

## Rutoken S

* **USB IDs:** 0a89:0020
* **Memory:** 8K, 32K, 64K or 128K

## On-board cryptographic functions

* GOST 28147-89

## Authentication

* 3 categories of owners: Administrator, User, Guest
* 2 Global PIN-codes: Administrator and User

## File system features

* File structure of ISO/IEC 7816-4
* Storage of symmetric keys, without the possibility of exports from device

## Examples of usage

### Initialize

```bash
$ pkcs15-init --erase-card
$ pkcs15-init --create-pkcs15 --so-pin "87654321" --so-puk "" --pin "12345678"
$ pkcs15-init --store-pin --label "User PIN" --auth-id 02 --pin "12345678" --puk ""
```

### If APDU-command is hanging

```bash
$ opensc-explorer
Using reader with a card: Rutoken S driver
OpenSC [3F00]> apdu 80:8A:00:00
OpenSC [3F00]> mkdir 3F00 0
OpenSC [3F00]> exit
```

And continue with the Initialize procedure above
