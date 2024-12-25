EAPI=8
DESCRIPTION="Free and Open Source AI Image Upscaler for Linux, MacOS, and Windows"
HOMEPAGE="https://github.com/upscayl/upscayl"
SRC_URI="https://github.com/upscayl/upscayl/releases/download/v${PV}/upscayl-${PV}-linux.deb
    custom-models? ( mirror+https://github.com/upscayl/custom-models/archive/refs/heads/main.zip -> custom-models.zip )"
LICENSE="AGPL-3"
RESTRICT="mirror"
SLOT="0"
KEYWORDS="~amd64"
QA_PRESTRIPPED="opt/Upscayl/.*"

IUSE="custom-models"

pkg_pretend() {
    if use custom-models; then
        ewarn "WARNING: Custom-models are ~300MB in size. This will be fetched and included in the installation."
        einfo "Fetching custom-models.zip...."
    fi
}

DEPEND="
    sys-apps/coreutils
    app-arch/tar
    custom-models? ( app-arch/unzip )
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
    ar x "${DISTDIR}/upscayl-${PV}-linux.deb" || die "Failed to extract .deb file"
    tar -xJpf data.tar.xz -C "${S}" || die "Failed to extract tar file"
    if use custom-models; then
        unzip -nj -d "${S}"/opt/Upscayl/resources/models "${DISTDIR}"/custom-models.zip || die "Failed to extract models zip file"
    fi
}

src_install() {
    insinto /opt
    cp -r "${S}"/opt/* "${D}/opt/" || die "Failed to install to /opt"

    insinto /usr/share/doc/upscayl-bin-${PV}
    gunzip "${S}/usr/share/doc/upscayl/changelog.gz" || die "Failed to gunzip changelog"
    doins "${S}/usr/share/doc/upscayl/changelog"
    rm -r "${S}/usr/share/doc/upscayl" || die "Failed to remove temp dir"

    insinto /usr
    doins -r "${S}"/usr/*
    exeinto /usr/bin
    newexe "${S}/opt/Upscayl/resources/bin/upscayl-bin" upscayl-cli
    dosym "${D}/opt/Upscayl/resources/models" /usr/bin/models
    dosym ../Upscayl/${PN} /opt/bin/${PN}
}

pkg_postinst() {
    if use custom-models; then
        ewarn "!!!!!!!!!!!!!!!!!!!!!!"
        einfo "NOTICE: 'Custom Model Path' needs to be set."
        einfo "Settings -> Add custom models"
        einfo "Set to '/opt/Upscayl/resources/models'"
    fi
    ewarn "**********************"
    einfo "A CLI binary named 'upscayl-cli' is available"
    einfo "See 'upscayl-cli -h' for usage."
}
