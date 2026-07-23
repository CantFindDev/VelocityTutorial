# Minecraft Velocity Server Setup Guide

Welcome to the official setup guide and project repository for the Minecraft Velocity Proxy network tutorial. This guide explains how to establish a central hub system, link multiple Paper backend servers (e.g., Lobby, Games), and switch between them seamlessly using a single in-game command.

This setup utilizes smart automated `.bat` scripts to streamline your server deployment and startup sequence.

---

## 📋 Table of Contents
1. [📌 Important Links & Resources](#-important-links--resources)
2. [🛠️ The Automated Script System](#️-the-automated-script-system)
3. [🚀 Step-by-Step Configuration](#-step-by-step-configuration)
   * [1. Download Required Files](#1-download-required-files)
   * [2. Folder Preparation](#2-folder-preparation)
   * [3. Velocity Proxy Setup](#3-velocity-proxy-setup)
   * [4. Backend Server Setup](#4-backend-server-setup-lobby--games)
   * [5. Launch the Network](#5-launch-the-network)
4. [💡 Tips & Tricks](#-tips--tricks)

---

## 📌 Important Links & Resources

* **Video Tutorial:** [Watch on YouTube](https://youtu.be/0aeMCBQk0Yw)
* **Project Files:** [GitHub Repository](https://github.com/CantFindDev/VelocityTutorial)
* **Automated Scripts (.bat):** [Gist Download](https://gist.github.com/CantFindDev/16a66e31a8909822839ed2938263d505)
* **Java 21 Download:** [Adoptium (Recommended)](https://adoptium.net/) | [Oracle (Official)](https://www.oracle.com/java/technologies/downloads/#java21)
* **Paper & Velocity Downloads:** [Official PaperMC Website](https://papermc.io/downloads)
* **Community Support:** [Join our Discord](https://discord.gg/d9puKpHWjn)

---

## 🛠️ The Automated Script System

Managing a proxy network traditionally involves managing multiple console windows manually. The provided `.bat` scripts are designed to automate this process.

* **Auto-Jar Detection:** The `StartServer.bat` script automatically identifies and launches the `.jar` file within its directory. You do not need to rename your server files to `server.jar`.
* **Sequential Boot Order:** The `StartAllServers.bat` script ensures that backend servers (Paper) are launched and initialized before the proxy (Velocity) starts, preventing connection timeouts.
* **Dynamic Console Titles:** Each console window automatically adopts the name of its parent folder (e.g., "Lobby Server"), making server management significantly easier.

---

## 🚀 Step-by-Step Configuration

### 1. Download Required Files

> [!IMPORTANT]
> **Java Requirement:** Modern Minecraft servers require Java 21. You can download the community-recommended open-source version from [Adoptium](https://adoptium.net/), or the official proprietary version from [Oracle](https://www.oracle.com/java/technologies/downloads/#java21). Ensure it is set as your default Java version in your system PATH during installation.

1. **Download Velocity:** Get the latest Velocity `.jar` from the [PaperMC Downloads Page](https://papermc.io/downloads/velocity).
2. **Download Paper:** Get the latest Paper `.jar` from the [PaperMC Downloads Page](https://papermc.io/downloads/paper).

### 2. Folder Preparation
1. Create a root directory for your network (e.g., `VelocityNetwork`).
2. Inside the root directory, create three separate subfolders: `Velocity`, `Lobby`, and `Games`.
3. Place the Velocity `.jar` into the `Velocity` folder.
4. Place the Paper `.jar` into both the `Lobby` and `Games` folders.
5. Place the `StartServer.bat` script inside all three subfolders.
6. Place the `StartAllServers.bat` script in the main root directory.

Your folder structure should look like this:
```text
VelocityNetwork/
├── StartAllServers.bat
├── Velocity/
│   ├── StartServer.bat
│   └── velocity-x.x.x.jar
├── Lobby/
│   ├── StartServer.bat
│   └── paper-x.x.x.jar
└── Games/
    ├── StartServer.bat
    └── paper-x.x.x.jar
```

### 3. Velocity Proxy Setup
1. Run `StartServer.bat` inside the `Velocity` folder to generate the configuration files, then close the console.
2. Open `velocity.toml` and configure the following:
   * Set `player-info-forwarding-mode = "modern"`
   * Under the `[servers]` section, configure your network ports:
     ```toml
     lobby = "127.0.0.1:25565"
     games = "127.0.0.1:25566"
     ```
3. Open `forwarding.secret` in the Velocity folder and copy its contents. You will need this for the backend servers.

### 4. Backend Server Setup (Lobby & Games)
1. Run `StartServer.bat` in both the `Lobby` and `Games` folders. They will pause, asking you to accept the EULA.
2. Open `eula.txt` in both folders and change `eula=false` to `eula=true`.
3. Run both servers again to generate their respective configuration files, then stop them.

**Applying the Configuration:**
For both servers, make the following changes:
1. Open `server.properties` and set `online-mode=false`.
2. Open `config/paper-global.yml`, locate the `proxies` -> `velocity` section:
   * Set `enabled: true`.
   * Paste the secret you copied earlier into the `secret: "your-secret-here"` field.

> [!WARNING]
> **Port Allocation:** Velocity routes network traffic via ports. Ensure your servers do not conflict. Leave `server-port=25565` in the Lobby's `server.properties`, but change the Games folder's `server.properties` to `server-port=25566`.

### 5. Launch the Network
1. Navigate back to your root directory and execute `StartAllServers.bat`.
2. The system will sequentially boot your entire network.
3. Launch Minecraft, add a new multiplayer server with the IP address `localhost:25577` (Velocity's default port).
4. Connect to the network and use the `/server games` or `/server lobby` commands to navigate between your servers.

---

## 💡 Tips & Tricks

> [!TIP]
> **RAM Allocation:** If you want to change the amount of RAM allocated to the servers, right-click the `StartServer.bat` file, select *Edit*, and adjust the `-Xmx1512M` (1.5 GB) value according to your system's needs (e.g., `-Xmx4G` for 4 GB).

> [!CAUTION]
> **Safe Shutdown:** Always shut down your servers safely to prevent world corruption. Instead of clicking the 'X' on the console windows, type `stop` in the backend servers (Lobby/Games) and `end` in the Velocity console.

> [!NOTE]
> **Plugin Compatibility:** Velocity and Paper use different plugin architectures. If you are installing a network-wide plugin like LuckPerms, make sure to download the specific Velocity version for your proxy, and the Paper/Spigot version for your backend servers.

> [!WARNING]
> **Network Security:** If you open your server to the public, ensure you block external firewall access to your backend server ports (25565 and 25566). Players should only be able to connect through the Velocity proxy port (25577) to prevent unauthorized direct access.