Many of the internal card drivers have not been modified or used in years (`card-*.c` and their `pkcs15-*.c` counterpart). Although they may have gotten touched due to general security fixes, these changes are mostly untested with these card drivers. Most likely these cards are not in use anymore. To reduce the overall attack surface, we are planning to remove the old card drivers.

## Card Driver Overview

| Driver               | To be Deactivated | To be Removed | User Activity                                                    | Developer Activity                                                                       |
| -------------------- | ----------------- | ------------- | ---------------------------------------------------------------- | ---------------------------------------------------------------------------------------- |
| `card-acos5.c`       | no                | no            |                                                                  | [2015](https://github.com/OpenSC/OpenSC/commit/548c2780d3faf9419c09aea5d5909b5d82685515) |
| `card-akis.c`        | yes               | no            |                                                                  | [2007](https://github.com/OpenSC/OpenSC/commit/f9476144182dcc1568518f436ec8e5368841902a) |
| `card-asepcos.c`     | no                | no            |                                                                  | [2010](https://github.com/OpenSC/OpenSC/commit/02c35be138d67b290e0a3fe239a1db739c1c6fe3) |
| `card-atrust-acos.c` | yes               | no            |                                                                  | [2008](https://github.com/OpenSC/OpenSC/commit/a4bad4452e7d6acdb75c129fa28c5291f4606b79) |
| `card-authentic.c`   | no                | no            |                                                                  | [2012](https://github.com/OpenSC/OpenSC/commit/f9a13179d88bb1aa09b3d3ca74c93991ec92ecd4) |
| `card-belpic.c`      | no                | no            |                                                                  | [2015](https://github.com/OpenSC/OpenSC/commit/5149dd3e62594eb2477f699d834584991ab54d5f) |
| `card-cac.c`         | no                | no            | [2017](https://github.com/OpenSC/OpenSC/wiki/Smart-Card-Testing) | [2017](https://github.com/OpenSC/OpenSC/commit/0dcf6732960878f242e1922c14edfccb80027887) |
| `card-cardos.c`      | no                | no            | [2017](https://github.com/OpenSC/OpenSC/wiki/Smart-Card-Testing) | [2017](https://github.com/OpenSC/OpenSC/commit/eeeefecf122e9a81ddc82ab3ec716953d2b1c387) |
| `card-coolkey.c`     | no                | no            | [2017](https://github.com/OpenSC/OpenSC/wiki/Smart-Card-Testing) | [2017](https://github.com/OpenSC/OpenSC/commit/6aa52ce7530717107b3a617cfb9a0890d12488d2) |
| `card-dnie.c`        | no                | no            | [2017](https://github.com/OpenSC/OpenSC/wiki/Smart-Card-Testing) | [2017](https://github.com/OpenSC/OpenSC/commit/d9d247e6cd826ea3f08ad29f8d29e6ca06c78f21) |
| `card-entersafe.c`   | no                | no            | [2017](https://github.com/OpenSC/OpenSC/wiki/Smart-Card-Testing) | [2017](https://github.com/OpenSC/OpenSC/commit/45e1732bb5b020ceaf1892527c784294b28b67a8) |
| `card-epass2003.c`   | no                | no            | [2017](https://github.com/OpenSC/OpenSC/wiki/Smart-Card-Testing) | [2017](https://github.com/OpenSC/OpenSC/commit/8d7346406d166a9db4afd239e6669df3e3b99f79) |
| `card-flex.c`        | no                | no            |                                                                  | [2010](https://github.com/OpenSC/OpenSC/commit/7d935df1bc65022ef80a40f8721f0fa8e3709289) |
| `card-gemsafeV1.c`   | no                | no            |                                                                  | [2016](https://github.com/OpenSC/OpenSC/commit/b2f6abded3ad9b2c00bfe97f69e7433a6cefa632) |
| `card-gids.c`        | no                | no            |                                                                  | [2017](https://github.com/OpenSC/OpenSC/commit/8965ee38dde5a394e0c1264136324b2d855a1d69) |
| `card-gpk.c`         | yes               | no            |                                                                  | [2007](https://github.com/OpenSC/OpenSC/commit/a8908b8548e02d320376844b3d9668f0f89b3c29) |
| `card-iasecc.c`      | no                | no            | [2017](https://github.com/OpenSC/OpenSC/wiki/Smart-Card-Testing) | [2015](https://github.com/OpenSC/OpenSC/commit/fe31aceacb86a02d138748e316de7af25269f551) |
| `card-incrypto.c`    | yes               | no            |                                                                  | [2007](https://github.com/OpenSC/OpenSC/commit/a2f622a21521cb350541894d80e3266b5f2f5612) |
| `card-isoApplet.c`   | no                | no            | [2017](https://github.com/OpenSC/OpenSC/wiki/Smart-Card-Testing) | [2015](https://github.com/OpenSC/OpenSC/commit/6bffeb7a363a4d17b5acc4ed927f6ec02ff5adf7) |
| `card-itacns.c`      | no                | no            |                                                                  | [2014](https://github.com/OpenSC/OpenSC/commit/7fea6eb8ba0caa431cf1c8ff493c4ac5a216a11f) |
| `card-jcop.c`        | yes               | yes           |                                                                  | [2003](https://github.com/OpenSC/OpenSC/commit/f761d1504fa0d173c79df30d9ef64aacf2909a2b) |
| `card-jpki.c`        | no                | no            | [2017](https://github.com/OpenSC/OpenSC/wiki/Smart-Card-Testing) | [2017](https://github.com/OpenSC/OpenSC/commit/da9484bd6b4052ea6fb022d27bd7e75350d6cf76) |
| `card-masktech.c`    | no                | no            |                                                                  | [2015](https://github.com/OpenSC/OpenSC/commit/56c376489f4544d3f09bb71de675621ca51e6b12) |
| `card-mcrd.c`        | no                | no            |                                                                  | [2013](https://github.com/OpenSC/OpenSC/commit/a0ceaeecab6a6764e14622fe0aeb4894d2ae280d) |
| `card-miocos.c`      | yes               | yes           |                                                                  | [2003](https://github.com/OpenSC/OpenSC/commit/30c094395aeea1cfc20b4c0a25dd8107ef809fd3) |
| `card-muscle.c`      | no                | no            |                                                                  | [2015](https://github.com/OpenSC/OpenSC/commit/5898eab3732f73550b36b6dae4a947dfd0c6f4e2) |
| `card-myeid.c`       | no                | no            | [2017](https://github.com/OpenSC/OpenSC/wiki/Smart-Card-Testing) | [2017](https://github.com/OpenSC/OpenSC/commit/deab9cce73377f973d2020ab5ab7adc302018bf6) |
| `card-npa.c`         | no                | no            | [2017](https://github.com/OpenSC/OpenSC/wiki/Smart-Card-Testing) | [2017](https://github.com/OpenSC/OpenSC/commit/6bfb39454bcb51bec350037ca15b760c244a8fd9) |
| `card-oberthur.c`    | no                | no            |                                                                  | [2016](https://github.com/OpenSC/OpenSC/commit/e9786bfb345f9907ae1007f80d94f6eb3f773d59) |
| `card-openpgp.c`     | no                | no            | [2017](https://github.com/OpenSC/OpenSC/wiki/Smart-Card-Testing) | [2016](https://github.com/OpenSC/OpenSC/commit/dc476a9f3313a0aab4ea09220a8763765fe639f2) |
| `card-piv.c`         | no                | no            | [2017](https://github.com/OpenSC/OpenSC/wiki/Smart-Card-Testing) | [2017](https://github.com/OpenSC/OpenSC/commit/4ea2828246549b39df885ac992800772df322c50) |
| `card-rtecp.c`       | no                | no            |                                                                  | [2017](https://github.com/OpenSC/OpenSC/commit/a0870826a254df14970ca862f1c6c09b16f2e18e) |
| `card-rutoken.c`     | no                | no            |                                                                  | [2010](https://github.com/OpenSC/OpenSC/commit/ac0a8dbb150474910ebfd5389301fa1452f0cfe0) |
| `card-sc-hsm.c`      | no                | no            | [2017](https://github.com/OpenSC/OpenSC/wiki/Smart-Card-Testing) | [2017](https://github.com/OpenSC/OpenSC/commit/a007ab7820357c466d28ac442b53ab71e5dbd4b5) |
| `card-setcos.c`      | no                | no            |                                                                  | [2016](https://github.com/OpenSC/OpenSC/commit/74493ca73f8e3c21c098fecb42a7a08ead85e197) |
| `card-starcos.c`     | no                | no            |                                                                  | [2015](https://github.com/OpenSC/OpenSC/commit/9543cdb121924b331bcf6cbfbccf9f3928472fa9) |
| `card-tcos.c`        | no                | no            |                                                                  | [2011](https://github.com/OpenSC/OpenSC/commit/c97fc2e719f33d6750e6c9d6ff4e5fa9a98a167b) |
| `card-westcos.c`     | no                | no            |                                                                  | [2010](https://github.com/OpenSC/OpenSC/commit/c3de15d2d08061cd6b2a0fabbdaaa7b8a6ede1fa) |

**To be Deactivated**: The card driver will be removed from the default OpenSC configuration. It will be neccessary to enable the card driver in `opensc.conf`

**To be Removed**: The card driver will be removed from the default OpenSC binaries. If the card driver is still present, it will be neccessary to enable it via `./configure --enable-old-drivers`

**User Activity**: Indicates if someone is actively using the card. This may be a bug report, feature request, a question on the mailing list.

**Developer Activity**: Indicates if someone is actively developing and maintaining a card driver. This doesn't include generic fixes, which are untested with the card in question, e.g. fixes for issues that are reported by coverity scan.



## Rationale for Removing a card driver

- A card driver will be deactivated if there was no activity for 7 years or more
- A card driver will be removed if there was no activity for 10 years or more
- Removing a card driver will take at least two release cycles (i.e. one release that deactivates the card driver and a second to remove it)