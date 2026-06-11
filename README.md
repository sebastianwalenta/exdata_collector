# EX-Boat Data Collector

<p align="center">
  <img src="gpres/logo.png" alt="EX-Boat DC Logo" width="200">
</p>

[![Google Play](https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png)](YOUR_LINK_HERE)

---

## 🇨🇿 Čeština

### O aplikaci
Aplikace pro ukládání a sdílení výsledků modelů lodí kategorií EX-500 a EX-A. Architektura využívá Repository pattern, kde jsou data primárně uložena v zařízení a synchronizována mezi uživateli pomocí centrálního serveru.

### Návod k použití
1.  **Přidání lodě**: Klikněte na ikonu lodi v hlavním menu. Vyplňte jméno a třídu lodi.
2.  **Přidání závodu**: Klikněte na ikonu kalendáře. Zadejte název závodu a datum.
3.  **Záznam jízdy**: Na hlavní obrazovce klikněte na loď. Vyberte závod a zadejte parametry jízdy (zásahy, směr, čas).
4.  **Synchronizace**: Pro nahrání dat na server nebo stažení dat od ostatních klikněte na ikonu synchronizace na hlavní obrazovce.
5.  **Nastavení**: V menu pod třemi tečkami najdete Nastavení, kde lze změnit URL backendu, jazyk aplikace nebo barevné téma.

### Nastavení Backend Serveru
Backend je postaven na Pythonu s využitím frameworku Flask.

**Požadavky:**
- Python 3.x
- Flask, Flask-SQLAlchemy

**Instalace:**
1. Přejděte do adresáře `ServerSide/`.
2. Nainstalujte potřebné balíčky:
   ```bash
   python3 -m pip install flask flask-sqlalchemy --break-system-packages
   ```

**Spuštění:**
1. Upravte konfiguraci v `config.py` nebo vytvořte `config_local.json` pro nastavení hostitele a portu.
2. Spusťte server:
   ```bash
   python3 DataColector.py
   ```
Server bude ve výchozím nastavení naslouchat na adrese definované v konfiguraci (např. port 5051).

---

## 🇺🇸 English

### About the App
Application for saving and sharing results of ship models in categories EX-500 and EX-A. The architecture uses the Repository pattern, where data is primarily stored on the device and distributed among users via server synchronization.

### Usage Tutorial
1.  **Add a Boat**: Click the boat icon on the main screen. Fill in the name and boat class.
2.  **Add a Race**: Click the calendar icon. Enter the race name and date.
3.  **Record a Run**: On the main screen, click on a boat. Select a race and enter the run parameters (hits, direction, time).
4.  **Synchronization**: To upload data to the server or download data from others, click the sync icon on the main screen.
5.  **Settings**: In the three-dot menu, you can find Settings to change the backend URL, application language, or color theme.

### Backend Server Setup
The backend is built with Python using the Flask framework.

**Requirements:**
- Python 3.x
- Flask, Flask-SQLAlchemy

**Installation:**
1. Navigate to the `ServerSide/` directory.
2. Install the required packages:
   ```bash
   python3 -m pip install flask flask-sqlalchemy --break-system-packages
   ```

**Running:**
1. Adjust the configuration in `config.py` or create `config_local.json` to set the host and port.
2. Start the server:
   ```bash
   python3 DataColector.py
   ```
By default, the server will listen on the address defined in the configuration (e.g., port 5051).
