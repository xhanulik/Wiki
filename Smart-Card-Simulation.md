# Smart Card Simulation

This guide uses [jCardSim](https://jcardsim.org/) to simulate the following Open Source Java Card Applets:

- [IsoApplet](https://github.com/philipWendland/IsoApplet)
- [OpenPGP applet](https://github.com/Yubico/ykneo-openpgp)
- [PivApplet](https://github.com/arekinath/PivApplet)

The description can easily be adapted for other applets as well. We focus on Windows since this is the only platform with a virtual smart card reader supported by jCardSim.

## Prepare the Virtual Smart Card Reader

1. Install virtual smart card reader: Either use the [original source code](http://www.codeproject.com/Articles/134010/An-UMDF-Driver-for-a-Virtual-Smart-Card-Reader) and follow its manual or use the pre-built installer, [BixVReaderInstaller.msi](https://github.com/frankmorgner/vsmartcard/releases/tag/virtualsmartcard-0.7), from the [Virtual Smart Card](https://frankmorgner.github.io/vsmartcard/virtualsmartcard/README.html) project.

2. Enable the Pipe Reader: Change `C:\Windows\BixVReader.ini` to something like this

```
[Driver]
NumReaders=1

[Reader0]
RPC_TYPE=0
VENDOR_NAME=Fabio Ottavi
VENDOR_IFD_TYPE=Pipe Reader
DECIVE_UNIT=0
```

3. Reload the configuration: In the *Device Manager*, deactivate and activate the *Bix Virtual Smart Card Reader* to load the modification of `BixVReader.ini`. Alternatively, you can use `devcon.exe` from the Windows Driver Kit:

```
devcon.exe disable root\BixVirtualReader
devcon.exe enable  root\BixVirtualReader
```

4. Download and Install Java (`java.exe` and `javac.exe` are required)
5. Download [jCardSim](https://github.com/licel/jcardsim/raw/master/jcardsim-3.0.4-SNAPSHOT.jar)

Now, [configure jCardSim](https://jcardsim.org/blogs/work-jcardsim-through-pcsc-virtual-reader) to load and run the applet to make it available via PC/SC (see sections below).



## Simulating IsoApplet

6. Download and build IsoApplet:

```
git clone https://github.com/philipWendland/IsoApplet
javac -classpath jcardsim-3.0.4-SNAPSHOT.jar IsoApplet\src\net\pwendland\javacard\pki\isoapplet\*.java
```

7. Create `jcardsim_isoapplet.cfg` for IsoApplet:

```
com.licel.jcardsim.card.applet.0.AID=F276A288BCFBA69D34F31001
com.licel.jcardsim.card.applet.0.Class=net.pwendland.javacard.pki.isoapplet.IsoApplet
com.licel.jcardsim.card.ATR=3B80800101
```

8. Run jCardSim with IsoApplet package:

```
javac -classpath jcardsim-3.0.4-SNAPSHOT.jar;IsoApplet\src com.licel.jcardsim.remote.BixVReaderCard jcardsim_isoapplet.cfg
```

9. Create IsoApplet from the install package:

```
opensc-tool --card-driver default --send-apdu 80b800001a0cf276a288bcfba69d34f310010cf276a288bcfba69d34f3100100
```

10. [Initialize the IsoApplet as usual](https://github.com/philipWendland/IsoApplet/wiki/Initialization)



## Simulating OpenPGP

6. Download and build OpenPGP applet:

```
git clone https://github.com/Yubico/ykneo-openpgp
javac -classpath jcardsim-3.0.4-SNAPSHOT.jar ykneo-openpgp\applet\src\openpgpcard\*.java
```

7. Create `jcardsim_openpgp.cfg` for OpenPGP applet:

```
com.licel.jcardsim.card.applet.0.AID=D2760001240102000000000000010000
com.licel.jcardsim.card.applet.0.Class=openpgpcard.OpenPGPApplet
com.licel.jcardsim.card.ATR=3BFC1300008131FE15597562696B65794E454F7233E1
```

8. Run jCardSim with OpenPGP:

```
javac -classpath jcardsim-3.0.4-SNAPSHOT.jar;ykneo-openpgp\applet\src com.licel.jcardsim.remote.BixVReaderCard jcardsim_openpgp.cfg
```

9. Create OpenPGP applet from the install package:

```
opensc-tool --card-driver default --send-apdu 80b800002210D276000124010200000000000001000010D276000124010200000000000001000000
```

10. [Initialize the OpenPGP applet as usual](https://github.com/OpenSC/OpenSC/wiki/OpenPGP-card#usage)



## Simulating PIV

6. Download and build PivApplet:

```
git clone https://github.com/arekinath/PivApplet
javac -classpath jcardsim-3.0.4-SNAPSHOT.jar PivApplet\src\net\cooperi\pivapplet\*.java
```

7. Create `jcardsim_pvi.cfg` for OpenPGP applet:

```
com.licel.jcardsim.card.applet.0.AID=A000000308000010000100
com.licel.jcardsim.card.applet.0.Class=net.cooperi.pivapplet.PivApplet
com.licel.jcardsim.card.ATR=3B80800101
```

8. Run jCardSim with PivApplet:

```
javac -classpath jcardsim-3.0.4-SNAPSHOT.jar;PivApplet\src com.licel.jcardsim.remote.BixVReaderCard jcardsim_pvi.cfg
```

9. Create PIV applet from the install package:

```
opensc-tool --card-driver default --send-apdu 80B80000180BA0000003080000100001000BA00000030800001000010000
```

10. [Initialize the PivApplet as usual](https://github.com/arekinath/PivApplet#installing)