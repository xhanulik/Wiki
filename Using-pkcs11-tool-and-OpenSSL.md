This document was [initially](https://gist.github.com/Jakuje/5a993d2b2d8a9cac35203599e49e6831) created for myself to memorize many command line options and because it was very handy for debugging to issue single operation to the PKCS#11 module for debugging. But it can be also useful for others who are interested in scripting these tasks or who are just curious what they can do with their new smart card.

These commands expect they are run from the `src/tools` directory of the local build of OpenSC on Linux, but with slight modification can be used on other platforms and with installed OpenSC. The start are constants that are used all over and over. Note that setting a PIN to environment variable is simple for debugging purposes, but it is **not secure for production**. If you PIN is valuable, use the `--login` switch, which will prompt you for the PIN during the execution.

    export PIN=111111
    export SIGN_KEY=11
    export ENC_KEY=55

You can find the IDs of the objects on card with the `-O` option:

    pkcs11-tool -O

and the mechanisms that the card supports with the `-M` option:

    pkcs11-tool -M

# Sign/Verify using private key/certificate

 * Create a data to sign

       echo "data to sign (max 100 bytes)" > data

 * Get the certificate from the card:
 
       ./src/tools/pkcs11-tool -r -p $PIN --id $SIGN_KEY --type cert --module ./src/pkcs11/.libs/opensc-pkcs11.so > $SIGN_KEY.cert

 * Convert it to the public key (PEM format)
 
       openssl x509 -inform DER -in $SIGN_KEY.cert -pubkey > $SIGN_KEY.pub

or 

 * Get the public key from the card:
 
        ./src/tools/pkcs11-tool -r -p $PIN --id $SIGN_KEY --type pubkey --module ./src/pkcs11/.libs/opensc-pkcs11.so > $SIGN_KEY.der
 
 * Convert it to PEM format:
 
       openssl rsa -inform DER -outform PEM -in $SIGN_KEY.der -pubin > $SIGN_KEY.pub

## RSA-PKCS

 * Sign the data on the smartcard using private key:
 
       ./src/tools/pkcs11-tool --id $SIGN_KEY -s -p $PIN -m RSA-PKCS --module ./src/pkcs11/.libs/opensc-pkcs11.so --input-file data --output-file data.sig

 * Verify
 
       openssl rsautl -verify -inkey $SIGN_KEY.pub -in data.sig -pubin

## SHA1-RSA-PKCS

 * Sign the data on the smartcard using private key:
 
       ./src/tools/pkcs11-tool --id $SIGN_KEY -s -p $PIN -m SHA1-RSA-PKCS --module ./src/pkcs11/.libs/opensc-pkcs11.so --input-file data --output-file data.sig

 * Verify and parse the returned ASN1 structure:
 
       openssl dgst -keyform PEM -verify $SIGN_KEY.pub -sha1 -signature data.sig data

 Similarly can be tested the SHA256, SHA384 and SHA512, just by replacing SHA1 with these hashes in above commands.

## SHA1-RSA-PKCS-PSS

* Sign the data on the smartcard using private key:
 
       ./src/tools/pkcs11-tool --id $SIGN_KEY -s -p $PIN -m SHA1-RSA-PKCS-PSS --module ./src/pkcs11/.libs/opensc-pkcs11.so --input-file data --output-file data.sig

 * Verify
 
       openssl dgst -keyform DER -verify $SIGN_KEY.pub -sha1 -sigopt rsa_padding_mode:pss -sigopt rsa_pss_saltlen:-1 -signature data.sig data

For other parameters, replace the hash algorithms, add a `--salt-len` parameter for the `pkcs11-tool` and adjust `rsa_pss_saltlen` argument of `openssl`.

## RSA-PKCS-PSS

* Prepare the data for signature -- need to be hashed outside of the module and the hash function needs to match the hash length provided:

       openssl dgst -binary -sha256 data > data.sha256

* Sign

       ./src/tools/pkcs11-tool --id $SIGN_KEY -s -p $PIN -m RSA-PKCS-PSS --hash-algorithm SHA256 --mgf MGF1-SHA256 --module ./src/pkcs11/.libs/opensc-pkcs11.so --input-file data.sha256 --output-file data.sig

* Verify

       openssl dgst -keyform DER -verify $SIGN_KEY.pub -sha256 -sigopt rsa_padding_mode:pss -sigopt rsa_pss_saltlen:-1  -sigopt rsa_mgf1_md:sha256 -signature data.sig data

Note that here we use the original data file and we leave OpenSSL to hash it for us. OpenSSL does not support this form of PSS mechanism without hashing outside of the module.

## RSA-X-509

 * Prepare data with padding:
 
       (echo -ne "\x00\x01" && for i in `seq 224`; do echo -ne "\xff"; done && echo -ne "\00" && cat data) > data_pad

 * Sign the data on the smartcard using private key:
 
       ./src/tools/pkcs11-tool --id $SIGN_KEY -s -p $PIN -m RSA-X-509 --module ./src/pkcs11/.libs/opensc-pkcs11.so --input-file data_pad --output-file data_pad.sig

 * Verify
 
       openssl rsautl -verify -inkey $SIGN_KEY.pub -in data_pad.sig -pubin -raw

## EdDSA (WIP)

The EdDSA keys were introduced in PKCS #11 3.0 in ~2020 and are not widely supported yet. The only card out there is GNUK (OpenPGP card) and I will demonstrate tests on it:

 * Sign data using a key on card:

      ./src/tools/pkcs11-tool --sign -m EDDSA --id $SIGN_KEY --slot 1 --pin $PIN --input-file data --output-file data.sig  --module ./src/pkcs11/.libs/opensc-pkcs11.so

 * Verify data using OpenSC (the -rawin option is still only in openssl master :( ):

      openssl pkeyutl -verify -inkey eddsa.pem -in data -sigfile data.sig -pubin -rawin


# Encrypt/Decrypt using private key/certificate

 * Create a data to encrypt
 
       echo "data to encrypt should be longer, better, faster and whatever we need to hide" > data

 * Get the certificate from the card:
 
       ./src/tools/pkcs11-tool -r -p $PIN --id $ENC_KEY --type cert --module ./src/pkcs11/.libs/opensc-pkcs11.so > $ENC_KEY.cert

 * Convert it to the public key (PEM format)
 
       openssl x509 -inform DER -in $ENC_KEY.cert -pubkey > $ENC_KEY.pub

## RSA-PKCS

 * Encrypt the data locally
 
       openssl rsautl -encrypt -inkey $ENC_KEY.pub -in data -pubin -out data.crypt

 * Decrypt the data on the card
 
       ./src/tools/pkcs11-tool --id $ENC_KEY --decrypt -p $PIN -m RSA-PKCS --module ./src/pkcs11/.libs/opensc-pkcs11.so --input-file data.crypt

## RSA-X-509

 * Prepare data with padding:
 
       (echo -ne "\x00\x02" && for i in `seq 113`; do echo -ne "\xff"; done && echo -ne "\00" && cat data) > data_pad

 * Encrypt the data locally
 
       openssl rsautl -encrypt -inkey $ENC_KEY.pub -in data_pad -pubin -out data_pad.crypt -raw

 * Decrypt the data on the card
 
       ./src/tools/pkcs11-tool --id $ENC_KEY --decrypt -p $PIN -m RSA-X-509 --module ./src/pkcs11/.libs/opensc-pkcs11.so --input-file data_pad.crypt

## RSA-PKCS-OAEP

 * Encrypt the data locally
 
       openssl rsautl -encrypt -inkey $ENC_KEY.pub -in data -pubin -out data.crypt -oaep
   or
   
       openssl pkeyutl -encrypt -inkey $ENC_KEY.pub -pubin -pkeyopt rsa_padding_mode:oaep -pkeyopt rsa_oaep_md:sha256 -pkeyopt rsa_mgf1_md:sha256 -in data -out data.sha256.crypt

 * Decrypt the data on the card
 
       ./src/tools/pkcs11-tool --id $ENC_KEY --decrypt -p $PIN -m RSA-PKCS-OAEP --module ./src/pkcs11/.libs/opensc-pkcs11.so --input-file data.crypt

    or

       ./src/tools/pkcs11-tool --id $ENC_KEY --decrypt -p $PIN -m RSA-PKCS-OAEP --hash-algorithm=sha256  --module ./src/pkcs11/.libs/opensc-pkcs11.so --input-file data.sha256.crypt
