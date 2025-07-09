#!/bin/bash

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

log() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
log_cyan() { echo -e "${CYAN}$1${NC}"; }

display_header() {
    local delay=0.05

    slow_echo() {
        echo -e "$1"
        sleep "$delay"
    }
    echo -e 
    slow_echo "${RED} ██▒   █▓ ▄▄▄        ██████  ██▓███       ▄▄▄        █   ██ ▄▄▄█████▓ ▒█████  ${NC}"
    slow_echo "${RED}▓██░   █▒▒████▄    ▒██    ▒ ▓██░  ██▒    ▒████▄     ██  ▓██▒▓  ██▒ ▓▒▒██▒  ██▒${NC}"
    slow_echo "${RED} ▓██  █▒░▒██ ▀█▄   ░ ▓██▄   ▓██░ ██▓▒    ▒██ ▀█▄   ▓██  ▒██░▒ ▓██░ ▒░▒██░  ██▒${NC}"
    slow_echo "${RED}  ▒██ █░░░██▄▄▄▄██   ▒   ██▒▒██▄█▓▒ ▒    ░██▄▄▄▄██ ▓▓█  ░██░░ ▓██▓ ░ ▒██   ██░${NC}"
    slow_echo "${RED}  ▒▀█░   ▓█   ▓██▒▒██████▒▒▒██▒ ░  ░      ▓█   ▓██▒▒▒█████▓   ▒██▒ ░ ░ ████▓▒░${NC}"
    slow_echo "${RED}  ░ ▐░   ▒▒   ▓▒█░▒ ▒▓▒ ▒ ░▒▓▒░ ░  ░      ▒▒   ▓▒█░░▒▓▒ ▒ ▒   ▒ ░░   ░ ▒░▒░▒░ ${NC}"
    slow_echo "${RED}  ░ ░░    ▒   ▒▒ ░░ ░▒  ░ ░░▒ ░          ▒   ▒▒ ░░░▒░ ░ ░     ░      ░ ▒ ▒░ ${NC}"
    slow_echo "${RED}    ░░    ░   ▒   ░  ░  ░  ░░            ░   ▒     ░░░ ░ ░   ░      ░ ░ ░ ▒  ${NC}"
    slow_echo "${RED}      ░     ░   ░    ░   ░                 ░   ░ ░   ░             ░ ░  ${NC}"
    slow_echo "${RED}    ░                                                                      ${NC}"
    slow_echo ""

    slow_echo "${BOLD}${BLUE}============================================${NC}"
    slow_echo "${BOLD}${BLUE}        VASP Installation Script v1.0       ${NC}"
    slow_echo "${BOLD}${BLUE}============================================${NC}"
    slow_echo "${CYAN}Developer: Shahariar Chowdhory${NC}"
    slow_echo "${CYAN}GitHub: https://github.com/shahariarchowdhory${NC}"
    slow_echo "${BLUE}============================================${NC}"
    slow_echo ""

    sleep 2
}

show_instructions() {
    local delay=0.05

    slow_echo() {
        echo -e "$1"
        sleep "$delay"
    }

    slow_echo "${BOLD}${YELLOW}INSTALLATION INSTRUCTIONS${NC}"
    slow_echo "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    slow_echo ""
    slow_echo "${BOLD}Files to place in $HOME directory:${NC}"
    slow_echo "   ${RED}* Required files you MUST provide:${NC}"
    slow_echo "     - VASP source archive (vasp.*.tar.gz or vasp.*.zip)"
    slow_echo "     - POTCAR archive (potcar.tar.gz or potcar.zip)"
    slow_echo ""
    slow_echo "   ${YELLOW}Optional files (will be downloaded if not found):${NC}"
    slow_echo "     - Intel Base Kit installer (base.sh)"
    slow_echo "     - Intel HPC Kit installer (hpc.sh)"
    slow_echo "     - VASPKit archive (vaspkit.zip or vaspkit.tar.gz)"
    slow_echo ""
    slow_echo "${BOLD}Auto-downloaded files:${NC}"
    slow_echo "   - Intel Base Kit: ${CYAN}https://archive.org/download/base_2023/base.sh${NC}"
    slow_echo "   - Intel HPC Kit: ${CYAN}https://archive.org/download/hpc_2023/hpc.sh${NC}"
    slow_echo "   - VASPKit: ${CYAN}https://archive.org/download/vaspkit151.tar/vaspkit.1.5.1.linux.x64.tar.gz${NC}"
    slow_echo ""
    slow_echo "${BOLD}Current status of files in $HOME:${NC}"
    check_file_status
    slow_echo ""
    slow_echo "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    slow_echo ""
}


