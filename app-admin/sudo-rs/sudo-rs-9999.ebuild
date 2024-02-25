EAPI=8

CRATES="
"

inherit cargo git-r3 optfeature

DESCRIPTION="A memory safe implementation of sudo and su"
HOMEPAGE="https://www.memorysafety.org/"
SRC_URI="$(cargo_crate_uris ${CRATES})"
EGIT_REPO_URI="https://github.com/memorysafety/sudo-rs"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
"
       # Add blocking app-admin/sudo at later date
       # !app-admin/sudo

RDEPEND="${DEPEND}
        >=sys-kernel/gentoo-sources-5.9.0
        sys-apps/dbus
        sys-libs/pam
"
BDEPEND="
        dev-lang/rust
"

src_unpack(){
        x86_64-pc-linux-gnu-gcc -v
        git-r3_src_unpack
        cargo_live_src_unpack
}

src_install(){
        exeinto /usr/bin
        exeopts -m4755
        newexe "target/release/sudo" sudo-rs
        # Change newexe to dobin when DEPEND !app-admin/sudo
        # dobin target/release/sudo
}

pkg_postinst() {
        ewarn "*******************"
        einfo "Sudo-rs needs the sudoers configuration file."
        einfo "The sudoers configuration file will be loaded from /etc/sudoers-rs if that file exists,"
        einfo "otherwise the original /etc/sudoers location will be used."
}
