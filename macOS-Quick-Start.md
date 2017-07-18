## 1. Download the DMG

Download the [latest release of OpenSC](https://github.com/OpenSC/OpenSC/releases/latest).

## 2. Install the PKG

Opening the DMG-file loads the OpenSC bundle into Finder. Open the contextual menu of the installation package (e.g. use a two-finger tap on trackpad) and choose *Open*. Skip the warning about the package's origin and follow the installation guide.

Since we aren't currently signing the installation package, double clicking cannot be used to install OpenSC.

## 3. Test your installation

Upon successful installation, OpenSC is installed in `/Library/OpenSC`, the tokend module was registered and links to the OpenSC tools have been created in `/usr/local/bin`.

The PKCS#11 modules have been installed as `/Library/OpenSC/lib/opensc-pkcs11.so` and `/Library/OpenSC/lib/onepin-opensc-pkcs11.dll` (copies of the libraries are available in `/usr/local/lib`).

You may test tokend support of you card with *Keychain Access*. The app should list your smart card in the *Keychains* pane on the upper left side. Click the lock to verify the smart card PIN and to allow access to the card's keys.

You may test the PKCS#11 support of your card with
```
/Library/OpenSC/lib/pkcs11-tool --login --test
```

## 4. Customize your configuration

Change the default configuration file `/Library/OpenSC/etc/opensc.conf` to your needs. The configuration options are explained within files.