# Smart Card Simulation

This guide uses [jCardSim](https://jcardsim.org/) to simulate the following Open Source Java Card Applets:

- [IsoApplet](https://github.com/philipWendland/IsoApplet)
- [OpenPGP applet](https://github.com/Yubico/ykneo-openpgp)
- [PivApplet](https://github.com/arekinath/PivApplet)
- [GidsApplet](https://github.com/vletoux/GidsApplet)

The description can easily be adapted for other applets as well.

## Simulation on Windows

This section describes how to get the official version of [jCardSim to work through a PC/SC virtual reader](https://jcardsim.org/blogs/work-jcardsim-through-pcsc-virtual-reader) on Windows.

### Prepare the Virtual Smart Card Reader

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



### Simulating IsoApplet

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



### Simulating OpenPGP

6. Download and build OpenPGP applet:

```
git clone https://github.com/Yubico/ykneo-openpgp
javac -classpath jcardsim-3.0.4-SNAPSHOT.jar ykneo-openpgp\applet\src\openpgpcard\*.java
```

7. Create `jcardsim_openpgp.cfg` for OpenPGP applet:

```
com.licel.jcardsim.card.applet.0.AID=D2760001240102000000000000010000
com.licel.jcardsim.card.applet.0.Class=openpgpcard.OpenPGPApplet
com.licel.jcardsim.card.ATR=3B80800101
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



### Simulating PIV

6. Download and build PivApplet:

```
git clone https://github.com/arekinath/PivApplet
javac -classpath jcardsim-3.0.4-SNAPSHOT.jar PivApplet\src\net\cooperi\pivapplet\*.java
```

7. Create `jcardsim_piv.cfg` for OpenPGP applet:

```
com.licel.jcardsim.card.applet.0.AID=A000000308000010000100
com.licel.jcardsim.card.applet.0.Class=net.cooperi.pivapplet.PivApplet
com.licel.jcardsim.card.ATR=3B80800101
```

8. Run jCardSim with PivApplet:

```
javac -classpath jcardsim-3.0.4-SNAPSHOT.jar;PivApplet\src com.licel.jcardsim.remote.BixVReaderCard jcardsim_piv.cfg
```

9. Create PIV applet from the install package:

```
opensc-tool --card-driver default --send-apdu 80b80000120ba000000308000010000100050000020F0F7f
```

10. [Initialize the PivApplet as usual](https://github.com/arekinath/PivApplet#installing)



### Simulating GIDS

6. Download and build GidsApplet:

```
git clone https://github.com/vletoux/GidsApplet
javac -classpath jcardsim-3.0.4-SNAPSHOT.jar GidsApplet\src\com\mysmartlogon\gidsApplet\*.java
```

7. Create `jcardsim_gids.cfg` for GIDS applet:

```
com.licel.jcardsim.card.applet.0.AID=A000000397425446590201
com.licel.jcardsim.card.applet.0.Class=com.mysmartlogon.gidsApplet.GidsApplet
com.licel.jcardsim.card.ATR=3B80800101
```

8. Run jCardSim with GidsApplet:

```
javac -classpath jcardsim-3.0.4-SNAPSHOT.jar;GidsApplet\src com.licel.jcardsim.remote.BixVReaderCard jcardsim_gids.cfg
```

9. Create GIDS applet from the install package:

```
opensc-tool --card-driver default --send-apdu 80b80000190bA0000003974254465902010bA00000039742544659020100
```

10. [Initialize the GidsApplet as usual](https://www.mysmartlogon.com/generic-identity-device-specification-gids-smart-card/)



## Simulation on Linux

On Linux, jCardSim needs to be compiled with support for a different [virtual reader backend (vpcd)](http://frankmorgner.github.io/vsmartcard/virtualsmartcard/README.html)

### Prepare the Virtual Smart Card Reader

1. Download and build the virtual smart card and its reader driver

```
git clone https://github.com/frankmorgner/vsmartcard.git
cd vsmartcard/virtualsmartcard
autoreconf -vis && ./configure && sudo make install
```

2. Restart `pcscd` to load the new reader driver. On Debian based systems, you could do the following:

```
sudo /etc/init.d/pcscd restart;
```

### Compile jCardSim with support for vpcd

3. Download the adapted version of jCardSim

```
git clone https://github.com/arekinath/jcardsim.git
```

4. Fetch Java Card Classic Development Kit

```
git clone https://github.com/martinpaljak/oracle_javacard_sdks.git
export JC_CLASSIC_HOME=$PWD/oracle_javacard_sdks/jc304_kit
```

5. Build `jcardsim-3.0.4-SNAPSHOT.jar` as described [here](https://jcardsim.org/docs/getting-source-compiling):

```
git clone https://github.com/martinpaljak/oracle_javacard_sdks.git
export JC_CLASSIC_HOME=$PWD/oracle_javacard_sdks/jc304_kit
git clone https://github.com/arekinath/jcardsim.git
cd jcardsim
mvn initialize && mvn clean install
```



### Simulate Java Card Applet

For actually simulating the Applets, the steps are almost identical as described in the sections for Windows above ([IsoApplet](#simulating-isoapplet), [OpenPGP](#simulating-openpgp), [PIV](#simulating-piv), [GIDS](#simulating-gids)) with the following modifications:

- Make sure to use to use `jcardsim-3.0.4-SNAPSHOT.jar` built for vpcd
- Add the following lines to your jCardSim configuration file (`jcardsim_*.cfg`):

```
com.licel.jcardsim.vsmartcard.host=localhost
com.licel.jcardsim.vsmartcard.port=35963
```
