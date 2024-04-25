EAPI=8

inherit git-r3 meson

DESCRIPTION="A drop-in replacement for the wlroots scene API that allows wayland compositors to render surfaces with eye-candy effects"
HOMEPAGE="https://github.com/wlrfx/scenefx"
EGIT_REPO_URI="https://github.com/wlrfx/${PN^}.git"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
    >=dev-libs/wayland-1.22
    >=gui-libs/wlroots-0.17.0
    <gui-libs/wlroots-0.18.0
    >=x11-libs/libdrm-2.4.114
    x11-libs/libxkbcommon
    >=x11-libs/pixman-0.42.0
"
RDEPEND="${DEPEND}"
BDEPEND="
    dev-build/meson
    dev-build/ninja
"

src_prepare() {
    default
}

src_configure() {
    local emesonargs=(
        "--prefix=/usr"
    )
    meson_src_configure
}
