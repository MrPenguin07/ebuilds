# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson vala gnome2-utils git-r3

MY_PN="SwayNotificationCenter"
DESCRIPTION="A simple notification daemon with a GTK gui for notifications and control center"
HOMEPAGE="https://github.com/ErikReider/SwayNotificationCenter"
PN="swaync-9999"
#EGIT_REPO_URI="https://github.com/ErikReider/${MY_PN}.git"
EGIT_REPO_URI="https://github.com/MrPenguin07/${MY_PN}.git"
EGIT_BRANCH="mpris_blacklist"

LICENSE="GPL-3"
SLOT="0"
IUSE="+man scripting"

DEPEND="
    dev-libs/libgee
    dev-lang/sassc
    dev-libs/glib:2
    dev-libs/gobject-introspection
    dev-libs/json-glib
    dev-libs/granite
    media-libs/libpulse
    dev-libs/wayland
    gnome-base/gvfs
    >=gui-libs/gtk-layer-shell-0.8.0[introspection,vala]
    gui-libs/libhandy:1
    sys-apps/dbus
    x11-libs/gdk-pixbuf:2
    x11-libs/gtk+:3
"
RDEPEND="${DEPEND}"
BDEPEND="
    $(vala_depend)
    man? ( app-text/scdoc )
"

src_prepare() {
#    ! use pulseaudio && local PATCHES=( "${FILESDIR}"/${PF}-pulsefree.patch )
    default
    vala_setup
}

src_configure() {
    # Enable/disable scripting based on USE flag
    local emesonargs=(
        $(meson_use scripting)
    )
    meson_src_configure
}

pkg_postinst() {
    gnome2_schemas_update
}

pkg_postrm() {
    gnome2_schemas_update
}
