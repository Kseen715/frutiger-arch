info "Installing hyprland..."
# check if hyprland is not already installed
if ! command -v hyprctl &>/dev/null; then
    trace rm /usr/share/wayland-sessions/hyprland.desktop
fi
trace pacman -S --needed --noconfirm hyprland hyprshot xdg-desktop-portal-hyprland
info "Installing hyprland dotfiles..."
trace sudo -u "$DELEVATED_USER" mkdir -p /home/$DELEVATED_USER/.config
trace chmod 775 /home/$DELEVATED_USER/.config
trace chown "$DELEVATED_USER":"$DELEVATED_USER" /home/$DELEVATED_USER/.config
trace sudo -u "$DELEVATED_USER" mkdir -p /home/$DELEVATED_USER/.config/hypr
trace chmod 775 /home/$DELEVATED_USER/.config/hypr
trace chown "$DELEVATED_USER":"$DELEVATED_USER" /home/$DELEVATED_USER/.config/hypr
trace mkdir -p /home/$DELEVATED_USER/Downloads
trace chmod 775 /home/$DELEVATED_USER/Downloads
trace chown "$DELEVATED_USER":"$DELEVATED_USER" /home/$DELEVATED_USER/Downloads
trace mkdir -p /home/$DELEVATED_USER/Pictures
trace chmod 775 /home/$DELEVATED_USER/Pictures
trace chown "$DELEVATED_USER":"$DELEVATED_USER" /home/$DELEVATED_USER/Pictures
trace cp config/hypr/hyprland.conf /home/$DELEVATED_USER/.config/hypr/

# Start of easyeffects
trace cp config/hypr/start-easyeffects.sh /home/$DELEVATED_USER/.config/hypr/start-easyeffects.sh
trace chmod +x /home/$DELEVATED_USER/.config/hypr/start-easyeffects.sh
trace chown "$DELEVATED_USER":"$DELEVATED_USER" /home/$DELEVATED_USER/.config/hypr/start-easyeffects.sh

# Start of cliphist
trace cp config/hypr/start-cliphist-store.sh /home/$DELEVATED_USER/.config/hypr/start-cliphist-store.sh
trace chmod +x /home/$DELEVATED_USER/.config/hypr/start-cliphist-store.sh
trace chown "$DELEVATED_USER":"$DELEVATED_USER" /home/$DELEVATED_USER/.config/hypr/start-cliphist-store.sh
info "Checking if Golang installed..."
if ! command -v go &>/dev/null; then
    info "Golang not found. Installing Golang..."
    trace pacman -S --needed --noconfirm go
else
    info "Golang is installed"
fi
trace go install github.com/pdf/cliphist-wofi-img@latest
trace wget https://raw.githubusercontent.com/sentriz/cliphist/refs/heads/master/contrib/cliphist-wofi-img -O /usr/local/bin/cliphist-wofi-img
trace chmod +x /usr/local/bin/cliphist-wofi-img
trace chown "$DELEVATED_USER":"$DELEVATED_USER" /usr/local/bin/cliphist-wofi-img

trace cp config/wayland-sessions/hyprland.desktop /usr/share/wayland-sessions/hyprland.desktop
if [ "$VIRT" = "vmware" ]; then
    trace cp config/wayland-sessions/hyprland-vmware.desktop /usr/share/wayland-sessions/hyprland-vmware.desktop
    trace cp config/wayland-sessions/start-hyprland-vmware.sh /usr/share/wayland-sessions/start-hyprland-vmware.sh
    trace chmod +x /usr/share/wayland-sessions/start-hyprland-vmware.sh
    # Give execute permissions to the delevated user, so sddm can run it
    trace chown "$DELEVATED_USER":"$DELEVATED_USER" /usr/share/wayland-sessions/start-hyprland-vmware.sh
fi