#!/bin/bash

# Définition des couleurs
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 DÉMARRAGE DE LA RESTAURATION DU SYSTÈME...${NC}"

# --- 1. Installation de YAY (Indispensable pour AUR) ---
if ! command -v yay &> /dev/null; then
    echo -e "${BLUE}📦 Installation de Yay (AUR Helper)...${NC}"
    sudo pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ..
    rm -rf yay
else
    echo -e "${GREEN}✅ Yay est déjà installé.${NC}"
fi

# --- 2. Installation de la base END-4 ---
echo -e "${BLUE}❓ Veux-tu installer la base 'End-4' (Hyprland setup) maintenant ? (o/n)${NC}"
read -p "C'est nécessaire si le PC est vide : " choice
if [[ "$choice" == "o" || "$choice" == "O" ]]; then
    echo -e "${BLUE}⬇️ Téléchargement et lancement de l'installateur End-4...${NC}"
    # Commande officielle d'installation de End-4
    bash <(curl -s https://raw.githubusercontent.com/end-4/dots-hyprland/main/install.sh)
    echo -e "${GREEN}✅ Base End-4 installée.${NC}"
fi

# --- 3. Installation de tes logiciels perso ---
echo -e "${BLUE}📦 Installation de tes paquets sauvegardés...${NC}"
if [ -f "packages_arch.txt" ]; then
    sudo pacman -S --needed - < packages_arch.txt
fi

if [ -f "packages_aur.txt" ]; then
    yay -S --needed - < packages_aur.txt
fi

# --- 4. Installation de Oh-My-Zsh ---
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo -e "${BLUE}🐚 Installation de Oh-My-Zsh...${NC}"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# --- 5. Restauration des fichiers de config (L'étape CRUCIALE) ---
echo -e "${BLUE}♻️ Écrasement des configurations par les tiennes...${NC}"

# Copie Zsh
cp .zshrc ~/.zshrc

# Copie Kitty
rm -rf ~/.config/kitty
cp -r .config/kitty ~/.config/

# Copie Hyprland (Attention, ça remplace la config End-4 par la tienne)
rm -rf ~/.config/hypr
cp -r .config/hypr ~/.config/

# Changement du shell par défaut en Zsh
sudo chsh -s $(which zsh) $USER

echo -e "${GREEN}✅ TERMINÉ ! Redémarre ton PC pour profiter de ta config.${NC}"