check_file_status() {
    cd "$HOME"
    
    vasp_found=""
    for file in $(find . -maxdepth 1 \( -name "vasp*" -o -name "VASP*" \) \( -name "*.zip" -o -name "*.tar.gz" -o -name "*.tgz" \) 2>/dev/null); do
        vasp_found="$file"
        break
    done
    
    if [ -n "$vasp_found" ]; then
        echo -e "   ${GREEN}* VASP archive found:${NC} $vasp_found"
    else
        echo -e "   ${RED}* VASP archive:${NC} NOT FOUND (Required)"
        echo -e "   ${YELLOW}* Please place vasp.*.tar.gz or vasp.*.zip in $HOME${NC}"
        echo -e "   ${YELLOW}* This file are not provided by this script due to licensing restrictions.${NC}"
        echo -e "   ${YELLOW}* You can download it from VASP official site or your institution's repository.${NC}"
        echo -e "   ${YELLOW}* Without this file, VASP will not compile and VASPkit will not be able to find VASP.${NC}"
        echo -e "   ${YELLOW}* If you have a different name for the VASP archive, please rename it to vasp.*.tar.gz or vasp.*.zip.${NC}"
        echo -e "   ${YELLOW}* You can still install Intel OneAPI and VASPKit without VASP, but VASPKit will not be able to find VASP.${NC}"
        echo -e "   ${YELLOW}* Please wait 10 seconds and read the yellow text above carefully.${NC}"  
        sleep 10
    fi
    

    potcar_found=""
    for file in $(find . -maxdepth 1 \( -name "*potcar*" -o -name "*POTCAR*" \) \( -name "*.tar.gz" -o -name "*.tgz" -o -name "*.zip" \) 2>/dev/null); do
        potcar_found="$file"
        break
    done
    
    if [ -n "$potcar_found" ]; then
        echo -e "   ${GREEN}* POTCAR archive found:${NC} $potcar_found"
    else
        echo -e "   ${RED}* POTCAR archive:${NC} NOT FOUND (Required)"
        echo -e "   ${YELLOW}* Please place potcar.tar.gz or potcar.zip in $HOME${NC}"
        echo -e "   ${YELLOW}* This file are not provided by this script due to licensing restrictions.${NC}"
        echo -e "   ${YELLOW}* You can download it from VASP official site or your institution's repository.${NC}"
        echo -e "   ${YELLOW}* Without this file, VASP will not work properly and VASPkit will not be able to find pseudopotentials.${NC}"
        echo -e "   ${YELLOW}* You can still install Intel OneAPI and VASPKit without POTCAR, but VASPKit will not be able to find pseudopotentials.${NC}"
        echo -e "   ${YELLOW}* Please wait 10 seconds and read the yellow text above carefully.${NC}"
        sleep 10
    fi
    

    if [ -f "base.sh" ]; then
        echo -e "   ${GREEN}* Intel Base Kit installer found:${NC} base.sh"
    else
        echo -e "   ${YELLOW}* Intel Base Kit installer:${NC} Will be downloaded"
    fi
    

    if [ -f "hpc.sh" ]; then
        echo -e "   ${GREEN}* Intel HPC Kit installer found:${NC} hpc.sh"
    else
        echo -e "   ${YELLOW}* Intel HPC Kit installer:${NC} Will be downloaded"
    fi
    

    vaspkit_found=""
    for file in $(find . -maxdepth 1 \( -name "*vaspkit*" -o -name "*VASPKIT*" \) \( -name "*.zip" -o -name "*.tar.gz" -o -name "*.tgz" \) 2>/dev/null); do
        vaspkit_found="$file"
        break
    done
    
    if [ -n "$vaspkit_found" ]; then
        echo -e "   ${GREEN}* VASPKit archive found:${NC} $vaspkit_found"
    else
        echo -e "   ${YELLOW}* VASPKit archive:${NC} Will be downloaded"
    fi

    sleep 2
}

check_installation_status() {

    BASE_INSTALLED=false
    if check_base_kit; then
        BASE_INSTALLED=true
    fi
    

    HPC_INSTALLED=false
    if check_hpc_kit; then
        HPC_INSTALLED=true
    fi
    

    VASPKIT_INSTALLED=false
    if [ -f "$HOME/bin/vaspkit" ] && [ -f "$HOME/.vaspkit" ]; then
        VASPKIT_INSTALLED=true
    fi
    

    VASP_INSTALLED=false
    if [ -f "$HOME/bin/vasp_std" ]; then
        VASP_INSTALLED=true
    fi
}

