  <a href="https://github.com/MrPenguin07/ebuilds/">
    <img src="https://github.com/MrPenguin07/ebuilds/blob/master/site-logo.png" height="50px"/>
  </a>

<details>
<summary><h3>List of ebuilds in this overlay</h3></summary>
- <a href="https://github.com/MrPenguin07/ebuilds/tree/master/gui-wm/swayfx">gui-wm/swayfx-9999</a>   
<br>
- <a href="https://github.com/MrPenguin07/ebuilds/tree/master/media-gfx/upscayl-bin">media-gfx/upscayl-bin</a>
<br>
- <a href="https://github.com/MrPenguin07/ebuilds/tree/master/sys-power/system76-power-openrc">sys-power/system76-power-openrc-9999</a>
</details>

## MrPenguin's ebuild overlay

### Adding this repo as a Gentoo Overlay

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/MrPenguin07/ebuilds.git /usr/local/portage/mrpenguin
   ```

2. **Create or Update repos.conf:**

    Add to your repos.conf file, or create one in `/etc/portage/repos.conf/mrpenguin.conf`    
    Add the following configuration:

    ```
    [mrpenguin]
    location = /usr/local/portage/mrpenguin
    sync-type = git
    sync-uri = https://github.com/MrPenguin07/ebuilds.git
    auto-sync = yes
    ```

4. Sync the Overlay:

    ```bash
    emerge --sync mrpenguin
    ```

5. Emerge Packages:
    You can now install packages from the overlay using emerge as usual.

6. Update the Overlay:
   
    `auto-sync = yes` should keep the overlay in sync, or can be done manually;

    ```bash
    emaint sync -r mrpenguin
    ```
