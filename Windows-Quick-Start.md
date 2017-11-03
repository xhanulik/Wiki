## 1. Download the MSIs

Download the [latest release of OpenSC](https://github.com/OpenSC/OpenSC/releases/latest). For an 64 bit operating system download both, the 32 bit *and* the 64 bit installer.

OpenSC offers the standard distribution as well as a light weight distribution. The light weight variant is compiled without external dependencies (such as OpenSSL or zlib) and has a limited set of card drivers and smart card tools.

## 2. Install the MSIs

Run the installers as administrator.

The *Typical* and *Complete* installation type install all available components. A *Custom Setup* allows disabling some of the following features:

* *OpenSC PKCS#11 module*: PKCS#11 module usd by most open source and cross-platform software (like Firefox, Putty, TrueCrypt, OpenVPN etc)
* *PKCS#11 Spy module*: Module of the PKCS#11 spy.
* *OpenSC minidriver*: OpenSC minidriver for using smart cards with native Windows CSP applications (like Internet Explorer)
* *Tools and profiles*: Tools for debugging and personalization. Includes profiles needed for running pkcs15-init.exe
* *Start menu entries*: Start menu entries: link to documentation

A 32 bit application running on 64 bit operating systems needs the 32 bit minidriver or 32 bit PKCS#11 module respectively. For this reason, on an 64 bit operating system install both, the 32 bit *and* 64 bit installer.

## 3. Test your installation

Upon successful installation the 32 bit (and 64 bit) minidriver have successfully been registered with their registry keys in `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography\Calais\SmartCards` (the 32 bit keys on an 64 bit OS are available in `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Wow6432Node\Cryptography\Calais\SmartCards`).

The PKCS#11 modules have been installed as `C:\Windows\System32\opensc-pkcs11.dll` and `C:\Windows\System32\onepin-opensc-pkcs11.dll` (the 32 bit libraries on an 64 bit OS are available as `C:\Windows\SysWOW64\opensc-pkcs11.dll` and `C:\Windows\SysWOW64\onepin-opensc-pkcs11.dll`)

You may test minidriver support of your card with
```
C:\Windows\System32\certutil.exe -scinfo
C:\Windows\SysWOW64\certutil.exe -scinfo
```

You may test the PKCS#11 support of your card with
```
"C:\Program Files\OpenSC Project\OpenSC\tools\pkcs11-tool.exe" --login --test
"C:\Program Files (x86)\OpenSC Project\OpenSC\tools\pkcs11-tool.exe" --login --test
```

## 4. Customize your configuration

Change the default configuration file `C:\Program Files\OpenSC Project\OpenSC\opensc.conf` to your needs. The configuration options are explained within this file. For 32 bit applications on an 64 bit OS you need to also edit `C:\Program Files (x86)\OpenSC Project\OpenSC\tools\opensc.conf`.

## 5. Uninstall OpenSC

Open the *Control Panel* and click on the *Uninstall a program* option under the *Programs* category. If you are using the Classic View of the *Control Panel*, then double-click on the *Programs and Features* icon instead. From the list of installed programs, choose *OpenSC smartcard framework* and click *Uninstall*. Do the same for *OpenSC smartcard framework (64bit)*.

It is possible that a background process locks the minidriver library though uninstalling is successful. Remove `C:\Windows\System32\opensc-minidriver.dll` and `C:\Windows\SysWOW64\opensc-minidriver.dll` manually if required.