show_menu() {
    check_installation_status
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e
    echo -e "${BOLD}${RED} You are advised to read the top section first before proceeding. ${RED}"
    echo -e
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BOLD}${YELLOW}Select installation option:${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    sleep 2

    
    echo -n "0) Install All Components"
    if $BASE_INSTALLED && $HPC_INSTALLED && $VASPKIT_INSTALLED && $VASP_INSTALLED; then
        echo -e " ${GREEN}(All Installed)${NC} | ${YELLOW}Reinstall All${NC}"
    else
        echo -e " ${YELLOW}(Fresh Install)${NC}"
    fi
    

    echo -n "1) Intel OneAPI (Base Kit + HPC Kit)"
    if $BASE_INSTALLED && $HPC_INSTALLED; then
        echo -e " ${GREEN}(Installed)${NC} | ${YELLOW}Reinstall${NC}"
    elif $BASE_INSTALLED; then
        echo -e " ${YELLOW}(Base Kit Installed)${NC}"
    elif $HPC_INSTALLED; then
        echo -e " ${YELLOW}(HPC Kit Installed)${NC}"
    else
        echo -e " ${RED}(Not Installed)${NC}"
    fi
    

    echo -n "2) VASPKit + VASP"
    local vasp_vaspkit_status=""
    if $VASPKIT_INSTALLED && $VASP_INSTALLED; then
        vasp_vaspkit_status=" ${GREEN}(Both Installed)${NC} | ${YELLOW}Reinstall${NC}"
    elif $VASPKIT_INSTALLED; then
        vasp_vaspkit_status=" ${YELLOW}(VASPKit Installed)${NC}"
    elif $VASP_INSTALLED; then
        vasp_vaspkit_status=" ${YELLOW}(VASP Installed)${NC}"
    else
        vasp_vaspkit_status=" ${RED}(Not Installed)${NC}"
    fi
    echo -e "$vasp_vaspkit_status"
    

    echo -n "3) VASP only"
    if $VASP_INSTALLED; then
        echo -e " ${GREEN}(Installed)${NC} | ${YELLOW}Reinstall${NC}"
    else
        echo -e " ${RED}(Not Installed)${NC}"
    fi
    

    echo -n "4) VASPKit only"
    if $VASPKIT_INSTALLED; then
        echo -e " ${GREEN}(Installed)${NC} | ${YELLOW}Reinstall${NC}"
    else
        echo -e " ${RED}(Not Installed)${NC}"
    fi
    
    echo "5) Exit"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo
    read -p "Enter your choice (0-5): " choice
}

show_vasp_warning_menu() {
    echo -e "${BOLD}${RED}DEPENDENCY WARNING${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${YELLOW}VASP compilation requires Intel OneAPI components:${NC}"
    echo -e "   ${RED}* Intel Base Kit: NOT INSTALLED${NC}"
    echo -e "   ${RED}* Intel HPC Kit: NOT INSTALLED${NC}"
    echo
    echo -e "${BOLD}${YELLOW}VASP will likely FAIL to compile without these components!${NC}"
    echo
    echo -e "${BOLD}Options:${NC}"
    echo "1) Install Intel OneAPI first, then VASP (Recommended)"
    echo "2) Proceed anyway (NOT RECOMMENDED)"
    echo "3) Return to main menu"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo
    read -p "Enter your choice (1-3): " warning_choice
}

confirm_reinstall() {
    local component="$1"
    echo -e "${BOLD}${YELLOW}REINSTALL CONFIRMATION${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${YELLOW}$component is already installed.${NC}"
    echo -e "${BOLD}This will:${NC}"
    echo -e "   ${RED}* Remove existing installation${NC}"
    echo -e "   ${GREEN}* Perform clean installation${NC}"
    echo
    echo -e "${BOLD}Do you want to proceed with reinstallation?${NC}"
    echo "1) Yes, reinstall"
    echo "2) No, skip"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo
    read -p "Enter your choice (1-2): " reinstall_choice
    
    if [ "$reinstall_choice" = "1" ]; then
        return 0
    else
        return 1
    fi
}

clean_intel_installation() {
    log "Checking for Intel oneAPI Base Kit..."

    base_paths="/opt/intel/oneapi $HOME/intel/oneapi /usr/local/intel/oneapi"

    for path in $base_paths; do
        if [ -d "$path" ] && [ -f "$path/setvars.sh" ]; then
            if [ -f "$path/compiler/latest/env/vars.sh" ]; then
                log_success "Intel oneAPI Base Kit found at: $path"
                export ONEAPI_BASE_PATH="$path"
                return 0
            fi
        fi
    done

    if command -v icx >/dev/null 2>&1 || command -v icc >/dev/null 2>&1; then
        log_success "Intel compilers found in PATH"
        return 0
    fi

    log_warning "Intel oneAPI Base Kit not found"
    echo "Searching for old Intel residual installations..."
    # Remove installer caches
    echo "Removing installer cache folders..."

    sudo rm -rf /var/intel/installercache
    sudo rm -rf /opt/intel/installer
    sudo rm -rf /opt/intel
    sudo rm -rf /usr/local/intel
    sudo rm -rf /usr/intel
    sudo rm -rf /var/log/intel
    sudo rm -rf $HOME/intel
    # Remove hidden config files in user home
    echo "Removing hidden Intel config folders..."

    rm -rf ~/.config/intel
    rm -rf ~/.intel

    echo "Intel cleanup complete!"
}


