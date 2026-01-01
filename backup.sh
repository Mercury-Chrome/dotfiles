#!/bin/bash

# --- CONFIGURATION ---
# Le dossier de sauvegarde est le dossier où se trouve ce script
BACKUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR=$HOME
DATE=$(date +%Y-%m-%d-%H%M)

echo "🚀 Démarrage de la sauvegarde dans : $BACKUP_DIR"

# 1. Création de la structure locale
mkdir -p "$BACKUP_DIR/.config"

# 2. Copie des fichiers critiques
echo "📦 Copie des fichiers de configuration..."

# Zsh
cp "$SOURCE_DIR/.zshrc" "$BACKUP_DIR/"

# Kitty
if [ -d "$SOURCE_DIR/.config/kitty" ]; then
    cp -r "$SOURCE_DIR/.config/kitty" "$BACKUP_DIR/.config/"
fi

# Hyprland
if [ -d "$SOURCE_DIR/.config/hypr" ]; then
    cp -r "$SOURCE_DIR/.config/hypr" "$BACKUP_DIR/.config/"
fi

# 3. Liste des logiciels
echo "📝 Export de la liste des paquets..."
pacman -Qqe > "$BACKUP_DIR/packages_arch.txt"
pacman -Qqm > "$BACKUP_DIR/packages_aur.txt"

# 4. Git (Automatique)
echo "octocat: Préparation de l'envoi..."
cd "$BACKUP_DIR"

# On ajoute tout ce qu'on vient de copier
git add .
git commit -m "Backup du $DATE"

echo "✅ Sauvegarde terminée !"
