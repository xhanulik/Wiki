# IBM JCOP with BlueZ applet

> The driver for JCOP cards was removed due to no user or developer activity. For further use, the driver needs to be pulled from git history.

Previously supported cards: *jcop31bio* cards that include the *bluez* applet in their rom mask.

This includes the sample cards that you can sometimes (but not presently) buy from IBM.
We do not know if any of the manufacturers/resellers of non-application-specific *jcop30*
cards provide this rom (or even if any of the providers will provide cards
that are still in the `OP_READY` state).

Note that `pkcs15-init` tool cannot initialize or erase jcop cards. There are no
free tools to do that in OpenSC.
