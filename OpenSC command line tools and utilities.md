OpenSC command line tools and utilities
=======================================

The following executables are included with OpenSC:

 * Generic
   * `opensc-explorer`
   * `opensc-tool`
 * PKCS#15 layer
   * `pkcs15-tool`
   * `pkcs15-crypt`
   * `pkcs15-init`
 * Card driver utility
   * `cryptoflex-tool`  
   * `netkey-tool`
     * does not use `util.c` to connect to card
     * manpage needs updates
   * `piv-tool`
     * duplicates functionality from pkcs15-init (`-G`, but is it special case?) and `opensc-tool` (`--send-apdu`)
     * has no manpage
   * `westcos-tool`
     * duplicates functionality from pkcs15-init (`-G`/`-i`/`-cert`) and `pkcs15-tool` (`-n`/`-u`)
     * has no long options
   * `rutoken-tool`
     * GOST specific re-implementations of similar functionality from `pkcs15-init` (`--genkey`) and `pkcs15-crypt` (`--encrypt`, `--decrypt`). Understandable, but it would not hurt to have a tool that could work with GOST and whatever there might be in the future (Korean?)
     * has no manpage
   * `cardos-tool`
     * all are uniq operations: `--info` `--format` `--startkey` `--change-startkey`
     * has outdated manpage
  * PKCS#11 utility
    * `pkcs11-tool`
      * can be extracted from OpenSC
      * manpage needs updates
  * Misc utilities
    * `eidenv`
      * has no manpage

Tasks
-----

 * Functionality doable via common interfaces ("libopensc abstraction" which currently means PKCS#15) must not be replicated
 * Uniform look and feel for commands, utility functions that are supposed to be used, must be used.
   * PIN entry via command line/stdin/env/pinpad and cancellation must behave the same way with all tools

