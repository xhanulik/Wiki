# Using pinpad readers with CT-API

On Win32 a pinpad reader usually supplies a PC/SC driver and a CT-API driver. You can try the somewhat less user friendly CT-API if you want to use your pinpad with OpenSC.

## Configuring CT-API in `opensc.conf`

To activate the CT-API driver you have to add the token `ctapi` to the `reader_drivers` attribute of the app default section (or whatever app you are using).
Then the reader's parameters, that is the library and port number, have to be configured in the `reader_driver ctapi` section.

Use this as an example:

```text
  app default {
    reader_drivers = ctapi;
    reader_driver ctapi {
      module c:\winnt\system32\CTRSCT32.DLL {
        ports = 1;
      }
    }

  # All the other OpenSC-Parameters...
  .
  .
  .
  }
```

## Notes

* For some readers you can look up the module name in [pinpad reader overview](Pinpad-Readers).
* Some drivers use port number 0 for the first reader, others start counting with 1.
* You can use multiple readers. Just add more "module"-sections if they use other drivers or add port numbers with a comma for the same driver.

After this you can try "opensc-tool -l" and hope to see something like

```powershell
C:\work\opensc\src\tools>opensc-tool -l
Readers known about:
Nr.    Driver     Name
0      ctapi      CT-API c:\winnt\system32\CTRSCT32.DLL, port 1
```

If you are using a pinpad aware application you are ready. Some other applications (like the PKCS#11 plugin for Mozilla or the OpensslEngines) will use the pinpad if you hit return after being asked for a PIN.

Note that up to date PIN modification or unblocking is not supported with CT-API driver, there still is some work to do.
