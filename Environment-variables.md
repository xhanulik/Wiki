# Environment variables

You can set different environment variables to change the behavior of OpenSC:

* `HOME`
  * The cache directory is set to `$HOME/.cache/opensc` on Unix.
* `OPENSC_CONF`
  * Specify an alternative `opensc.conf` file.
* `OPENSC_DEBUG`
  * See [Using OpenSC](Using-OpenSC).
* `OPENSC_DRIVER`
  * Specify an driver, that will be used (the same behavior as `force_card_driver` configuration option in `opensc.conf`).
* `PIV_EXT_AUTH_KEY`
  * External authentication key used by PIV cards during initialization.
  * The environment variable must point to either a binary file matching the length of the key or a text file containing the key in the format `XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX`
* `PKCS11SPY`
  * See [Using OpenSC](Using-OpenSC).
* `PKCS11SPY_OUTPUT`
  * See [Using OpenSC](Using-OpenSC).
* `POSIXLY_CORRECT`
* `TERM`
  * Is used to know if the terminal supports color or not. Supported color terminals are: "linux", "xterm", "Eterm", "rxvt", "rxvt-unicode"
* `USERPROFILE`
  * The cache directory is set to `$USERPROFILE/eid-cache`/ on Windows.
