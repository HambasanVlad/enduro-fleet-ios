# Cum instalezi EnduroFleet pe iPhone de pe Windows (fără Mac)

GitHub compilează aplicația pe un Mac din cloud și o publică ca `EnduroFleet.ipa` la
**Releases → latest** în acest repo. Tu doar o instalezi pe telefon cu Sideloadly.

## O singură dată (pregătire)

1. **Apple Devices** - din Microsoft Store instalează aplicația „Apple Devices” (sau iTunes),
   ca Windows să vadă iPhone-ul.
2. **Sideloadly** - descarcă și instalează de pe https://sideloadly.io (versiunea pentru Windows).
3. Conectează iPhone-ul la laptop cu cablul. Pe telefon apasă **Trust / Ai încredere** și pune codul.
4. Pe iPhone: **Settings → Privacy & Security → Developer Mode → On**.
   Telefonul se repornește; după repornire confirmă cu **Turn On**.
   (Opțiunea apare abia după ce ai conectat telefonul la Sideloadly măcar o dată; dacă nu o vezi, fă pasul 2 de mai jos și revino.)

## Instalarea

1. Descarcă `EnduroFleet.ipa` de la
   https://github.com/HambasanVlad/enduro-fleet-ios/releases/tag/latest
2. Deschide Sideloadly:
   - **iDevice**: alege iPhone-ul tău;
   - **Apple account**: scrie adresa ta de Apple ID;
   - trage `EnduroFleet.ipa` în fereastră (sau apasă iconița IPA);
   - apasă **Start** și introdu parola Apple ID (și codul 2FA, dacă îl cere).
3. Pe iPhone: **Settings → General → VPN & Device Management** → apasă pe Apple ID-ul tău → **Trust**.
4. Deschide aplicația **Enduro Fleet** de pe ecranul principal.

## De știut

- Cu un Apple ID gratuit aplicația merge **7 zile**. După aceea repeți pașii de la „Instalarea”.
- Fiecare push pe `main` produce un `.ipa` nou la Releases → latest.
- Datele sunt doar în memorie: la închiderea aplicației revin cele 5 motociclete de exemplu (așa cere lab 2).
