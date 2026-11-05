# Enduro Fleet (iOS, SwiftUI) - Lab 2: CRUD, UI only

Aplicație nativă iOS (Swift + SwiftUI, iOS 16+) pentru flota de motociclete enduro.
Datele sunt false, ținute **doar în memorie** (fără bază de date, fără server).

Entitatea **Motorcycle**: model, VIN, ore motor, ore de la ultimul schimb de ulei,
ore de la ultimul schimb de piston, probleme.

## Rulare (necesită un Mac cu Xcode 15+)

1. `git clone` acest repo (repo-ul personal de GitHub).
2. Deschide `EnduroFleet.xcodeproj` în Xcode. Proiectul este gata făcut, nu mai trebuie creat manual.
3. Alege un simulator iPhone (ex. iPhone 16 Pro) și apasă ⌘R.

Opțional: pe Mac, `xcodegen` regenerează proiectul din `project.yml`.
La fiecare push, GitHub Actions (`.github/workflows/ios-build.yml`) compilează aplicația pe un Mac,
iar rezultatul se vede în tab-ul **Actions** al repo-ului.

## Structura

| Fișier | Rol |
|---|---|
| `EnduroFleet/EnduroFleetApp.swift` | Punctul de intrare; creează store-ul și îl dă ecranelor |
| `EnduroFleet/Models/Motorcycle.swift` | Entitatea |
| `EnduroFleet/Models/MotorcycleForm.swift` | Starea formularului + validări |
| `EnduroFleet/Store/MotorcycleStore.swift` | Date false în memorie + add / update / delete |
| `EnduroFleet/Views/MotorcycleListView.swift` | **Read** (lista) + **Delete** (swipe + confirmare) |
| `EnduroFleet/Views/AddMotorcycleView.swift` | **Create**: ecran separat |
| `EnduroFleet/Views/EditMotorcycleView.swift` | **Update**: ecran separat, câmpuri precompletate |
| `EnduroFleet/Views/MotorcycleFormFields.swift` | Câmpurile refolosite de Add și Edit |
