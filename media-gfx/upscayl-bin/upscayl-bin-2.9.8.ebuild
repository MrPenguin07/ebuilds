EAPI=8
DESCRIPTION="Free and Open Source AI Image Upscaler for Linux, MacOS, and Windows"
HOMEPAGE="https://github.com/upscayl/upscayl"
SRC_URI="https://github.com/upscayl/upscayl/releases/download/v${PV}/upscayl-${PV}-linux.deb"
LICENSE="AGPL-3.0"
SLOT="0"
KEYWORDS="~amd64"

IUSE=""

DEPEND="
    sys-apps/coreutils
    app-arch/tar
"

RDEPEND="
    !<media-gfx/upscayl-bin-${PV}
    sys-apps/coreutils
    app-arch/tar
    net-libs/nodejs
    dev-libs/nss
    media-libs/openjpeg
    media-libs/vips
    x11-libs/gtk+
"

S="${WORKDIR}"

src_unpack() {
    unpack ${A}
    ar x "${DISTDIR}/upscayl-${PV}-linux.deb"
    tar -xJpf data.tar.xz -C "${S}"
}

src_install() {
    insinto /opt
    cp -r "${S}"/opt/* "${D}/opt/"

    insinto /usr/share/doc/upscayl-bin-${PV}
    gunzip "${S}/usr/share/doc/upscayl/changelog.gz"
    doins "${S}/usr/share/doc/upscayl/changelog"
    rm -r "${S}/usr/share/doc/upscayl"

    insinto /usr
    doins -r "${S}"/usr/*
    exeinto /usr/bin
    newexe "${S}/opt/Upscayl/resources/bin/upscayl-bin" upscayl-cli
}
