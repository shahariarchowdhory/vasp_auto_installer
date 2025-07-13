# VASP Auto Installer

**Automated installation of VASP, Intel OneAPI, and VASPKit for Linux/WSL systems**

---

## Quick Start

### Step 1: Prepare Required Files
Place these files in your `$HOME` directory:
- **VASP source archive**: `Vasp.6.X.X.zip` or `Vasp.6.X.X.tar.gz`
- **POTCAR archive**: `potcar.zip` or `potcar.tar.gz` or `potcar.tgz` or `pot.zip` or `pot.tar.gz` or `pot.tgz`

### Step 2: Download and Run
```bash
wget https://raw.githubusercontent.com/shahariarchowdhory/vasp_auto_installer/refs/heads/main/vasp_auto_installer.sh -O vasp_auto_installer.sh
chmod +x vasp_auto_installer.sh
./vasp_auto_installer.sh
```

### Step 3: Install
1. Choose option `0` (Install All Components) from the menu
2. Follow the prompts
3. Restart your terminal when complete

---

## What This Script Does
1. **System Preparation**: Checks and installs required system packages
2. **Intel OneAPI**: Downloads installers (`base.sh`, `hpc.sh`) and installs compiler suite
3. **POTCAR Setup**: Extracts and organizes POTCAR files to `~/potcar`
4. **VASP Compilation**: 
   - Extracts source to `~/vasp_src`
   - Generates optimized `makefile.include` for Intel compilers
   - Compiles VASP executables
   - Copies binaries to `~/bin`
5. **VASPKit Setup**: Downloads, extracts, and configures VASPKit
6. **Environment**: Updates `~/.bashrc` with necessary paths and source commands

---

## Installation Options

The script provides an interactive menu:

| Option | Description |
|--------|-------------|
| `0` | **Install All Components** (Recommended for first-time users) |
| `1` | Intel OneAPI (Base Kit + HPC Kit) only |
| `2` | VASPKit + VASP only |
| `3` | VASP only |
| `4` | VASPKit only |
| `5` | Exit |

---

## System Requirements

### Supported Systems
- **Linux**: Debian/Ubuntu, RHEL/CentOS based distributions
- **WSL**: Windows Subsystem for Linux
- **Shell**: bash

### Required Files (in `$HOME`)
- ✅ **VASP source**: `vasp.*.tar.gz` or `vasp.*.zip`
- ✅ **POTCAR archive**: `potcar.tar.gz` or `potcar.zip`

### Optional Files (auto-downloaded if missing)
- Intel Base Kit installer: `base.sh`
- Intel HPC Kit installer: `hpc.sh`
- VASPKit archive: `vaspkit.zip` or `vaspkit.tar.gz`

---

## Post-Installation

### Reload Your Environment
```bash
source ~/.bashrc
```

### Verify Installation
Test that everything is working:

```bash
# Check Intel compilers
which ifort

# Test VASPKit
vaspkit -h

# Test VASP
vasp_std --help
```

---

## Troubleshooting

### Common Issues
- **Permission errors**: Don't run as root; the script will prompt for sudo when needed
- **Missing files**: Ensure VASP and POTCAR archives are in your `$HOME` directory
- **Path issues**: Restart your terminal or run `source ~/.bashrc`

### File Locations After Installation
- **VASP executables**: `~/bin/`
- **VASP source**: `~/vasp_src/`
- **POTCAR files**: `~/potcar/`
- **VASPKit**: `~/bin/vaspkit` (symlink)

---

## License Information

| Software | License Type | Requirements |
|----------|--------------|--------------|
| **Intel oneAPI** | Free | Intel Simplified Software License |
| **VASP** | Commercial | License required from [vasp.at](https://www.vasp.at/) |
| **POTCAR** | Restricted | Valid VASP license required |
| **VASPKit** | Free | Academic/non-commercial use only |
| **This installer** | Open Source | MIT License |

**⚠️ Important**: Users must ensure compliance with all applicable licenses, especially for VASP and POTCAR files.

---

## Credits

**Developer**: Shahariar Chowdhory  
**GitHub**: [https://github.com/shahariarchowdhory](https://github.com/shahariarchowdhory)

*If this installer helped you, please consider starring the repository!*

---

## Need Help?

1. **Check the logs**: The script provides detailed output during installation
2. **Verify prerequisites**: Ensure all required files are in place
3. **Visit the repository**: Check for updates and known issues
4. **Environment**: Make sure to restart your terminal after installation
