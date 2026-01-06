#!/bin/bash

# --- CONFIGURATION ---
BACKUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR=$HOME
DATE=$(date +%Y-%m-%d-%H%M)

echo "🚀 Démarrage de la sauvegarde dans : $BACKUP_DIR"

# 1. Création de la structure
mkdir -p "$BACKUP_DIR/.config"

# 2. Copie des fichiers (Version "Miroir" propre)
echo "📦 Nettoyage et copie des fichiers..."

# Zsh
cp "$SOURCE_DIR/.zshrc" "$BACKUP_DIR/"

# Kitty (On supprime l'ancien dossier backup pour être sûr d'avoir une copie exacte)
rm -rf "$BACKUP_DIR/.config/kitty"
if [ -d "$SOURCE_DIR/.config/kitty" ]; then
    cp -r "$SOURCE_DIR/.config/kitty" "$BACKUP_DIR/.config/"
fi

# Hyprland (Idem, on nettoie avant de copier)
rm -rf "$BACKUP_DIR/.config/hypr"
if [ -d "$SOURCE_DIR/.config/hypr" ]; then
    cp -r "$SOURCE_DIR/.config/hypr" "$BACKUP_DIR/.config/"
fi

# 3. Liste des logiciels
echo "📝 Export de la liste des paquets..."
pacman -Qqe > "$BACKUP_DIR/packages_arch.txt"
pacman -Qqm > "$BACKUP_DIR/packages_aur.txt"

# 4. Git (Automatique)
echo "octocat: Envoi vers GitHub..."
cd "$BACKUP_DIR"

# On ajoute tout (y compris les suppressions)
git add .
git commit -m "Backup automatique du $DATE"

echo "✅ Sauvegarde terminée et envoyée sur GitHub !"
