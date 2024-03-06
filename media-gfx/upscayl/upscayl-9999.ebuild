EAPI=8

inherit git-r3

DESCRIPTION="Free and Open Source AI Image Upscaler for Linux, MacOS, and Windows"
HOMEPAGE="https://github.com/upscayl/upscayl"
EGIT_REPO_URI="https://github.com/upscayl/upscayl.git"
SRC_URI="custom-models? ( mirror+https://github.com/upscayl/custom-models/archive/refs/heads/main.zip -> custom-models.zip )"
RESTRICT="mirror network-sandbox"
LICENSE="AGPL-3.0"
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
    net-libs/nodejs
    custom-models? ( app-arch/unzip )
"

RDEPEND="
    !media-gfx/upscayl-bin
    net-libs/nodejs
    dev-libs/nss
    media-libs/openjpeg
    media-libs/vips
    x11-libs/gtk+
"

#S="${WORKDIR}"

src_unpack() {
    if [[ ${PV} == 9999 ]] ; then
        git-r3_src_unpack
        return
    fi
}

src_compile() {
    npm install || die "npm dependency installation failed"
    npx next telemetry disable && npm run dist:deb
}

src_install() {
    # Extract the .deb file
    deb_file=$(find "${S}/dist/" -maxdepth 1 -type f -name 'upscayl-*.deb' -print -quit)
    [[ -n ${deb_file} ]] || die "Failed to find .deb file"

    ar x "${deb_file}" || die "Failed to extract .deb file"
    tar -xJpf data.tar.xz -C "${S}" || die "Failed to extract tar file"

    if use custom-models; then
        unzip -nj -d "${S}"/opt/Upscayl/resources/models "${DISTDIR}"/custom-models.zip || die "Failed to extract models zip file"
    fi

    insinto /opt
    cp -r "${S}"/opt/* "${D}/opt/" || die "Failed to install to /opt"

    insinto /usr/share/doc/upscayl-${PV}
    gunzip "${S}/usr/share/doc/upscayl/changelog.gz" || die "Failed to gunzip changelog"
    doins "${S}/usr/share/doc/upscayl/changelog"
    rm -r "${S}/usr/share/doc/upscayl" || die "Failed to remove temp dir"

    insinto /usr
    doins -r "${S}"/usr/*
    exeinto /usr/bin
    newexe "${S}/opt/Upscayl/resources/bin/upscayl-bin" upscayl-cli
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