clean_vaspkit_installation() {
    log "Cleaning existing VASPKit installation. This should be very quick, typically less than a few seconds."
    
    rm -rf "$HOME/vaspkit" 2>/dev/null || true
    rm -f "$HOME/bin/vaspkit" 2>/dev/null || true
    rm -f "$HOME/.vaspkit" 2>/dev/null || true
    
    local bashrc="$HOME/.bashrc"
    if [ -f "$bashrc" ]; then
        sed -i '/vaspkit/d' "$bashrc"
    fi
    
    log_success "VASPKit installation cleaned"
}

clean_vasp_installation() {
    log "Cleaning existing VASP installation. This should be very quick, typically less than a few seconds."
    
    rm -f "$HOME/bin/vasp_std" "$HOME/bin/vasp_gam" "$HOME/bin/vasp_ncl" 2>/dev/null || true
    rm -rf "$HOME/vasp_src" 2>/dev/null || true
    
    log_success "VASP installation cleaned"
}

check_system_deps() {
    log "Checking system dependencies..."
    missing_deps=""
    required_tools="make gcc g++ gfortran unzip tar wget curl python3"

    for cmd in $required_tools; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            missing_deps="$missing_deps $cmd"
        fi
    done

    if [ -n "$missing_deps" ]; then
        log_error "Missing dependencies:$missing_deps"
        log "Installing missing dependencies..."
        
        if command -v apt-get >/dev/null 2>&1; then
            sudo apt-get update && sudo apt-get install -y $missing_deps
        elif command -v yum >/dev/null 2>&1; then
            sudo yum install -y $missing_deps
        elif command -v dnf >/dev/null 2>&1; then
            sudo dnf install -y $missing_deps
        else
            log_error "Cannot detect package manager. Please install missing dependencies manually: $missing_deps"
            exit 1
        fi
    fi
    log_success "All system dependencies found"
}

find_or_download_intel() {
    log "Searching for Intel OneAPI installers..."
    
    cd "$HOME"
    
    base_found=""
    hpc_found=""
    
    for file in $(find . -maxdepth 1 -name "*base*" -name "*.sh" 2>/dev/null); do
        if [[ "$file" =~ (base|toolkit) ]]; then
            base_found="$file"
            break
        fi
    done
    
    for file in $(find . -maxdepth 1 -name "*hpc*" -name "*.sh" 2>/dev/null); do
        if [[ "$file" =~ (hpc|fortran) ]]; then
            hpc_found="$file"
            break
        fi
    done
    
    if [ -n "$base_found" ] && [ "$base_found" != "./base.sh" ]; then
        mv "$base_found" "./base.sh"
        log_success "Renamed $base_found to base.sh"
    fi
    
    if [ -n "$hpc_found" ] && [ "$hpc_found" != "./hpc.sh" ]; then
        mv "$hpc_found" "./hpc.sh"
        log_success "Renamed $hpc_found to hpc.sh"
    fi
    
    if [ ! -f "base.sh" ]; then
        log "Downloading Intel Base Kit..."
        wget -O base.sh "https://archive.org/download/base_2023/base.sh" || {
            log_error "Failed to download Base Kit installer"
            exit 1
        }
    fi
    
    if [ ! -f "hpc.sh" ]; then
        log "Downloading Intel HPC Kit..."
        wget -O hpc.sh "https://archive.org/download/hpc_2023/hpc.sh" || {
            log_error "Failed to download HPC Kit installer"
            exit 1
        }
    fi
    
    chmod +x base.sh hpc.sh
    log_success "Intel installers ready"
}

check_base_kit() {
    local base_paths="/opt/intel/oneapi $HOME/intel/oneapi /usr/local/intel/oneapi"
    
    for path in $base_paths; do
        if [ -d "$path" ] && [ -f "$path/setvars.sh" ] && [ -f "$path/compiler/latest/env/vars.sh" ]; then
            export ONEAPI_BASE_PATH="$path"
            return 0
        fi
    done
    
    if command -v icx >/dev/null 2>&1 || command -v icc >/dev/null 2>&1; then
        return 0
    fi
    
    return 1
}

check_hpc_kit() {
    if command -v ifort >/dev/null 2>&1 || command -v ifx >/dev/null 2>&1; then
        return 0
    fi
    
    local hpc_paths="/opt/intel/oneapi $HOME/intel/oneapi /usr/local/intel/oneapi"
    
    for path in $hpc_paths; do
        if [ -f "$path/mpi/latest/env/vars.sh" ]; then
            export ONEAPI_HPC_PATH="$path"
            return 0
        fi
    done
    
    return 1
}

