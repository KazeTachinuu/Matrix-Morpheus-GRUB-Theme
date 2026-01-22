# Matrix Morpheus GRUB Theme
**Red Pill vs Blue Pill**

A minimalist Matrix-inspired GRUB theme featuring full-screen dynamic backgrounds that change between Linux and Windows.

---

**Note:**  
Currently, the theme only includes the **Arch Linux** and **Windows** icons.  
 
Also, while the icons are **arranged horizontally** on screen,  
you still navigate using the **Up** and **Down arrow keys** as in a normal GRUB menu.

---
![Matrix Morpheus GRUB Theme preview showing Arch and Windows boot icons](preview.gif)
## Installation

1. Clone the repo

```shell
git clone https://github.com/Priyank-Adhav/Matrix-Morpheus-GRUB-Theme
```

2. Go into the folder 

```shell
cd Matrix-Morpheus-GRUB-Theme
```

3. Make the installer executable

```shell
chmod +x install.sh
```

4. Execute the installation script as admin

```shell
sudo ./install.sh
```

5. Reboot to test your new theme

---

## Installation for Bazzite / Fedora Atomic

Bazzite and other Fedora Atomic distributions (Silverblue, Kinoite) use different GRUB paths and require additional configuration.

### Prerequisites

1. **Bazzite version**: Ensure you're running Bazzite 41.20241229 or later (fixes `/etc/default/grub` issue)
2. **Secure Boot**: If enabled, you may need to enroll keys first (see Secure Boot section below)

### Installation Steps

1. Clone the repo and enter the directory:
```shell
git clone https://github.com/Priyank-Adhav/Matrix-Morpheus-GRUB-Theme
cd Matrix-Morpheus-GRUB-Theme
```

2. Make the Bazzite installer executable:
```shell
chmod +x install-bazzite.sh
```

3. Run the Bazzite-specific installer:
```shell
sudo ./install-bazzite.sh
```

4. Reboot to test your new theme

### Secure Boot (Lenovo & Other Systems)

If Secure Boot is enabled on your Lenovo (or other) system:

1. **Disable Secure Boot** in BIOS before installing Bazzite
2. After Bazzite installation, enroll the key:
   ```shell
   ujust enroll-secure-boot-key
   ```
   Password: `universalblue`
3. Re-enable Secure Boot in BIOS:
   ```shell
   ujust bios
   ```
4. At boot, select **Enroll MOK** and enter password: `universalblue`

### Troubleshooting Bazzite

If the theme doesn't appear after reboot:

1. Regenerate GRUB:
   ```shell
   ujust regenerate-grub
   ```

2. Verify theme is installed:
   ```shell
   ls /boot/grub2/themes/Matrix/
   ```

3. Check GRUB configuration:
   ```shell
   cat /etc/default/grub | grep -E "THEME|TERMINAL"
   ```
   You should see:
   ```
   GRUB_TERMINAL_OUTPUT="gfxterm"
   GRUB_THEME="/boot/grub2/themes/Matrix/theme.txt"
   ```

4. If `/etc/default/grub` doesn't exist, create it:
   ```shell
   sudo touch /etc/default/grub
   ```
   Then run the installer again.

---

Optional: Simplify Your GRUB Menu

I designed this theme for a two entry layout and haven't really thought about how to visually handle the additional entries. 

If your GRUB menu currently has extra entries such as:

- “Advanced options for Arch Linux”
- “UEFI Firmware Settings”

I would recommend you remove the extra menu entries from the grub config if you don't use them.