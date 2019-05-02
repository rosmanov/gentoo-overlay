# Copyright 2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_IN_SOURCE_BUILD=1

inherit cmake-utils

DESCRIPTION="Aux library used in Waves Platform projects"
HOMEPAGE="https://github.com/qbcir/coda"
SRC_URI="https://github.com/qbcir/coda/archive/master.zip -> ${P}.zip"

LICENSE="|| ( public-domain MIT )"
SLOT="waves"
KEYWORDS="amd64 ~arm ~arm64 ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86 ~amd64-fbsd"
IUSE="+test"

DEPEND=""
RDEPEND=""
RESTRICT=""

S="${WORKDIR}/coda-master"
PATCHES=(
	"${FILESDIR}/coda-9999_url_parser_test.patch"
	"${FILESDIR}/coda-9999_string_hpp.patch"
	"${FILESDIR}/coda-9999_size_t.patch"
	"${FILESDIR}/coda-9999_easy_parsing.patch"
)

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		-DBUILD_STATIC_LIBS=ON
		# Follow Debian, Ubuntu, Arch convention for headers location
		-DCMAKE_INSTALL_INCLUDEDIR=include/coda
		# Disable implicit ccache use
		-DCCACHE_FOUND=OFF
	)

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_test() {
	cmake-utils_src_make test
}
