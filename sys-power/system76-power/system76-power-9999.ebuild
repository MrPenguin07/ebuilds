# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
"

inherit cargo git-r3 optfeature

DESCRIPTION="System76 Power Management"
HOMEPAGE="https://github.com/pop-os/system76-power"
SRC_URI="$(cargo_crate_uris ${CRATES})"
EGIT_REPO_URI="https://github.com/MrPenguin07/system76-power-openrc.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}
	sys-apps/dbus
	dev-lang/rust
	dev-libs/libusb
	sys-auth/polkit
"
BDEPEND=""

src_unpack(){
	x86_64-pc-linux-gnu-gcc -v
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_install(){
	default
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
