# OpenSC and Microsoft CNG
It is possible to use the Smartcard via OpenSc with the [Microsoft CNG](https://msdn.microsoft.com/de-de/library/windows/desktop/aa376210(v=vs.85).aspx) library.

## Example: Read the x509 Certificate from connected Smartcard
With the CNG its easy to use the smartcard like a normal pkcs12 container or something similar.

### Important functions
[NCryptOpenStorageProvider](https://msdn.microsoft.com/de-de/library/windows/desktop/aa376286(v=vs.85).aspx) //
[NCryptEnumKeys](https://msdn.microsoft.com/en-us/library/windows/desktop/aa376259(v=vs.85).aspx) //
[NCryptOpenKey](https://msdn.microsoft.com/de-de/library/windows/desktop/aa376284(v=vs.85).aspx) //
[NCryptGetProperty](https://msdn.microsoft.com/de-de/library/windows/desktop/aa376273(v=vs.85).aspx)

```
#include <Windows.h>
#include <wincrypt.h>

#include <functional>
#include <memory>
#include <vector>

template <typename T>
using raii_ptr = std::unique_ptr<T, std::function<void(T *)>>;

// Read the x509 from connected smartcard
int main() {
  NCRYPT_PROV_HANDLE provider = NULL;
  raii_ptr<NCRYPT_PROV_HANDLE> hProvider(&provider,
                                         [](NCRYPT_PROV_HANDLE *handle) {
                                           if (handle)
                                             NCryptFreeObject(*handle);
                                         });
  NCryptOpenStorageProvider(hProvider.get(), MS_SMART_CARD_KEY_STORAGE_PROVIDER,
                            0);

  NCryptKeyName *pKeyName = nullptr;
  PVOID pState = nullptr;

  auto status = NCryptEnumKeys(*hProvider, 0, &pKeyName, &pState, 0);
  if (status == NTE_NO_MORE_ITEMS)
    return 0;

  if (status != ERROR_SUCCESS && status != ERROR_SUCCESS) {
    printf("Error: NCryptEnumKeys : 0x%x\n", status);
    return 0;
  }
  printf("Ok: NCryptEnumKeys : 0x%x\n", status);

  NCRYPT_KEY_HANDLE key = NULL;
  raii_ptr<NCRYPT_KEY_HANDLE> hKey(&key, [](NCRYPT_KEY_HANDLE *handle) {
    if (handle)
      NCryptFreeObject(*handle);
  });
  status = NCryptOpenKey(*hProvider, hKey.get(), pKeyName->pszName,
                         pKeyName->dwLegacyKeySpec, 0);

  wprintf(L"Ok: NCryptOpenKey : 0x%x, Key Name: %s\n", status,
          pKeyName->pszName);
  wprintf(L"Using key : %s\n", pKeyName->pszName);

  DWORD size = 0;
  NCryptGetProperty(*hKey, NCRYPT_CERTIFICATE_PROPERTY, nullptr, 0, &size, 0);
  std::vector<BYTE> cert;
  cert.resize(size);
  NCryptGetProperty(*hKey, NCRYPT_CERTIFICATE_PROPERTY, &cert[0], size, &size,
                    0);

  DWORD nDestinationSize;
  if (CryptBinaryToString(reinterpret_cast<const BYTE *>(&cert[0]), cert.size(),
                          CRYPT_STRING_BASE64, nullptr, &nDestinationSize)) {
    LPTSTR pszDestination = static_cast<LPTSTR>(HeapAlloc(
        GetProcessHeap(), HEAP_NO_SERIALIZE, nDestinationSize * sizeof(TCHAR)));
    if (pszDestination) {
      if (CryptBinaryToString(reinterpret_cast<const BYTE *>(&cert[0]),
                              cert.size(), CRYPT_STRING_BASE64, pszDestination,
                              &nDestinationSize)) {

        printf(pszDestination);
      }
      HeapFree(GetProcessHeap(), HEAP_NO_SERIALIZE, pszDestination);
    }
  }
  return 0;
}
```

## Other cool stuff with CNG and CryptoAPI
The CNG and [CryptoAPI](https://msdn.microsoft.com/en-us/library/ms867086.aspx) are realy powerfull with these both libraries it is possible to build powerfull cryptographical libraries and applications.