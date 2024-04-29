# MacOS Quick Start

1. Download the DMG

    Download the [latest release of OpenSC](https://github.com/OpenSC/OpenSC/releases/latest).

2. Install the PKG

    Opening the DMG-file loads the OpenSC bundle into Finder. Open the contextual menu of the installation package (e.g. use a two-finger tap on trackpad) and choose *Open*. Skip the warning about the package's origin and follow the installation guide.

    Since we aren't currently signing the installation package, double clicking cannot be used to install OpenSC, see <https://support.apple.com/en-en/guide/mac-help/mh40616/mac>.

    A Custom Setup allows disabling some of the following features:

    - *PKCS#11 module and smart card tools*: PKCS#11 module used by most open source and cross-platform software (like Firefox, SSH, TrueCrypt, OpenVPN etc) as well as tools for debugging and personalization.
    - *Automatic startup items*: Registers PKCS#11 module and notification capabilities on startup
    - *CryptoTokenKit-based smart card driver*: OpenSC CTK plugin for using smart cards with native macOS applications (like Safari, iMail, Chrome, `sc_auth` etc)

3. Test your installation

    Upon successful installation, OpenSC is installed in `/Library/OpenSC`, the `tokend` module was registered and links to the OpenSC tools have been created in `/usr/local/bin`.

    The PKCS#11 modules have been installed as `/Library/OpenSC/lib/opensc-pkcs11.so` and `/Library/OpenSC/lib/onepin-opensc-pkcs11.so` (copies of the libraries are available in `/usr/local/lib`).

    You may test `tokend` support of you card with *Keychain Access*. The app should list your smart card in the *Keychains* pane on the upper left side. Click the lock to verify the smart card PIN and to allow access to the card's keys.

    You may test the PKCS#11 support of your card with

    ```bash
    /Library/OpenSC/bin/pkcs11-tool --login --test
    ```

4. Customize your configuration

    Change the default configuration file `/Library/OpenSC/etc/opensc.conf` to your needs. The configuration options are explained within this file.

5. Uninstall OpenSC

    From the OpenSC bundle double click the *OpenSC Uninstaller*. Alternatively, run the following from the command line:

    ```bash
    sudo opensc-uninstall
    ```

6. Code Signing

    Code signing is fully integrated with the automatic build process for OpenSC releases and nightly builds. We are grateful to Tim Wilbrink, who as member of Apple's developer program is signing the OpenSC binaries.
