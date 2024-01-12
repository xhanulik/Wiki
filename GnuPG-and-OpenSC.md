# Use seperated applications on token for GnuPG and OpenSC
 
Some Tokens like the Yubikey have support for multiple security applications and you may want to use all of them concurrently for different purposes.

OpenSC, by default, is configured to allow shared access by default. In particular, for `reader_driver pcsc` `connect_exclusive` is set to `false` and `disconnect_action`/`transaction_end_action`/`reconnect_action` are set to `leave`. Additionally, you may want to restrict OpenSC to only use one particular application:
```
	card_atr 3b:8c:80:01:59:75:62:69:6b:65:79:4e:45:4f:72:33:58 {
		atrmask = "FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:00:00";
		name = "Yubikey Neo";
		# Select the PKI applet to use ("PIV-II" or "openpgp")
		driver = "PIV-II";
		# Recover from other applications accessing a different applet
		flags = "keep_alive";
	}
```
In this case, only the PIV-II application is used for the Yubikey Neo and OpenSC explicitly checks for concurrent access to the token.

GnuPG on the other hand, supports shared access starting from version 2.2.28 LTS and 2.3.0, but you need to enable shared PC/SC access by modifying your `scdaemon.conf` file and adding the following lines:
```
pcsc-driver /usr/lib/libpcsclite.so
card-timeout 5
disable-ccid
pcsc-shared
```

More troubleshooting with GnuPG is available on [Yubico's Website](https://support.yubico.com/hc/en-us/articles/360013714479-Troubleshooting-Issues-with-GPG)

Alternatively, it is possible to avoid scdaemon and access the token exclusively via OpenSC (see next section).

# Use one single application on token (GnuPG via OpenSC)

If your token doesn't support OpenPGP or you don't want to use multiple applications on your token (with different PINs), then you can configure GnuPG to use OpenSC for accessing the token.

Install [gnupg-pkcs11-scd](https://github.com/alonbl/gnupg-pkcs11-scd) and configure it for use of OpenSC by modifying `gnupg-pkcs11-scd.conf` with the following:
```
providers opensc
provider-opensc-library /usr/lib64/opensc-pkcs11.so
```

Now tell GnuPG to use `gnupg-pkcs11-scd` instead of its own implementation (`scdaemon`) by adding the following line to `gpg-agent.conf`:
```
scdaemon-program /usr/bin/gnupg-pkcs11-scd
```
Reload the gpg-agent by running the following in a terminal:
```
gpg-agent --server gpg-connect-agent << EOF
RELOADAGENT
SCD LEARN
EOF
```

Now, `gpg --card-status` should show your token being accessed by OpenSC. The card application is not necessarily OpenPGP, but rather the type of application that is configured in OpenSC.