install_intel_kits() {
    log "Installing Intel OneAPI kits. It should take around 10-20 minutes depending on your internet speed and system performance."
    sleep 2
    install_dir="$HOME/intel/oneapi"
    mkdir -p "$install_dir"

    cd "$HOME"
    
    if ! check_base_kit; then
        log "Installing Intel Base Kit..."

        if sudo ./base.sh -a --silent --eula accept --install-dir "$install_dir"; then
            log_success "Intel oneAPI Base Kit installed successfully."
            export ONEAPI_BASE_PATH="$install_dir"
        else
            log_error "Base Kit installation failed or already installed."
            #exit 1
        fi

        if sudo ./hpc.sh -a --silent --eula accept --install-dir "$install_dir"; then
            log_success "Intel oneAPI HPC Kit installed successfully."
            export ONEAPI_HPC_PATH="$install_dir"
        else
            log_error "HPC Kit installation failed or already installed."
            #exit 1
        fi
    fi
    
    source_intel_env
}

source_intel_env() {
    log "Setting up Intel oneAPI environment..."

    oneapi_path=""
    search_paths="/opt/intel/oneapi $HOME/intel/oneapi $ONEAPI_BASE_PATH $ONEAPI_HPC_PATH"

    for path in $search_paths; do
        if [ -n "$path" ] && [ -d "$path" ] && [ -f "$path/setvars.sh" ]; then
            oneapi_path="$path"
            break
        fi
    done

    if [ -z "$oneapi_path" ]; then
        log_error "Cannot find Intel oneAPI installation"
        exit 1
    fi

    log "Sourcing Intel oneAPI environment from: $oneapi_path"
    if . "$oneapi_path/setvars.sh" --force; then
        log_success "Intel oneAPI environment loaded successfully"
    else
        log_error "Failed to source Intel oneAPI environment"
        exit 1
    fi

    bashrc="$HOME/.bashrc"
    setvars_line="source $oneapi_path/setvars.sh --force"

    if grep -Fxq "$setvars_line" "$bashrc"; then
        log "Intel oneAPI environment is already sourced in $bashrc"
    else
        echo "" >> "$bashrc"
        echo "# Added by VASP installer" >> "$bashrc"
        echo "$setvars_line" >> "$bashrc"
        log_success "Added Intel oneAPI environment to $bashrc"
    fi
}


find_or_download_vaspkit() {
    log "Searching for VASPKit archive..."
    
    cd "$HOME" || exit 1
    
    vaspkit_found=""
    
    for file in $(find . -maxdepth 1 \( -iname "*vaspkit*" \) \( -name "*.zip" -o -name "*.tar.gz" -o -name "*.tgz" \) 2>/dev/null); do
        vaspkit_found="$file"
        break
    done
    
    if [ -n "$vaspkit_found" ]; then
        basefile="${vaspkit_found#./}"
        
        if [[ "$basefile" == "vaspkit.zip" || "$basefile" == "vaspkit.tar.gz" ]]; then
            log "Found archive already named: $basefile"
        else
            if [[ "$basefile" == *.tar.gz || "$basefile" == *.tgz ]]; then
                mv "$vaspkit_found" "./vaspkit.tar.gz"
                log_success "Renamed $vaspkit_found to vaspkit.tar.gz"
            else
                mv "$vaspkit_found" "./vaspkit.zip"
                log_success "Renamed $vaspkit_found to vaspkit.zip"
            fi
        fi
    fi
    
    if [ ! -f "vaspkit.zip" ] && [ ! -f "vaspkit.tar.gz" ]; then
        log "Downloading VASPKit..."
        wget -O vaspkit.tar.gz "https://archive.org/download/vaspkit151.tar/vaspkit.1.5.1.linux.x64.tar.gz" || {
            log_error "Failed to download VASPKit"
            exit 1
        }
    fi
    
    log_success "VASPKit archive ready"
    return 0
}

