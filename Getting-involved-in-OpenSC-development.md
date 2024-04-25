# Getting involved in OpenSC development

Contributions to OpenSC are welcome! This page explains how to contribute to OpenSC.

## Development process

* OpenSC development is coordinated via the list <opensc-devel@lists.sourceforge.net>. See [[Mailing lists|Mailing-lists]]. Start helping the community by reviewing [GitHub issues](https://github.com/OpenSC/OpenSC/issues) . Patches fixing new or existing issues may be submitted as [GitHub Pull Requests](https://github.com/OpenSC/OpenSC/pulls).
* Contribution should comply with coding guidelines. A minimal [Development Policy](Development-Policy) exists.
* [How to add/support a new card](Adding-a-new-card-driver)
* New features need to be tested. At worst transcript of `pkcs11-tool --test` with your card should be attached to Pull Requests. Even better would be implementation of unit tests systematically testing introduced code.

## Test Tools

* [Minidriver](https://github.com/OpenSC/OpenSC/issues/426#issuecomment-100978020)

## GitHub process

[GitHub](https://github.com) is a web-based hosting service for software development projects using the Git revision control system.

* OpenSC source code is hosted on [GitHub](https://github.com)
* The [OpenSC master branch](https://github.com/OpenSC/OpenSC) is available using:

```bash
git clone git://github.com/OpenSC/OpenSC.git
cd OpenSC
./bootstrap
```

* Read [latest commits](https://github.com/OpenSC/OpenSC/commits/master).
* To start coding, create a [GitHub](https://github.com) account. Creating an account with one project is free. Upload your public ssh keys.
* Visit [OpenSC Github project](https://github.com/OpenSC/OpenSC) and click on Fork to create your own OpenSC repository. Majors features should have their own branch. Bug fixes should go to the Staging branch.
* To propose a commit, make a pull request to the main OpenSC [master](https://github.com/OpenSC/OpenSC/tree/master) repository.
* Advertise your pull request. Pull requests are discussed and applied by github core developers.

## Pull Requests

The github pull requests (PR) to [OpenSC/OpenSC](https://github.com/OpenSC/OpenSC/pulls) are/can-be checked automatically for building on Ubuntu Windows and OSX. At the moment this feature is installed to help the contributors to reveal the compilation errors on the platforms that they do not used to manage (mostly Windows).

The Travis CI runs basic tests on few emulated cards (PIV, IsoApplet, OpenPGP, GIDS, OsEID) to make sure your changes did not break basic functionality of them. Adding more tests is always welcomed.

## The Team

Current developers/maintainers with recent activity in Github, in alphabetical order:

* Alexandre Gonzalo ([GitHub](https://github.com/AlexandreGonzalo))
* Doug Engert ([GitHub](https://github.com/dengert))
* Frank Morgner ([GitHub](https://github.com/frankmorgner))
* Hannu Honkanen ([GitHub](https://github.com/hhonkane))
* Jakub Jelen ([GitHub](https://github.com/Jakuje))
* Jean-Pierre Szikora ([GitHub](https://github.com/szikora))
* Juan Antonio Martinez ([GitHub](https://github.com/jonsito))
* Ludovic Rousseau ([GitHub](https://github.com/LudovicRousseau))
* Marcin Cieślak ([GitHub](https://github.com/saper))
* Martin Paljak ([GitHub](https://github.com/martinpaljak))
* Peter Popovec ([GitHub](https://github.com/popovec))
* Peter Marschall ([GitHub](https://github.com/marschap))
* Raul Metsma ([GitHub](https://github.com/metsma))
* Veronika Hanulíková ([GitHub](https://github.com/xhanulik))
* Viktor Tarasov ([GitHub](https://github.com/viktorTarasov))
* and more

Developers/maintainers with established GIT write access can be found in [OpenSC organization page](https://github.com/orgs/OpenSC/people).

The Emeritus of the OpenSC developer team as well as project chronology is listed on [History-of-the-OpenSC-Project](History-of-the-OpenSC-Project). List of all people who have sent patches to OpenSC is available on [Github|https://github.com/OpenSC/OpenSC/graphs/contributors](Github|https://github.com/OpenSC/OpenSC/graphs/contributors).

## All links

* Donation of free Hardware is always welcome. Thanks for your donation!
* [OpenSC Release Howto](OpenSC-Release-Howto) documents our release process.
* [Resources and Links](Resources,-Links) -- Standards, Documents, etc.
