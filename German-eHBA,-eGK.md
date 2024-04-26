# German eHBA, eGK

![GermanEGK](./attachments/wiki/GermanEGK/HPC-Image.gif)

The eHBA ([elektronischer Heilberufeausweis](https://www.bundesaerztekammer.de/themen/aerzte/digitalisierung/elektronischer-heilberufsausweis-ehba)) smartcards, are meant for german physicians and apothecaries. And all german citizens that are a member of a public health insurance company (gesetzliche Krankenkasse) will get a similar card, the so called eGK ([elektronische Gesundheitskarte](https://www.bundesgesundheitsministerium.de/themen/digitalisierung/elektronische-gesundheitskarte)).

We got eHBA and eGK test cards in 2008 and they were [STARCOS 3.0](STARCOS-cards) based. So in order to support these kind of eHBA OpenSC needs a [STARCOS 3.0](STARCOS-cards) driver.

OpenSC provides `egk-tool` for reading the data from German Health Care Card.

Information about the german eHBA / eGK:

* [Specifications and other related documents for the eHBA](https://fachportal.gematik.de/karten-und-identitaeten/elektronischer-heilberufsausweis)
* [Information about the "elektronische Gesundheitskarte Schleswig-Holstein](https://www.aeksh.de/elektronische-gesundheitskarte-egk-anwendungen)
* [Common Criteria Protection Profile](https://www.commoncriteriaportal.org/files/ppfiles/PP0020_V3b_pdf.pdf)
* [Electronic Health Professional Card (eHPC) (d-trust)](https://www.d-trust.net/en/solutions/ehpc)
