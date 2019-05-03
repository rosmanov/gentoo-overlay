# Copyright 2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_IN_SOURCE_BUILD=1

inherit cmake-utils

DESCRIPTION="WZ http server"
HOMEPAGE="https://github.com/qbcir/wz-httpd"
SRC_URI="https://github.com/qbcir/wz-httpd/archive/master.zip -> ${P}.zip"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86 ~amd64-fbsd"
IUSE=""

DEPEND="dev-libs/expat dev-libs/coda:waves sys-libs/glibc"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

S="${WORKDIR}/wz-httpd-master"

src_configure() {
	local mycmakeargs=(
		# Disable implicit ccache use
		-DCCACHE_FOUND=OFF
		-DSYSCONF_INSTALL_DIR="${EPREFIX}/etc"
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install

	# Move config sample from non-standard location /usr/etc/ to /etc/
	local wzconfig_file="wzconfig.xml.example"
	if [ -e "${ED}/usr/etc/${wzconfig_file}" ]; then
		mkdir -p "${ED}/etc/"
		mv "${ED}/usr/etc/${wzconfig_file}" "${ED}/etc/${wzconfig_file}"
		rmdir --ignore-fail-on-non-empty "${ED}/usr/etc"
	fi
}

src_test() {
	cmake-utils_src_make test
}
