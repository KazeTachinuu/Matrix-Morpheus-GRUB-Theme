# Matrix Morpheus GRUB Theme
**Red Pill vs Blue Pill**

A minimalist Matrix-inspired GRUB theme featuring full-screen dynamic backgrounds that change between Linux and Windows.

Based on the original theme by [Priyank-Adhav](https://github.com/Priyank-Adhav/Matrix-Morpheus-GRUB-Theme).

**Note:** The theme currently includes only the **Arch Linux** and **Windows** icons. The icons are arranged horizontally on screen, but you still navigate with the **Up** and **Down arrow keys** as in a normal GRUB menu.

![Matrix Morpheus GRUB Theme preview showing Arch and Windows boot icons](preview.gif)

## Installation

```shell
git clone https://github.com/KazeTachinuu/Matrix-Morpheus-GRUB-Theme
cd Matrix-Morpheus-GRUB-Theme
chmod +x install.sh
sudo ./install.sh
```

Reboot to test your new theme.

## Installation for Bazzite / Fedora Atomic

Bazzite and other Fedora Atomic distributions (Silverblue, Kinoite) use different GRUB paths, so use the dedicated installer. Requires Bazzite 41.20241229 or later (earlier versions may lack `/etc/default/grub`).

```shell
git clone https://github.com/KazeTachinuu/Matrix-Morpheus-GRUB-Theme
cd Matrix-Morpheus-GRUB-Theme
chmod +x install-bazzite.sh
sudo ./install-bazzite.sh
```

Reboot to test your new theme.

### Bazzite troubleshooting

- With Secure Boot enabled, enroll the Universal Blue key first: `ujust enroll-secure-boot-key`, then confirm **Enroll MOK** at boot. The documented password is `universalblue`.
- If the theme does not appear, regenerate GRUB with `ujust regenerate-grub`.
- Verify the install: `ls /boot/grub2/themes/Matrix/` and check that `/etc/default/grub` contains `GRUB_TERMINAL_OUTPUT="gfxterm"` and `GRUB_THEME="/boot/grub2/themes/Matrix/theme.txt"`.
- If `/etc/default/grub` does not exist, `sudo touch /etc/default/grub` and run the installer again.

## Optional: simplify your GRUB menu

The theme is designed for a two-entry layout. If your GRUB menu has extra entries (such as "Advanced options" or "UEFI Firmware Settings") that you do not use, consider removing them from your GRUB config.
