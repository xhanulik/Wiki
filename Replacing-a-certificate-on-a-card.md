# Replacing a certificate on a card

Unfortunately not all cards allow to replace a certificate with a new one.
Here is a small HOWTO for Aladdin eToken PRO (should work with any CardOS card).

1. Create a new certificate. If it's a self signed certificate, don't forget to add the `-days` attribute, else you'll have to do this process very often.

2. If you have the certificate PEM encoded (this is very likely if you use the default settings of openssl) then convert it to DER encoded:

    ```bash
     $ openssl x509 -in mycert.pem -outform DER -out mycert.der
    ```

3. Now get the path of the certificate:

    ```bash
    $ pkcs15-tool -c
    X.509 Certificate [Certificate]
            Flags    : 2
            Authority: no
            Path     : 3F0050154301
            ID       : 45
    ```

    The path here is: `3F0050154301`

4. Open up `opensc-explorer`:

    ```bash
    OpenSC > cd 5015
    ```

5. Present the valid key for the certificate file, usually the normal pin. You can get info about which pin to use by executing:

    ```bash
    OpenSC > info [EF]
    ```

    where [EF] is the name of the cert EF (in the above example 4301)

    You'll need the key in hexadecimal format, an example how to convert it:

    ```bash
    $ export HISTFILE=
    $ php -r 'echo bin2hex("pssword")."\n";'
    707373776f7264
    ```

    You'll have to add the colons manually. If your password is shorter than 8 characters, fill it up with 00-s. So with the above example you enter at the opensc-explorer:

    ```bash
    OpenSC > verify CHV3 70:73:73:77:6f:72:64:00
    ```

    Code correct.

6. Now you can load the data from the DER encoded file into the EF on the card:

    ```bash
    OpenSC > put 4301 mycert.der
    ```

    If you get no errors, then you're done.

Remarks:

* This isn't the preferred way for everyday users to replace the certificates. Maybe this isn't even for the user's mailing list, but I couldn't find any description how to solve this dangerous yet very urging problem.
* This may not work on some cards.
* Since the key isn't changed, after replacing the old certificate you
_won't_ need to replace your .eid/authorized_certificates, or .ssh/authorized_keys files.

* I had to delete the contents of the .eid/cache/ directory for Mozilla to see the new certificate correctly.

Thanks to  Attila Nagy for this information.
