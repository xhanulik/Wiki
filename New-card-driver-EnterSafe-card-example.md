# New card driver: EnterSafe card example

## Example (entersafe card)

* [card-entersafe.c](https://github.com/OpenSC/OpenSC/blob/master/src/libopensc/card-entersafe.c) `sc_get_entersafe_driver`

```C
struct sc_card_driver * sc_get_entersafe_driver(void)
{
    return sc_get_driver();
}
```

* [ctx.h](https://github.com/OpenSC/OpenSC/blob/master/src/libopensc/ctx.c)

```C
#ifdef ENABLE_OPENSSL
{ "entersafe",(void *(*)(void)) sc_get_entersafe_driver },
```

* [cards.h](https://github.com/OpenSC/OpenSC/blob/master/src/libopensc/cards.h)

```C
extern sc_card_driver_t *sc_get_entersafe_driver(void);
```

* [Makefile.am](https://github.com/OpenSC/OpenSC/blob/master/src/libopensc/Makefile.am)

```C
card-oberthur.c card-belpic.c card-atrust-acos.c card-entersafe.c \
```

* [Makefile.mak](https://github.com/OpenSC/OpenSC/blob/master/src/libopensc/Makefile.mak)

```C
card-oberthur.obj card-belpic.obj card-atrust-acos.obj card-entersafe.obj \
```

* [cards.h](https://github.com/OpenSC/OpenSC/blob/master/src/libopensc/cards.h) skeleton

```C
/* EnterSafe cards */
SC_CARD_TYPE_ENTERSAFE_BASE = 19000,
SC_CARD_TYPE_ENTERSAFE_3K,
SC_CARD_TYPE_ENTERSAFE_FTCOS_PK_01C,
```

* ATR in [card-entersafe.c](https://github.com/OpenSC/OpenSC/blob/master/src/libopensc/card-entersafe.c)

```C
static struct sc_atr_table entersafe_atrs[] = {
    { 
         "3b:0f:00:65:46:53:05:19:05:71:df:00:00:00:00:00:00", 
         "ff:ff:ff:ff:ff:ff:ff:00:ff:ff:ff:00:00:00:00:00:00", 
         "ePass3000", SC_CARD_TYPE_ENTERSAFE_3K, 0, NULL },
    { 
         "3b:9f:95:81:31:fe:9f:00:65:46:53:05:30:06:71:df:00:00:00:80:6a:82:5e",
         "FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:00:FF:FF:FF:FF:FF:FF:00:00:00:00",
         "FTCOS/PK-01C", SC_CARD_TYPE_ENTERSAFE_FTCOS_PK_01C, 0, NULL },
    { NULL, NULL, NULL, 0, 0, NULL }
};
```

```C
/* the entersafe part */
static int entersafe_match_card(sc_card_t *card)
{
    int i;
    SC_FUNC_CALLED(card->ctx, SC_LOG_DEBUG_VERBOSE);

    i = _sc_match_atr(card, entersafe_atrs, &card->type);
    if (i < 0)
    return 0;

    return 1;
}
```

* PIN_CMD in [card-entersafe.c](https://github.com/OpenSC/OpenSC/blob/master/src/libopensc/card-entersafe.c)

### References

* [Example step by step](https://github.com/alediator/OpenSC/wiki/OpenSC-driver-Example)
