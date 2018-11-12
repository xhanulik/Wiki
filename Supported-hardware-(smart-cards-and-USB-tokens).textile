h1. Supported hardware (smart cards and USB tokens)

NB! Unless noted otherwise, OpenSC works only with <b>contact interface! </b>

 * OpenSC targets only smart cards, so to know if your reader device is support, check the list of [[CardReaders|Smart-card-readers-(Linux-and-Mac-OS-X)]].
  * Proprietary USB tokens will require a (possibly proprietary) USB level driver: PC/SC (preferred) or OpenCT (deprecated)

h2. National ID Cards

These are usually pre-initialized read-only cards.
Supported eID cards:
 * [[<b>IAS-ECC</b>|IAS-ECC]]
 * [[<b>UnitedStatesPIV</b>|US-PIV]]
 * [[<b>GermanEid</b>|German-ID-Cards]]
 * [[<b>ItalianCNS</b>|Italian-CNS-and-CIE]]
 * [[<b>ItalianEid</b>|Italian-Infocamere]]
 * [[<b>EstonianEid</b>|Estonian-eID-(EstEID)]]
 * [[<b>PortugueseEid</b>|Portuguese-eID]]
 * [[<b>US CAC</b>|US-CAC]]


h2. Generic smart cards

Each entry on this list possibly represents a whole family of cards. See each page to find out which models are supported.
Personalizable cards:
 * [[<b>OpenPGP Card</b>|OpenPGP-card]]
 * [[<b>MyEID</b>|Aventra-MyEID-PKI-card]]
 * [[<b>WestCOS</b>|WestCOS]]
 * [[<b>SetCOS</b>|Setcos-driver]]
 * [[<b>Oberthur</b>|Oberthur-AuthentIC-applet-v2.2]]
 * [[<b>Cyberflex</b>|Schlumberger-Axalto-Cyberflex]]
 * [[<b>CardOS</b>|Siemens-CardOS-M4]]
 * [[<b>STARCOS</b>|STARCOS-cards]]
 * [[<b>ASEPCOS</b>|Athena-ASEPCOS-ASEKey]]
 * [[<b>SmartCardHsm</b>|SmartCardHSM]]
 * [[<b>Cryptoflex</b>|Schlumberger-Axalto-Cryptoflex]]
 * [[<b>FTCOSPK01C</b>|Feitian-PKI-card]]

Read-only cards:
 * [[<b>Micardo</b>|Micardo]]
 * [[<b>AKIS</b>|AKiS-cards]]
 * [[<b>TCOS</b>|TCOS-based-preformatted-cards]]
 * [[<b>MTCOS</b>|MaskTech-cards]]

JavaCard applets:
 * [[<b>MyEID</b>|Aventra-MyEID-PKI-card]]
 * [[<b>Oberthur</b>|Oberthur-AuthentIC-applet-v2.2]]
 * [[<b>MuscleApplet</b>|Muscle-applet]]
 * [[<b>SmartCardHsm</b>|SmartCardHSM]]
 * [[<b>Coolkey (RHCS)</b>|Coolkey]]

h2. USB Tokens

Each entry on this list possibly represents a whole family of tokens. See each page to find out which models are supported. These devices are also known as cryto-sticks.

 * [[<b>Aktiv Co. Rutoken ECP</b>|Aktiv-Co.-Rutoken-ECP]]
 * [[<b>Aktiv Co. Rutoken S</b>|Aktiv-Co.-Rutoken-S]]
 * [[<b>Aladdin Etoken Pro</b>|Aladdin-eToken-PRO]]
 * [[<b>Athena ASEPCOS / ASEKey</b>|Athena-ASEPCOS-ASEKey]]
 * [[<b>CardContact SmartCardHsm</b>|SmartCardHSM]]
 * [[<b>Crypto Stick</b>|OpenPGP-card]]
 * [[<b>Feitian ePass2003</b>|Feitian-ePass2003]]
 * [[<b>Feitian ePass3000</b>|Feitian-ePass3000]]
 * [[<b>Feitian PKI token</b>|Feitian-ePass-PKI-token]]
 * <b>[[Nitrokey Pro, Start, Storage|OpenPGP-card]], [[HSM|SmartCardHSM]]</b>
 * [[<b>Rainbow iKey 3000</b>|iKey-3000]]
 * [[<b>Schlumberger / Axalto e-gate</b>|Schlumberger-Axalto-Gemalto-e-gate]]


<b>Did not find your card from the supported card list?</b> See [[FrequentlyAskedQuestions|Frequently-Asked-Questions]] for next steps.

h2. Unsupported hardware

Things that we have (some) code for but which are known to be incomplete, broken or largely useless.

Unclear/unsupported eID cards:
 * [[<b>Australia</b>|Australian-national-ID-card]]
 * [[<b>FinnishEid</b>|Finnish-FINEID]]
 * [[<b>TaiwanEid</b>|Taiwan]]
 * [[<b>SwedishEid</b>|Swedish-ePosten-card]]
 * [[<b>BelgianEid</b>|Belgian-Belpic]]
 * [[<b>GermanEGK</b>|German-eHBA,-eGK]]
 * [[<b>MyKAD</b>|Malaysian-MyKAD]]
 * [[<b>SpanishEid</b>|Spanish-Ceres-DNIe]]
 * [[<b>AustrianEid</b>|Austrian-"Bürgerkarte"]]
 * [[<b>ItalianPostecert</b>|Italian-Postecert]]
 * [[<b>SwedishBankID</b>|Swedish-BankID]]

Unsupported USB tokens:
 * [[<b>RainbowIkeyFour</b>|iKey-4000]]
 * [[<b>CryptoIdentityItsec</b>|Eutron-CryptoIdentity-ITSEC-I-ITSEC-P]]


Unsupported smart cards:
 * [[<b>IbmJcop</b>|IbmJcop]]
 * [[<b>EMV</b>|EMV-(Europay,-Mastercard,-VISA)]]
 * [[<b>Seccos</b>|Seccos]]
 * [[<b>Actalis</b>|Italian-signature-card-Actalis]]
 * [[<b>ACOS5</b>|ACOS5]]
 * [[<b>GemplusGpk</b>|Gemplus-GPK-16k]]


