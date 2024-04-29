# Oberthur AuthentIC v3

## Oberthur's card 'COSMO v7' with PKI applet 'AuthentIC v3.1'

The native Oberthur's support of this card&applet is based on the PKCS#15 specification.

## Deviations from PKCS#15 standard

### Sign PIN flags

For 'Sign PIN' the *!PinAttributes.pinFlags* include the `integrity-protected` flag.
In reality, for the actually available cards, the ACLs of this PIN do not need SM.
The OpenSC support of this card uses `integrity-protected` flag to differentiate 'User PIN' and 'Sign PIN'.

For 'Sign PIN' and 'Sign PUK' the `!PinAttributes.pinFlags` include the `local` flag .
In fact, for the 'AuthentIC v3' applet all credentials (including PINs) are globals.
In the OpenSC ASN.1 parser this flag is explicitly suppressed for the 'AuthentIC v3' card.

### 'NONE' security condition

It seems that Oberthur middleware do not accept 'NONE' as security condition in the access rules of the private RSA keys.
Actually in the OpenSC card profile all ACLs of the private keys are set to 'CHV1'.

### EF(DIR) content

EF(DIR) contains the 'Discretionary ASN.1 data object' (RSA PKCS#15 v1.1 pp 10) with tag '73'.
The mandatory OID is absent. Also the 'odfPath' and 'tokenInfoPath' are incomplete - the value of the both is the parent DF and not full path.

### 'GET CHALLENGE'

For the APDU command 'GET CHALLENGE' number of returned bytes do not depends on Le, it's always 24 bytes.

### 'Supported algorithms' for public keys

For Oberthur's middleware the 'Supported algorithms' are mandatory in PKCS#15 encoding of the public keys.
Oberthur's middleware do not returns the CKA_MODULUS of the private keys.
(By the way, it provokes the seg.fault in NSS library - there is an attempt to dereference NULL pointer in the PK11_GetPrivateModulusLen() function).

### 'External Authentication'

For a moment it's not working.
In any APDU commands context the `EXTERNAL AUTHENTICATION` command returns `6985` - `GET CHALLENGE is not the previous command`.
Waiting for answer from Oberthur.
