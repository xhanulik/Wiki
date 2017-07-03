# Test Results

:white_check_mark: All test cases passed.  :accept: Some tests cases passed.  :white_circle: Untested.

## OpenSC 0.17.0

| Installer    | Windows            | macOS              |
| ------------ | :----------------: | :----------------: |
| Installation | :white_check_mark: | :white_check_mark: |
| Removal      | :white_check_mark: | :white_check_mark: |

The table below shows a list of all supported card drivers (`opensc-tool --list-drivers`) that have been tested in this release:

| Smart Card Driver | PKCS#11            | Windows Minidriver | macOS Tokend       |
| ----------------- | :----------------: | :----------------: | :----------------: |
| cardos            | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| flex              | :white_circle:     | :white_circle:     | :white_circle:     |
| cyberflex         | :white_circle:     | :white_circle:     | :white_circle:     |
| gpk               | :white_circle:     | :white_circle:     | :white_circle:     |
| gemsafeV1         | :white_circle:     | :white_circle:     | :white_circle:     |
| miocos            | :white_circle:     | :white_circle:     | :white_circle:     |
| asepcos           | :white_circle:     | :white_circle:     | :white_circle:     |
| starcos           | :white_circle:     | :white_circle:     | :white_circle:     |
| tcos              | :white_circle:     | :white_circle:     | :white_circle:     |
| jcop              | :white_circle:     | :white_circle:     | :white_circle:     |
| oberthur          | :white_circle:     | :white_circle:     | :white_circle:     |
| authentic         | :white_circle:     | :white_circle:     | :white_circle:     |
| iasecc            | :accept:           | :white_circle:     | :accept:           |
| belpic            | :white_check_mark: | :white_circle:     | :white_circle:     |
| incrypto34        | :white_circle:     | :white_circle:     | :white_circle:     |
| acos5             | :white_circle:     | :white_circle:     | :white_circle:     |
| akis              | :white_circle:     | :white_circle:     | :white_circle:     |
| entersafe         | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| epass2003         | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| rutoken           | :white_circle:     | :white_circle:     | :white_circle:     |
| rutoken_ecp       | :white_circle:     | :white_circle:     | :white_circle:     |
| westcos           | :white_circle:     | :white_circle:     | :white_circle:     |
| myeid             | :white_circle:     | :white_circle:     | :white_circle:     |
| sc-hsm            | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| dnie              | :white_circle:     | :white_circle:     | :white_circle:     |
| MaskTech          | :white_circle:     | :white_circle:     | :white_circle:     |
| mcrd              | :white_circle:     | :white_circle:     | :white_circle:     |
| setcos            | :white_circle:     | :white_circle:     | :white_circle:     |
| muscle            | :white_circle:     | :white_circle:     | :white_circle:     |
| atrust-acos       | :white_circle:     | :white_circle:     | :white_circle:     |
| PIV-II            | :white_check_mark: | :white_circle:     | :white_circle:     |
| cac               | :white_check_mark: | :white_circle:     | :white_circle:     |
| itacns            | :white_circle:     | :white_circle:     | :white_circle:     |
| isoApplet         | :accept:           | :white_circle:     | :white_circle:     |
| gids              | :white_circle:     | :white_circle:     | :white_circle:     |
| openpgp           | :accept:           | :white_circle:     | :white_circle:     |
| jpki              | :white_check_mark: | :accept:           | :accept:           |
| coolkey           | :white_check_mark: | :white_circle:     | :white_circle:     |
| npa               | :accept:           | :white_circle:     | :accept:           |
| default           | :white_circle:     | :white_circle:     | :white_circle:     |

The table below shows a list of all tested smart cards that were used:

| Smart Card Driver | Tested Smart Cards                               |
| ----------------- | ------------------------------------------------ |
| cardos            | CardOS 4.3B                                      |
| sc-hsm            | GoID 0.9                                         |
| npa               | German ID card                                   |
| PIV-II            | NIST demo PIV card 1, 10                         |
| cac               | Expired test CAC card                            |
| iasecc            | IAS/ECC Gemalto, Gemalto MultiApp IAS/ECC v1.0.1 |
| openpgp           | OpenPGP v2.0 card (ZeitControl)                  |
| openpgp           | Yubikey NEO                                      |
| coolkey           | coolkey applet on SafeNet Java card              |
| sc-hsm            | Nitrokey Nitrokey HSM                            |
| cardos            | CardOS 5.3                                       |

# Test Cases

## Installer

### Installation

##### Windows
###### Test Steps
1. Open the OpenSC installer (*msi* file extension)
2. Follow the prompts for installation.
###### Expected Result
OpenSC has been installed

##### macOS
###### Test Steps
1. Open the OpenSC image (*dmg* file extension)
1. Open the OpenSC installer (*pkg* file extension)
2. Follow the prompts for installation.
###### Expected Result
OpenSC has been installed

