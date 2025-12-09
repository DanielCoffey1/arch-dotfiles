#!/bin/bash

# Dotfiles installation script for Arch Linux
# This script will install all packages and restore configurations

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  Dotfiles Installation Script${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""

# Check if running on Arch Linux
if [ ! -f /etc/arch-release ]; then
    echo -e "${RED}Error: This script is designed for Arch Linux only.${NC}"
    exit 1
fi

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

echo -e "${YELLOW}Dotfiles directory: $DOTFILES_DIR${NC}"
echo ""

# Function to install yay if not present
install_yay() {
    if ! command -v yay &> /dev/null; then
        echo -e "${YELLOW}Installing yay (AUR helper)...${NC}"
        sudo pacman -S --needed --noconfirm git base-devel
        cd /tmp
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si --noconfirm
        cd "$DOTFILES_DIR"
        echo -e "${GREEN}yay installed successfully!${NC}"
    else
        echo -e "${GREEN}yay is already installed.${NC}"
    fi
}

# Install official packages
install_official_packages() {
    echo ""
    echo -e "${YELLOW}Installing official packages...${NC}"
    if [ -f pkglist.txt ]; then
        sudo pacman -S --needed --noconfirm - < pkglist.txt
        echo -e "${GREEN}Official packages installed!${NC}"
    else
        echo -e "${RED}pkglist.txt not found!${NC}"
    fi
}

# Install AUR packages
install_aur_packages() {
    echo ""
    echo -e "${YELLOW}Installing AUR packages...${NC}"
    if [ -f aur-pkglist.txt ]; then
        yay -S --needed --noconfirm - < aur-pkglist.txt
        echo -e "${GREEN}AUR packages installed!${NC}"
    else
        echo -e "${RED}aur-pkglist.txt not found!${NC}"
    fi
}

# Create symlinks for config files
setup_symlinks() {
    echo ""
    echo -e "${YELLOW}Setting up configuration symlinks...${NC}"

    # Backup existing configs
    if [ -d ~/.config ]; then
        echo -e "${YELLOW}Backing up existing .config directory...${NC}"
        mv ~/.config ~/.config.backup.$(date +%Y%m%d_%H%M%S)
    fi

    # Create symlink for .config
    if [ -d "$DOTFILES_DIR/config" ]; then
        ln -sf "$DOTFILES_DIR/config" ~/.config
        echo -e "${GREEN}Symlinked .config${NC}"
    fi

    # Symlink bashrc
    if [ -f "$DOTFILES_DIR/bashrc" ]; then
        ln -sf "$DOTFILES_DIR/bashrc" ~/.bashrc
        echo -e "${GREEN}Symlinked .bashrc${NC}"
    fi

    # Symlink bash_profile
    if [ -f "$DOTFILES_DIR/bash_profile" ]; then
        ln -sf "$DOTFILES_DIR/bash_profile" ~/.bash_profile
        echo -e "${GREEN}Symlinked .bash_profile${NC}"
    fi

    # Symlink gtkrc-2.0
    if [ -f "$DOTFILES_DIR/gtkrc-2.0" ]; then
        ln -sf "$DOTFILES_DIR/gtkrc-2.0" ~/.gtkrc-2.0
        echo -e "${GREEN}Symlinked .gtkrc-2.0${NC}"
    fi

    echo -e "${GREEN}Symlinks created successfully!${NC}"
}

# Enable systemd services
enable_systemd_services() {
    echo ""
    echo -e "${YELLOW}Enabling systemd services...${NC}"

    # User services
    systemctl --user enable pipewire.socket pipewire-pulse.socket wireplumber.service || true

    echo -e "${GREEN}Systemd services enabled!${NC}"
}

# Main installation flow
main() {
    echo -e "${YELLOW}Choose installation option:${NC}"
    echo "1) Full installation (packages + configs)"
    echo "2) Install packages only"
    echo "3) Setup configs only (symlinks)"
    echo "4) Exit"
    echo ""
    read -p "Enter your choice [1-4]: " choice

    case $choice in
        1)
            echo -e "${GREEN}Starting full installation...${NC}"
            install_yay
            install_official_packages
            install_aur_packages
            setup_symlinks
            enable_systemd_services
            ;;
        2)
            echo -e "${GREEN}Installing packages only...${NC}"
            install_yay
            install_official_packages
            install_aur_packages
            ;;
        3)
            echo -e "${GREEN}Setting up configs only...${NC}"
            setup_symlinks
            enable_systemd_services
            ;;
        4)
            echo -e "${YELLOW}Exiting...${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid choice!${NC}"
            exit 1
            ;;
    esac

    echo ""
    echo -e "${GREEN}========================================${NC}"
    echo -e "${GREEN}  Installation complete!${NC}"
    echo -e "${GREEN}========================================${NC}"
    echo ""
    echo -e "${YELLOW}Please log out and log back in for all changes to take effect.${NC}"
}

main
