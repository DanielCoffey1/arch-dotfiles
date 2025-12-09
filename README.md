# Dotfiles

My personal Arch Linux configuration files and setup automation.

## Features

- Hyprland window manager configuration
- Waybar status bar
- Terminal configs (Alacritty, Kitty, Ghostty)
- Shell configuration (Bash with Starship prompt)
- Neovim configuration
- Application configs and themes
- Complete package lists (official repos + AUR)
- Automated installation script

## Quick Start

### Fresh Arch Linux Installation

1. Install Git:
```bash
sudo pacman -S git
```

2. Clone this repository:
```bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

3. Run the installation script:
```bash
chmod +x install.sh
./install.sh
```

4. Choose installation option:
   - **Option 1**: Full installation (packages + configs)
   - **Option 2**: Install packages only
   - **Option 3**: Setup configs only (symlinks)

5. Log out and log back in for all changes to take effect.

## What Gets Installed

### Window Manager & Desktop
- Hyprland (Wayland compositor)
- Waybar (status bar)
- SDDM (display manager)
- Plymouth (boot splash)
- Plasma Desktop components

### Applications
- Browsers: Firefox, Chromium
- Terminals: Alacritty, Kitty, Konsole, Ghostty
- Editors: Neovim, Kate
- File managers: Dolphin, Nautilus
- Media: MPV, OBS Studio, Kdenlive
- Office: LibreOffice
- Communication: Signal Desktop, Spotify
- Utilities: btop, fastfetch, and many more

### Development Tools
- Docker & Docker Compose
- Git, GitHub CLI
- Programming languages: Rust, Ruby, Python, Node.js (via mise)
- Neovim with full configuration
- Lazy tools: lazygit, lazydocker

### System Utilities
- Audio: PipeWire, WirePlumber
- Network: NetworkManager, IWD
- Bluetooth: BlueDevil
- Power management: PowerDevil
- Backup: Snapper (btrfs snapshots)

## Configuration Files

All configuration files are symlinked from this repository to their proper locations:

- `config/` → `~/.config/`
- `bashrc` → `~/.bashrc`
- `bash_profile` → `~/.bash_profile`
- `gtkrc-2.0` → `~/.gtkrc-2.0`
- `wallpapers/` → copied to `~/Pictures/`

## Themes and Appearance

- **GTK Theme**: Breeze (installed via package list)
- **Icon Theme**: Breeze Dark (installed via package list)
- **KDE Theme**: Breeze Dark
- **Wallpapers**: Stored in `wallpapers/` directory, copied to `~/Pictures/` during installation

## Package Lists

- `pkglist.txt`: Official repository packages
- `aur-pkglist.txt`: AUR packages

## Updating This Repository

To update the dotfiles repository with your latest configs:

```bash
cd ~/dotfiles

# Copy latest configs
cp -r ~/.config/* config/
cp ~/.bashrc bashrc
cp ~/.bash_profile bash_profile
cp ~/.gtkrc-2.0 gtkrc-2.0

# Copy wallpapers (if you added new ones)
cp ~/Pictures/*.{jpg,png,jpeg,webp} wallpapers/ 2>/dev/null

# Update package lists
pacman -Qqe > pkglist.txt
pacman -Qqm > aur-pkglist.txt

# Commit and push
git add .
git commit -m "Update dotfiles"
git push
```

## Notes

- Your existing `.config` directory will be backed up to `.config.backup.TIMESTAMP` before creating symlinks
- The installation script requires sudo privileges for package installation
- Some applications may require additional manual configuration after installation
- Review the package lists before installation to customize what gets installed

## Requirements

- Fresh Arch Linux installation
- Internet connection
- sudo privileges

## License

Feel free to use and modify these dotfiles for your own setup!