### Removal

##### Windows
###### Test Steps
1. Open Control Panel
2. In Category view, click the "Uninstall a program" link under the "Programs" category. In Icon view, click the "Programs and Features" icon.
3. Find and select "OpenSC smartcard framework".
4. Click "Uninstall"
5. Depending on which programs have loaded OpenSC, you will be prompted to reboot.
###### Expected Result
OpenSC is removed.

##### macOS
###### Test Steps
1. Open a command line terminal (*Terminal.app*)
2. Run `sudo opensc-uninstall`
3. Enter your password
###### Expected Result
OpenSC is removed.


## PKCS#11

### `pkcs11-tool`

Test random number generation, digest calculation, signature, verification and decryption with the token using the PKCS#11 API.

##### Windows
###### Test Steps
1. Open a command line terminal (*cmd.exe*).
2. Run `"C:\Program Files\OpenSC Project\OpenSC\tools\pkcs11-tool.exe" --login --test`
###### Expected Result
`No errors`

##### Other Operating Systems
###### Test Steps
1. Open a command line terminal.
2. Run `pkcs11-tool --login --test`
###### Expected Result
`No errors`

### Firefox

#### Load OpenSC PKCS#11 Module

###### Test Steps
1. Open the Firefox preferences dialog. Choose *Advanced* > *Encryption* > *Security Devices*
2. Choose *Load*
3. Enter a name for the security module, such as "OpenSC".
4. Choose "Browse..." to find the location of the PKCS11 module on your local computer, and choose "OK" when done.

|          | Location of PKCS#11 module                          |
| -------- | --------------------------------------------------- |
| Windows  | `C:\Windows\System32\onepin-onepsc-pkcs11.dll`      |
| macOS    | `/Library/OpenSC/lib/onepin-opensc-pkcs11.so`       |
| Other OS | `/usr/local/lib/onepin-opensc-pkcs11.so` by default |
###### Expected Result
Certificates and private keys are verified (see command line output). The token's certificates are shown in a dialog.

#### PIN Verification

###### Preconditions
* OpenSC PKCS#11 module is loaded
###### Test Steps
1. Put the token on the reader.
2. Open the Firefox preferences dialog. Choose *Advanced* > *Encryption* > *Security Devices*
3. Select your Token from the *OpenSC* security device
4. Click *Log In* and verify your PIN
###### Expected Result
User is logged in. The *Log Out* button becomes available.

#### TLS Client Authentication

###### Preconditions
* The web server is configured for client authentication with the token's certificate.
###### Test Steps
1. Put the token on the reader.
1. Browse to the web server.
2. Select a certificate from the token for authentication in the popup dialog.
4. Verify your PIN.
###### Expected Result
User is authenticated.

## Windows Minidriver

### `certutil -scinfo`

Verify certificates and test private keys of the token.

###### Test Steps
1. Open a command line terminal (*cmd.exe*).
2. Run `certutil -scinfo`
###### Expected Result
Certificates and private keys are verified (see command line output). The token's certificates are shown in a dialog.

### Windows Login or Unlock

###### Preconditions
* The user's account is configured for login with the token's certificate.
* Screen is locked by the user or the user is logged out.
###### Test Steps
1. Put the token on the reader.
1. If needed, choose *Other Credentials* and select the smart card.
2. Verify your PIN.
###### Expected Result
User is logged in.

### TLS Client Authentication with Internet Explorer, Edge or Chrome

###### Preconditions
* The web server is configured for client authentication with the token's certificate.
###### Test Steps
1. Put the token on the reader.
1. Browse to the web server.
2. Select a certificate from the token for authentication in the popup dialog.
4. Verify your PIN.
###### Expected Result
User is authenticated.

### Change PIN

###### Test Steps
1. Put the token on the reader.
2. Press *CTRL* + *Alt* + *Del*
1. Choose *Change a password*
1. Choose *Other Credentials* and select the smart card.
2. Without a PIN pad reader change your PIN with the screen shown. With a PIN pad reader, leave the text fields empty and change your PIN on the reader.
###### Expected Result
PIN is changed.

## macOS Tokend

### Keychain Access

###### Test Steps
1. Put the token on the reader.
2. Open Keychain Access (*keychainaccess.app*), which is in the Utilities folder of your Applications folder.
3. Find and click your token in the *Keychains* panel in the upper left. The main window shows the token's certificate.
4. Click the closed lock in the upper left corner to verify your PIN.
###### Expected Result
User is logged in, the lock is unlocked.

### TLS Client Authentication with Safari or Chrome

###### Preconditions
* The web server is configured for client authentication with the token's certificate.
###### Test Steps
1. Put the token on the reader.
1. Browse to the web server.
2. Select a certificate from the token for authentication in the popup dialog.
4. Verify your PIN.
###### Expected Result
User is authenticated.