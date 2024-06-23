  <a href="https://github.com/MrPenguin07/ebuilds/">
    <img src="https://github.com/MrPenguin07/ebuilds/blob/master/site-logo.png" height="50px"/>
  </a>

### List of ebuilds in this overlay
<details>
- <a href="https://github.com/MrPenguin07/ebuilds/tree/master/app-admin/sudo-rs">app-admin/sudo-rs-9999</a>
<br>
- <a href="https://github.com/MrPenguin07/ebuilds/tree/master/dev-ml/ollama">dev-ml/ollama-9999</a>
<br>
- <a href="https://github.com/MrPenguin07/ebuilds/tree/master/gui-apps/swaync">gui-apps/swaync-9999</a>
<br>
- <a href="https://github.com/MrPenguin07/ebuilds/tree/master/gui-apps/wlogout">gui-apps/wlogout-9999</a>
<br>
- <a href="https://github.com/MrPenguin07/ebuilds/tree/master/gui-wm/swayfx">gui-wm/swayfx-9999</a>
<br>
- <a href="https://github.com/MrPenguin07/ebuilds/tree/master/media-plugins/scenefx">media-plugins/scenefx-9999</a>
<br>
- <a href="https://github.com/MrPenguin07/ebuilds/tree/master/media-gfx/upscayl-bin">media-gfx/upscayl-bin</a>
<br>
- <a href="https://github.com/MrPenguin07/ebuilds/tree/master/media-gfx/upscayl">media-gfx/upscayl-9999</a>
<br>
- <a href="https://github.com/MrPenguin07/ebuilds/tree/master/sys-power/system76-power-openrc">sys-power/system76-power-openrc-9999</a>
</details>

## MrPenguin's ebuild overlay

### Adding this repo as a Gentoo Overlay

#### Using [`eselect repository`](https://wiki.gentoo.org/wiki/Eselect/Repository#Add_repositories)
1. `emerge -av eselect-repository` (if required)
2. `eselect repository enable mrpenguin`
3. `emaint sync -r mrpenguin`

#### Manually

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
    
    `eix --in-overlay mrpenguin`  
    Will list available packages from this overlay.
    You can now install packages using emerge as usual.

---

#### Keyword the -9999 ebuilds:

Live 9999 ebuilds must be **keyworded** for portage to accept them,  
See the [Gentoo Live Ebuild Wiki](https://wiki.gentoo.org/wiki/Live_ebuilds) for information on managing keyworded ebuilds.

You can accept specific live ebuilds semi-automatically using emerge's option `--autounmask` in conjuction with `dispatch-conf u` or `etc-update`.
