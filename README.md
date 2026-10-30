# Azure Hub-Spoke hálózati architektúra Terraformmal

Ez a repó egy professzionális szintű, moduláris Terraform-konfigurációt tartalmaz, amely egy biztonságos **Hub-Spoke hálózati topológiát** telepít a Microsoft Azure-ban.

## 🏗️ Architektúra áttekintése

Az architektúra egy klasszikus, vállalati szintű hálózati mintát valósít meg:
* **Hub VNet:** Központi csatlakozási csomópont a megosztott szolgáltatások és a biztonság kezeléséhez.
* **Spoke VNet-ek:** Izolált munkafolyamat-hálózatok, amelyek közvetlenül kapcsolódnak a Hubhoz (VNet Peering).
* **Hálózati biztonsági csoportok (NSG-k):** Részletes forgalomszűrés az alhálózatok között.

## 📂 Projektstruktúra

```text
├── .gitignore          # Kizárja az érzékeny fájlokat és a helyi cache-t
├── main.tf             # Alapvető infrastruktúra-erőforrások (VNet-ek, alhálózatok, peering)
├── variables.tf        # Bemeneti változók konfigurációja
├── outputs.tf          # Exportált erőforrás-attribútumok és azonosítók
├── providers.tf        # AzureRM provider konfiguráció
├── terraform.tfvars    # Környezetfüggő változóértékek
└── terraform.lock.hcl  # Provider függőségi zárak
