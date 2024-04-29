# IAS/ECC card from Gemalto

> Gemalto becomes [Thales](https://www.thalesgroup.com/en/canada/press-release/thales-completes-acquisition-gemalto-become-global-leader-digital-security).

The latest specification for the card, [IAS/ECC v1.0.1](https://dvv.fi/documents/16079645/17324992/IAS+ECC+v1_0_1UK.pdf), restricts the use of SDOs. The specification does not mention the option to create a new SDO.

The card strictly follows the specification and comes with two on-card applications: *generic PKI* and *eID*.
The xDF files of the PKCS#15 file system cannot be re-created and the size of these files cannot be changed.

The card comes with a certain number of pre-allocated key slots and it is not possible to create a new key slots.
The essential key slot attributes, such as ACLs, size, and required algorithm, cannot be changed after creation.
