# Installing OpenSC PKCS#11 Module in Firefox, Step by Step

This step by step description is can also be found in "Mozilla's knowledge base":https://developer.mozilla.org/en-US/docs/Mozilla/Projects/NSS/PKCS11/Module_Installation.

1. Start Mozilla Firefox.

    ![Start Firefox](https://github.com/n8felton/OpenSC/wiki/attachments/wiki/MozillaSteps/firefox_64.png "Start Firefox")

2. Click the `Menu Button` and choose `Options`.

    ![Open options](https://github.com/n8felton/OpenSC/wiki/attachments/wiki/MozillaSteps/FirefoxESR52_1.png "Open options")

3. Open `Security Devices`

   * For Firefox Release 55 and below, click `Advanced` and switch to the `Certificates` tab. Click `Security Devices`.

      ![Open Security Devices](https://github.com/n8felton/OpenSC/wiki/attachments/wiki/MozillaSteps/FirefoxESR52_2.png "ecurity Devices")

   * For Firefox Release 56 and up, click `Privacy & Security`, scroll down and click `Security Devices`.

      ![Open Security Devices](https://github.com/bob-fontana/OpenSC/blob/master/attachments/wiki/MozillaSteps/FirefoxESR56_3.png "Open Security Devices")

4. Click on `Load`.

    ![Load](https://github.com/n8felton/OpenSC/wiki/attachments/wiki/MozillaSteps/FirefoxESR52_3.png "Load")

5. Change the `Module Name` to `OpenSC PKCS#11 Module`. Click on `Browse...`*.

    ![Browse](https://github.com/n8felton/OpenSC/wiki/attachments/wiki/MozillaSteps/FirefoxESR52_5.png "Browse")

6. Select the installation directory.

    | Platform | Directory Path |
    | -------- | -------------- |
    | Windows 32 Bit | `C:\Program Files\OpenSC Project\OpenSC\pkcs11` |
    | Windows 64 Bit with Firefox 64 Bit | `C:\Program Files\OpenSC Project\OpenSC\pkcs11` |
    | Windows 64 Bit with Firefox 32 Bit | `C:\Program Files (x86)\OpenSC Project\OpenSC\pkcs11` |
    | macOS | `/Library/OpenSC/lib/` |
    | macOS (installation with brew) | `/usr/local/Cellar/opensc/[VERSION]/lib/pkcs11/` |
    | Linux | `/usr/lib/` |

    Click on `opensc‑pkcs11.dll` (Windows) or `opensc‑pkcs11.so` (Linux, macOS). Click `Open`.

    ![Open library](https://github.com/n8felton/OpenSC/wiki/attachments/wiki/MozillaSteps/FirefoxESR52_4.png "Open library")

7. Verify the new module is loaded. Click `OK` to close the Device Manager.

    ![Confirm changes](https://github.com/n8felton/OpenSC/wiki/attachments/wiki/MozillaSteps/FirefoxESR52_6.png "Confirm changes")
