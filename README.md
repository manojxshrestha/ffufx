<h1 align="center">
  <br>
  <a href="https://github.com/manojxshrestha/">
    <img src="https://github.com/user-attachments/assets/168535e7-98ea-482a-9e53-cd8be2d52745" alt="ffufx" width="600">
  </a>
  <br>
  ffufx
  <br>
</h1>

<h4 align="center">An interactive, high-impact fuzzing toolkit powered by ffuf ⚡</h4>

<p align="center">
  <a href="https://github.com/ffuf/ffuf" target="_blank"><img alt="Uses ffuf" src="https://img.shields.io/badge/powered%20by-ffuf-blue"></a>
  <a href="https://github.com/manojxshrestha/ffufx/stargazers" target="_blank"><img src="https://img.shields.io/github/stars/manojxshrestha/ffufx?style=social" alt="GitHub stars"></a>
</p>

---

A fully interactive, high-performance directory, file, and parameter fuzzing toolkit built on top of [ffuf](https://github.com/ffuf/ffuf). Ideal for bug bounty hunters, pentesters, and red teamers aiming to uncover hidden resources fast and stealthily.

---

### ⚡ Features

- 🔍 Organized wordlists by fuzzing category (files, extensions, parameters, etc.)
- 🔁 Recursive directory and file fuzzing
- 🧠 Smart header spoofing to bypass WAFs and IP blocks
- 🧪 Extension-aware fuzzing with 30+ filetypes
- 💡 Simple interactive menu — no flags to memorize
- 💾 HTML report generation (offline-supported)
- 🚫 Auto-filtering of noise (403, 404, 5xx, etc.)
- 🔧 Easily extendable with your own wordlists

---

### 🛠️ Installation

```bash
git clone https://github.com/manojxshrestha/ffufx.git
cd ffufx
chmod +x fuff.sh
````

---

### 🚀 Usage

```bash
./fuff.sh
```

Follow the interactive prompts to:

1. Select a fuzzing category (files, extensions, params, etc.)
2. Choose a wordlist from the selected category
3. Enter a target URL (e.g., `http://example.com/FUZZ`)
4. Watch ffuf uncover hidden assets 🔎

---

### 🧩 Wordlist Categories

* `DirectoryAndFileDiscovery/`
* `FileExtensionsAndTypes/`
* `ParameterAndInputFuzzing/`
* `BackupAndSensitiveData/`
* `ServerSpecificResources/`
* `QuickAndHighProbabilityHits/`
* `RobotsTxtDisallowedPaths/`
* `SubdomainEnumeration/`
* `CustomAndSpecialized/`

> 🔁 You can add your own `.txt` wordlists to any folder if needed.
---

### 🧠 Pro Tips

* Start with `QuickAndHighProbabilityHits/quickhits.txt` for quick wins
* Use `BackupAndSensitiveData/` for leaked configs, DBs, `.env`, etc.
* Pair with `httpx`, `gau`, `nuclei`, or `hakrawler` for full recon chains

---

## 📄 Output Formats

Results are saved to:

* `ffufresults.html` – clean and shareable report

---

### 🛡 Disclaimer

This tool is intended for **authorized testing** and educational purposes only. Unauthorized use against targets is **illegal**.
