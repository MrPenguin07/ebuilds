# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo git-r3 optfeature

DESCRIPTION="System76 Power Management"
HOMEPAGE="https://github.com/pop-os/system76-power"
EGIT_REPO_URI="https://github.com/MrPenguin07/system76-power-openrc.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

DEPEND=""
RDEPEND="${DEPEND}
	sys-apps/openrc
	sys-apps/dbus
	dev-libs/libusb
	sys-auth/polkit
"
BDEPEND="virtual/rust"

src_unpack(){
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_install() {
    # Install config and other files
    install -D -m 0644 "data/com.system76.PowerDaemon.conf" "${D}/usr/share/dbus-1/system.d/com.system76.PowerDaemon.conf"
    install -D -m 0644 "data/com.system76.PowerDaemon.policy" "${D}/usr/share/polkit-1/actions/com.system76.PowerDaemon.policy"
    install -D -m 0644 "data/com.system76.PowerDaemon.xml" "${D}/usr/share/dbus-1/interfaces/com.system76.PowerDaemon.xml"

    # Install the binary
    dobin target/x86_64-unknown-linux-gnu/release/system76-power

    # Install documentation
    dodoc README.md

    # Install the init script
    doinitd "data/system76-power"
}

pkg_postinst() {
	optfeature_header "There are several packages that may be useful with system76-power-openrc:"
	optfeature "Provides in-tree driver for systems missing it" app-laptop/system76-acpi-module
	optfeature "Controls hotkeys & custom fan control" app-laptop/system76-module
	optfeature "DKMS module for controlling IO board" app-laptop/system76-io-module
	optfeature "Universal driver" sys-apps/system76-driver
	echo
	einfo "Please note that some of these are only avail. in the 'khoverlay' repo"
}
