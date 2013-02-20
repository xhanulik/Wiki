# Quick Start

Please first install the PKCS#11 Module you want to use such as OpenSC, and install libp11 (runtime and development). 

## Installing engine_pkcs11 is quite simple:

<pre><code>wget http://www.opensc-project.org/files/engine_pkcs11-x.y.z.tar.gz
tar xfvz engine_pkcs11-x.y.z.tar.gz
cd engine_pkcs11-x.y.z
./configure --prefix=/usr/
make
make install
</code></pre>

## Using Engine_pkcs11 with the openssl command
You can run the OpenSSL command shell and load the engine and then run any command using the engine. Here is an example: 

<pre><code>$ openssl
OpenSSL> engine -t dynamic -pre SO_PATH:/usr/lib/engines/engine_pkcs11.so \
         -pre ID:pkcs11 -pre LIST_ADD:1 -pre LOAD \
         -pre MODULE_PATH:/usr/lib/opensc-pkcs11.so
OpenSSL> req -engine pkcs11 -new -key id_45 -keyform engine -out req.pem -text -x509 \
         -subj "/CN=Andreas Jellinghaus"
OpenSSL> x509 -engine pkcs11 -signkey slot_0-id_45 -keyform engine -in req.pem -out cert.pem
</code></pre>

In this example the engine_pkcs11 is loaded using the PKCS#11 module opensc-pkcs11.so. The second command creates a self signed Certificate for "Andreas Jellinghaus", the signing is done using the key with id 45 from your smart card in slot 0. The third command creates a self-signed certificate for the request, the private key used to sign the certificate is the same private key used to create the request. 
Using Engine_pkcs11 with the openssl config file

You can also create/edit an openssl config file, so you don't need to type in or paste the above commands all the time. Here is an example for OpenSSL 0.9.8:

<pre><code>openssl_conf            = openssl_def

[openssl_def]
engines = engine_section

[engine_section]
pkcs11 = pkcs11_section

[pkcs11_section]
engine_id = pkcs11
dynamic_path = /usr/lib/engines/engine_pkcs11.so
MODULE_PATH = /usr/lib/opensc-pkcs11.so
init = 0

[req]
distinguished_name = req_distinguished_name

[req_distinguished_name]
</code></pre>

With such a config file you can directly call openssl to use that engine:

<pre><code>openssl req -config openssl.conf -engine pkcs11 -new -key id_45 \
        -keyform engine -out req.pem -text -x509 \
        -subj "/CN=Andreas Jellinghaus"
</code></pre>

## Engine PKCS#11 Options

### Options you can use with engine_pkcs11:
* **SO_PATH**: Specifies the path to the 'pkcs11-engine' shared library 
* **MODULE_PATH**: Specifies the path to the pkcs11 module shared library 
* **PIN**: Specifies the pin code 
* **VERBOSE**: Print additional details 
* **QUIET**: Remove additional details 
* **LOAD_CERT_CTRL**: Get the certificate from card 

**PIN** can be passed only in the [pkcs11_section] of the openssl.conf (see above).

**FIXME**: copied these options from the source code, untested

# OpenSSL autoloading
 OpenSSL 0.9.8+ can automaticaly load engines. If you want to enable that feature, add a symlink from engine_pkcs11.so to libfoo.so in the lib/engines/ directory where engine_pkcs11.so is installed. 

 We think that a config file is a much better approach, since you need to pass the PKCS#11 module to use to engine_pkcs11.so, and you can do that only via command line or via the config file.