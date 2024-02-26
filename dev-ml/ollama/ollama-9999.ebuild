EAPI=8

inherit git-r3 go-module

DESCRIPTION="Get up and running with Llama 2, Mistral, Gemma, and other large language models."
HOMEPAGE="https://ollama.com"
EGIT_REPO_URI="https://github.com/ollama/ollama.git"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="nvidia amd"

BDEPEND="
    >=dev-lang/go-1.21.0
    >=dev-build/cmake-3.24
    >=sys-devel/gcc-11.4.0
    nvidia? ( dev-util/nvidia-cuda-toolkit )
    amd? (
        sci-libs/clblast
        dev-libs/rocm-opencl-runtime
    )
"

DEPEND="${BDEPEND}"

pkg_pretend() {
    if use amd; then
        ewarn "WARNING: AMD & Nvidia support in this ebuild are experimental"
        einfo "If you run into issues, especially compiling dev-libs/rocm-opencl-runtime"
        einfo "you may try the docker image here https://github.com/ROCm/ROCm-docker"
        einfo "and follow instructions here https://rocm.docs.amd.com/projects/install-on-linux/en/latest/how-to/docker.html"
    fi
}

src_unpack() {
        if [[ ${PV} == *9999* ]]; then
                git-r3_src_unpack
                go-module_live_vendor
        else
                go-module_src_unpack
        fi
}

src_compile() {
    ego generate ./...
    ego build .
}

src_install() {
    dobin ollama
}
