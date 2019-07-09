# Copyright 2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

CMAKE_IN_SOURCE_BUILD=1

inherit cmake-utils git-r3

DESCRIPTION="C library for working with Waves"
HOMEPAGE="https://github.com/qbcir/waves-c"
SRC_URI=""
EGIT_REPO_URI="https://github.com/qbcir/${PN}.git -> ${PN}"
EGIT_BRANCH="master"
EGIT_CHECKOUT_DIR="${WORKDIR}/${PN}-${EGIT_BRANCH}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86 ~amd64-fbsd"
IUSE="test +static"

DEPEND="dev-libs/openssl"
BDEPEND="dev-libs/openssl"
RDEPEND="${DEPEND}"

S="${WORKDIR}/waves-c-master"

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DBUILD_STATIC_LIBS="$(usex static)"
		# Follow Debian, Ubuntu, Arch convention for headers location
		-DCMAKE_INSTALL_INCLUDEDIR=include/waves
		# Disable implicit ccache use
		-DCCACHE_FOUND=OFF
	)
	cmake-utils_src_configure

	use test || rm -v -f "${S}/CTestTestfile.cmake"
}

src_compile() {
	cmake-utils_src_compile
}

src_test() {
	cmake-utils_src_make test
}
