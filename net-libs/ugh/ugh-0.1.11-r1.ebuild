# Copyright 2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_IN_SOURCE_BUILD=1

inherit cmake-utils

DESCRIPTION="WZ http server"
HOMEPAGE="https://github.com/bachan/${PN}"
SRC_URI="https://github.com/bachan/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86 ~amd64-fbsd"
IUSE="examples"

DEPEND="dev-libs/libev
	dev-libs/judy
	sys-libs/glibc"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

#S="${WORKDIR}/${P}"

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
	local config_file="ugh.cfg"
	if [ -e "${ED}/usr/etc/ugh.cfg" ]; then
		echo "Moving " "${ED}/usr/etc/ugh.cfg" to "${ED}/etc/ugh.cfg"
		mkdir -p "${ED}/etc/"
		mv "${ED}/usr/etc/ugh.cfg" "${ED}/etc/ugh.cfg"
	fi
	if use examples; then
		echo "Moving " "${ED}/usr/etc/ugh_example/config.cfg" to "${ED}/etc/ugh_example/config.cfg"
		mv "${ED}/usr/etc/ugh_example/config.cfg" "${ED}/etc/ugh_example/config.cfg"
	else
		echo Removing "${ED}/usr/etc/ugh_example/"
		rm -rf "${ED}/usr/etc/ugh_example/"
	fi
	rmdir --ignore-fail-on-non-empty "${ED}/usr/etc"
}

src_test() {
	cmake-utils_src_make test
}
