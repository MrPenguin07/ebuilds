  <a href="https://github.com/MrPenguin07/ebuilds/">
    <img src="https://github.com/MrPenguin07/ebuilds/blob/master/site-logo.png" height="50px"/>
  </a>
  
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
