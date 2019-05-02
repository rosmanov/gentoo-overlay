# Copyright 2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_IN_SOURCE_BUILD=1

inherit cmake-utils

DESCRIPTION="Library to catch mysql binlog updates online in your application."
HOMEPAGE="https://github.com/qbcir/mysqlslave"
SRC_URI="https://github.com/qbcir/mysqlslave/archive/master.zip -> ${P}.zip"

LICENSE="|| ( Public Domain MIT )"
SLOT="waves"
KEYWORDS="~amd64 ~arm ~arm64 ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86 ~amd64-fbsd"
IUSE="test +static"

DEPEND="virtual/libmysqlclient >=dev-db/mysql-connector-c-6.1.11-r999[static-libs]"
BDEPEND="${DEPEND}"
RDEPEND="${DEPEND}"

S="${WORKDIR}/mysqlslave-master"

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