install_vaspkit() {
    log "Installing VASPKit..."
    
    cd "$HOME" || exit 1
    
    if [ -d "vaspkit" ]; then
        rm -rf vaspkit
    fi

    success=0
    
    while [ $success -eq 0 ]; do
        decompress_error=0
        if [ -f "vaspkit.zip" ]; then
            unzip -q vaspkit.zip || decompress_error=1
        elif [ -f "vaspkit.tar.gz" ]; then
            tar -xzf vaspkit.tar.gz || decompress_error=1
        else
            log_error "No VASPKit archive found."
            decompress_error=1
        fi
        
        if [ "$decompress_error" == "1" ]; then
            log_error "Failed to decompress VASPKit archive. The file may be corrupted."
            
            echo "Choose an option:"
            echo "1) Redownload automatically"
            echo "2) Manually place archive and retry"
            echo "3) Cancel installation"
            
            read -rp "Enter your choice [1/2/3]: " choice
            
            case $choice in
                1)
                    rm -f vaspkit.zip vaspkit.tar.gz
                    find_or_download_vaspkit
                    decompress_error=0
                    continue
                    ;;
                2)
                    echo "Please place the correct archive in your home directory and press Enter to continue."
                    read -r
                    decompress_error=0
                    continue
                    ;;
                3)
                    log_error "Installation cancelled by user."
                    exit 1
                    ;;
                *)
                    echo "Invalid choice. Please try again."
                    decompress_error=0
                    continue
                    ;;
            esac
        else
            success=1
        fi
    done

    vaspkit_dir=$(find . -maxdepth 3 \
        \( -type f -name "vaspkit" -executable \) \
        -exec dirname {} \; | head -1)

    if [ -z "$vaspkit_dir" ]; then
        log_error "VASPKit executable not found after extraction."
        exit 1
    fi

    vaspkit_root=$(cd "$vaspkit_dir" && pwd)

    mkdir -p "$HOME/vaspkit"
    
    if [ "$vaspkit_root" != "$HOME/vaspkit" ]; then
        cp -r "$vaspkit_root"/* "$HOME/vaspkit/"
        rm -rf "$vaspkit_root"
    fi

    mkdir -p "$HOME/bin"
    ln -sf "$HOME/vaspkit/vaspkit" "$HOME/bin/vaspkit"

    setup_vaspkit_config

    log_success "VASPKit installed successfully"
}

setup_vaspkit_config() {
    log "Setting up VASPKit configuration..."
    
    local python_bin=""
    if command -v python3 >/dev/null 2>&1; then
        python_bin=$(which python3)
    elif command -v python >/dev/null 2>&1; then
        python_bin=$(which python)
    else
        log_error "Python not found"
        exit 1
    fi
    
    setup_potcar
    
    cat > "$HOME/.vaspkit" << EOF
VASP5                       =     .TRUE.
LDA_PATH                    =     $HOME/potcar/LDA
PBE_PATH                    =     $HOME/potcar/PBE
GGA_PATH                    =     $HOME/potcar/GGA
VASPKIT_UTILITIES_PATH      =     $HOME/vaspkit/utilities
PYTHON_BIN                  =     $python_bin
POTCAR_TYPE                 =     PBE
GW_POTCAR                   =     .FALSE.
RECOMMENDED_POTCAR          =     .TRUE.
SET_FERMI_ENERGY_ZERO       =     .TRUE.
ADVANCED_USER               =     .TRUE.
EOF
    
    local bashrc="$HOME/.bashrc"
    local vaspkit_env='export PATH="$HOME/bin:$HOME/vaspkit:$PATH"'
    
    if ! grep -Fq "$vaspkit_env" "$bashrc"; then
        echo "" >> "$bashrc"
        echo "$vaspkit_env" >> "$bashrc"
    fi
    
    source "$HOME/.bashrc" 2>/dev/null || true
    
    log_success "VASPKit configuration completed"
}

setup_potcar() {
    log "Setting up POTCAR files..."
    
    cd "$HOME"
    
    potcar_archive=""
    for file in $(find . -maxdepth 1 \( -name "*potcar*" -o -name "*POTCAR*" \) \( -name "*.tar.gz" -o -name "*.tgz" -o -name "*.zip" \) 2>/dev/null); do
        potcar_archive="$file"
        break
    done
    
    if [ -z "$potcar_archive" ]; then
        log_error "No POTCAR archive found. Please place potcar.tar.gz in $HOME"
        exit 1
    fi
    
    if [ -d "potcar" ]; then
        rm -rf potcar
    fi
    
    mkdir -p potcar
    
    case "$potcar_archive" in
        *.zip)
            unzip -q "$potcar_archive" -d potcar
            ;;
        *.tar.gz|*.tgz)
            tar -xzf "$potcar_archive" -C potcar
            ;;
    esac
    
    subdirs=$(find potcar -mindepth 1 -maxdepth 1 -type d | wc -l)
    if [ "$subdirs" -eq 1 ]; then
        subdir=$(find potcar -mindepth 1 -maxdepth 1 -type d)
        if [ -n "$subdir" ]; then
            mv "$subdir"/* potcar/
            rmdir "$subdir"
        fi
    fi
    
    log_success "POTCAR files extracted"
}

find_vasp_archive() {
    log "Searching for VASP archive..."
    
    cd "$HOME"
    
    vasp_archive=""
    for file in $(find . -maxdepth 1 \( -name "vasp*" -o -name "VASP*" \) \( -name "*.zip" -o -name "*.tar.gz" -o -name "*.tgz" \) 2>/dev/null); do
        vasp_archive="$file"
        break
    done
    
    if [ -z "$vasp_archive" ]; then
        log_error "No VASP archive found. Please place VASP archive in $HOME"
        exit 1
    fi
    
    export VASP_ARCHIVE="$vasp_archive"
    log_success "Found VASP archive: $VASP_ARCHIVE"
}

install_vasp() {
    log "Installing VASP..."
    
    cd "$HOME"
    
    if [ -d "vasp_src" ]; then
        rm -rf vasp_src
    fi
    
    mkdir -p vasp_src
    
    case "$VASP_ARCHIVE" in
        *.zip)
            unzip -q "$VASP_ARCHIVE" -d vasp_src
            ;;
        *.tar.gz|*.tgz)
            tar -xzf "$VASP_ARCHIVE" -C vasp_src
            ;;
    esac
    
    vasp_root=$(find vasp_src -name "src" -type d | head -1)
    if [ -z "$vasp_root" ]; then
        log_error "VASP source directory not found"
        exit 1
    fi
    
    vasp_root=$(dirname "$vasp_root")
    
    if [ "$vasp_root" != "vasp_src" ]; then
        mv "$vasp_root"/* vasp_src/
    fi
    
    cd vasp_src
    
    generate_makefile_include
    
    log "Compiling VASP..."
    make veryclean 2>/dev/null || true
    make DEPS=1 -j$(nproc) all
    
    mkdir -p "$HOME/bin"
    cp bin/vasp_std "$HOME/bin/"
    
    for variant in vasp_gam vasp_ncl; do
        if [ -f "bin/$variant" ]; then
            cp "bin/$variant" "$HOME/bin/"
        fi
    done
    
    local bashrc="$HOME/.bashrc"
    local path_line='export PATH="$HOME/bin:$PATH"'
    
    if ! grep -Fq "$path_line" "$bashrc"; then
        echo "" >> "$bashrc"
        echo "$path_line" >> "$bashrc"
    fi
    
    log_success "VASP compiled and installed successfully"
}

generate_makefile_include() {
    log "Generating makefile.include..."
    
    local dcache_size=8000
    if [ -f "/sys/devices/system/cpu/cpu0/cache/index3/size" ]; then
        local size=$(cat /sys/devices/system/cpu/cpu0/cache/index3/size)
        if [[ $size == *K ]]; then
            dcache_size=${size%K}
        elif [[ $size == *M ]]; then
            local size_mb=${size%M}
            dcache_size=$(( size_mb * 1024 ))
        fi
    fi
    
    local cpu_vendor=$(lscpu | grep "Vendor ID" | awk '{print $3}')
    local fflags_opt="-assume byterecl -w"
    local oflag_opt="-O3 -msse2 -march=core-avx2"
    
    if [[ "$cpu_vendor" == "GenuineIntel" ]]; then
        fflags_opt="-assume byterecl -w -xHOST"
        oflag_opt="-O2 -xCORE-AVX2"
    fi
    
    cat > makefile.include << EOF
CPP_OPTIONS= -DHOST=\\"LinuxIFC\\" \\
             -DMPI -Duse_collective -DMPI_BLOCK=2*$dcache_size \\
             -DscaLAPACK \\
             -DCACHE_SIZE=$dcache_size \\
             -Davoidalloc \\
             -Dvasp6 \\
             -Duse_bse_te \\
             -Dtbdyn \\
             -Dfock_dblbuf

CPP        = fpp -f_com=no -free -w0  \$*\$(FUFFIX) \$*\$(SUFFIX) \$(CPP_OPTIONS)

FC         = mpiifort
FCL        = mpiifort -mkl=sequential

FREE       = -free -names lowercase

FFLAGS     = $fflags_opt
OFLAG      = $oflag_opt
OFLAG_IN   = \$(OFLAG)
DEBUG      = -O0

BLAS       = -L\${MKLROOT}/lib/intel64 -lmkl_scalapack_lp64 -lmkl_cdft_core -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lmkl_blacs_intelmpi_lp64 -lpthread -lm -ldl
LAPACK     = -L\${MKLROOT}/lib/intel64 -lmkl_scalapack_lp64 -lmkl_cdft_core -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lmkl_blacs_intelmpi_lp64 -lpthread -lm -ldl
BLACS      = -L\${MKLROOT}/lib/intel64 -lmkl_scalapack_lp64 -lmkl_cdft_core -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lmkl_blacs_intelmpi_lp64 -lpthread -lm -ldl
SCALAPACK  = -L\${MKLROOT}/lib/intel64 -lmkl_scalapack_lp64 -lmkl_cdft_core -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lmkl_blacs_intelmpi_lp64 -lpthread -lm -ldl

OBJECTS    = fftmpiw.o fftmpi_map.o fft3dlib.o fftw3d.o
INCS       = -I\$(MKLROOT)/include/fftw
LLIBS      = \$(SCALAPACK) \$(LAPACK) \$(BLAS)

OBJECTS_O1 += fftw3d.o fftmpi.o fftmpiw.o
OBJECTS_O2 += fft3dlib.o

CPP_LIB    = \$(CPP)
FC_LIB     = \$(FC)
CC_LIB     = icx
CFLAGS_LIB = -O
FFLAGS_LIB = -O1
FREE_LIB   = \$(FREE)

OBJECTS_LIB= linpack_double.o getshmem.o

CXX_PARS   = icpx
LLIBS      += -lstdc++

SRCDIR     = ../../src
BINDIR     = ../../bin
EOF
    
    log_success "makefile.include generated"
}

main() {
    display_header
    show_instructions
    
    if [ "$(id -u)" -eq 0 ]; then
        log_error "Do not run as root"
        exit 1
    fi
    
    check_system_deps
    
    show_menu
    
    case $choice in
        0)
            # Install All Components
            clean_intel_installation
            clean_vaspkit_installation
            clean_vasp_installation
            find_or_download_intel
            install_intel_kits
            find_or_download_vaspkit
            install_vaspkit
            find_vasp_archive
            install_vasp
            ;;
        1)
            # Intel OneAPI (Base Kit + HPC Kit)
            if $BASE_INSTALLED && $HPC_INSTALLED; then
                if confirm_reinstall "Intel OneAPI (Base Kit + HPC Kit)"; then
                    clean_intel_installation
                else
                    log_warning "Skipping Intel OneAPI installation"
                    exit 0
                fi
            fi
            find_or_download_intel
            install_intel_kits
            ;;
        2)
            # VASPKit + VASP
            if ! $BASE_INSTALLED || ! $HPC_INSTALLED; then
                show_vasp_warning_menu
                case $warning_choice in
                    1)
                        find_or_download_intel
                        install_intel_kits
                        ;;
                    2)
                        log_warning "Proceeding without Intel OneAPI - VASP may fail to compile!"
                        ;;
                    3)
                        log "Returning to main menu..."
                        main
                        return
                        ;;
                    *)
                        log_error "Invalid choice"
                        exit 1
                        ;;
                esac
            fi
            
            if $VASPKIT_INSTALLED; then
                if confirm_reinstall "VASPKit"; then
                    clean_vaspkit_installation
                fi
            fi
            
            if $VASP_INSTALLED; then
                if confirm_reinstall "VASP"; then
                    clean_vasp_installation
                fi
            fi
            
            find_or_download_vaspkit
            install_vaspkit
            find_vasp_archive
            install_vasp
            ;;
        3)
            # VASP only
            if ! $BASE_INSTALLED || ! $HPC_INSTALLED; then
                show_vasp_warning_menu
                case $warning_choice in
                    1)
                        find_or_download_intel
                        install_intel_kits
                        ;;
                    2)
                        log_warning "Proceeding without Intel OneAPI - VASP may fail to compile!"
                        find_vasp_archive
                        install_vasp
                        ;;
                    3)
                        log "Returning to main menu..."
                        main
                        return
                        ;;
                    *)
                        log_error "Invalid choice"
                        exit 1
                        ;;
                esac
            fi
            
            if $VASP_INSTALLED; then
                if confirm_reinstall "VASP"; then
                    clean_vasp_installation
                else
                    log_warning "Skipping VASP installation"
                    exit 0
                fi
            fi
            
            find_vasp_archive
            install_vasp
            ;;
        4)
            # VASPKit only
            if $VASPKIT_INSTALLED; then
                if confirm_reinstall "VASPKit"; then
                    clean_vaspkit_installation
                else
                    log_warning "Skipping VASPKit installation"
                    exit 0
                fi
            fi
            find_or_download_vaspkit
            install_vaspkit
            ;;
        5)
            log "Exiting..."
            exit 0
            ;;
        *)
            log_error "Invalid choice"
            exit 1
            ;;
    esac
    
    echo
    echo -e "${BOLD}${GREEN}Installation completed successfully!${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${YELLOW}Next steps:${NC}"
    echo -e "   1. Restart your terminal or run: ${CYAN}source ~/.bashrc${NC}"
    echo -e "   2. Verify installations:"
    if $BASE_INSTALLED || [ "$choice" = "0" ] || [ "$choice" = "1" ]; then
        echo -e "     - Intel OneAPI: ${CYAN}which ifort${NC}"
    fi
    if $VASPKIT_INSTALLED || [ "$choice" = "0" ] || [ "$choice" = "2" ] || [ "$choice" = "4" ]; then
        echo -e "     - VASPKit: ${CYAN}vaspkit -h${NC}"
    fi
    if $VASP_INSTALLED || [ "$choice" = "0" ] || [ "$choice" = "2" ] || [ "$choice" = "3" ]; then
        echo -e "     - VASP: ${CYAN}vasp_std --help${NC}"
    fi
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

main "$@"
