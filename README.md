# VASP Installation Script

## 🚀 Overview

This script automates the installation of VASP, Intel OneAPI (Base Kit + HPC Kit), and VASPKit. It handles dependency resolution, package downloads, VASP compilation with Intel compilers, and environment configuration.

# **TL;DR — Just Copy, Paste, and Run**

1. **Prepare Files** Make sure the VASP source archive (e.g. `Vasp.6.X.X.zip` or `Vasp.6.X.X.tar.gz`) and the POTCAR archive (`potcar.zip` or `potcar.tar.gz`) are placed in your `$HOME` directory on your Linux or WSL system.

2. **Run the Installer Script** Open your terminal and run the following commands:

```bash
wget https://raw.githubusercontent.com/shahariarchowdhory/vasp_auto_installer/refs/heads/main/vasp_auto_installer.sh -O vasp_auto_installer.sh
chmod +x vasp_auto_installer.sh
./vasp_auto_installer.sh
```

3. **Follow the Prompts** The script will guide you through installing Intel OneAPI, VASP, and VASPKit via a simple menu.

4. **Select Fresh Install** Choose option `0` (zero) in the menu to perform a fresh installation of everything.

5. **Restart Your Terminal** Once the installation is finished, close your terminal and open it again.

6. **All Done!** VASP should now be installed and ready to use on your system.

## ⚙️ Installation Options

The script will present an interactive menu:

0) Install All Components
1) Intel OneAPI (Base Kit + HPC Kit)
2) VASPKit + VASP
3) VASP only
4) VASPKit only
5) Exit

Select the desired option to proceed with the installation.

## ✨ Functionality

This script performs the following:

* **System Dependency Check and Installation:** Checks for and installs `make`, `gcc`, `g++`, `gfortran`, `unzip`, `tar`, `wget`, `curl`, and `python3`.
* **Intel OneAPI Management:** Finds or downloads Intel Base Kit and HPC Kit installers (`base.sh`, `hpc.sh`) and installs them.
* **VASPKit Management:** Finds or downloads a VASPKit archive, extracts it, creates a `~/bin/vaspkit` symlink, and sets up the `.vaspkit` configuration.
* **POTCAR Setup:** Locates the provided POTCAR archive, extracts it to `~/potcar`, and organizes its contents.
* **VASP Compilation and Installation:** Finds the VASP source archive, extracts it to `~/vasp_src`, generates a `makefile.include` for Intel compilers/MKL, compiles VASP, and copies executables to `~/bin`.
* **Environment Configuration:** Adds necessary `source` commands and `PATH` modifications to `~/.bashrc`.
* **Interactive User Interface:** Provides a menu to select components for installation and handles reinstallation confirmations.

## 📋 Prerequisites

* Linux OS (Debian/Ubuntu or RHEL/CentOS based).

* bash shell.

* **Required in $HOME:**

  * VASP source archive (vasp.*.tar.gz or vasp.*.zip).

  * POTCAR archive (potcar.tar.gz or potcar.zip).

* **Optional Files (in $HOME or auto-downloaded)**

  * base.sh (Intel Base Kit installer)

  * hpc.sh (Intel HPC Kit installer)

  * vaspkit.zip or vaspkit.tar.gz (VASPKit archive)

**Download URLs for Optional Files:**

* Intel Base Kit: https://archive.org/download/base_2023/base.sh

* Intel HPC Kit: https://archive.org/download/hpc_2023/hpc.sh

* VASPKit: https://archive.org/download/vaspkit151.tar/vaspkit.1.5.1.linux.x64.tar.gz

## ⬇️ Download & Prepare Script

1. **Download:**

   
```bash
   wget https://raw.githubusercontent.com/shahariarchowdhory/vasp_auto_installer/refs/heads/main/vasp_auto_installer.sh -O vasp_auto_installer.sh
```

2. **Make Executable:**

   
```bash
   chmod +x vasp_auto_installer.sh
```
## 🚀 Usage

1. **Place Archives:** Ensure VASP source and POTCAR archives are in your $HOME directory.

2. **Run Script:**

   
```bash
   ./vasp_auto_installer.sh
```

   *(Do not run as root; sudo will be prompted when required for system-wide operations.)*

 ## Or just copy and paste

   ```bash
   wget https://raw.githubusercontent.com/shahariarchowdhory/vasp_auto_installer/refs/heads/main/vasp_auto_installer.sh -O vasp_auto_installer.sh
   chmod +x vasp_auto_installer.sh
   ./vasp_auto_installer.sh
   ```

  

## ✅ Post-Installation

1. **Reload Shell:**

   
bash
   source ~/.bashrc


2. **Verify Installations:**

   * **Intel OneAPI:** which ifort

   * **VASPKit:** vaspkit -h

   * **VASP:** vasp_std --help

## 👨‍💻 Developer

**Shahariar Chowdhory**
GitHub: [https://github.com/shahariarchowdhory](https://github.com/shahariarchowdhory)
(Don't forget to star the repo if it helped you)
