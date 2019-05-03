# Copyright 2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7


inherit cmake-utils

DESCRIPTION="Blizzard http server"
HOMEPAGE="https://github.com/qbcir/blizzard"
SRC_URI="https://github.com/qbcir/blizzard/archive/master.zip -> ${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86 ~amd64-fbsd"
IUSE="examples static-libs"

DEPEND="dev-libs/libev[static-libs] sys-libs/glibc"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

S="${WORKDIR}/blizzard-master"

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		-DBUILD_STATIC_LIBS=ON
		# Follow Debian, Ubuntu, Arch convention for headers location
		-DCMAKE_INSTALL_INCLUDEDIR=include/blizzard
		# Disable implicit ccache use
		-DCCACHE_FOUND=OFF
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	if ! use static-libs ; then
		find "${ED}" -name "*.a" -delete || die
	fi

	# Move config samples from non-standard location /usr/etc/ to /etc/
	local config_files=( 'blizzard/config.xml' )
	if use examples; then
		config_files+=( 'blzmod_example/config.xml' 'blzmod_example/config_module.xml' )
		mv -vf "${ED}/usr/lib/libblzmod_example.so" "${ED}/usr/$(get_libdir)/libblzmod_example.so"
	else
		rm -rf "${ED}/usr/etc/blzmod_example"
		rm -f "${ED}/usr/lib/libblzmod_example.so"
	fi

	for f in "${config_files[@]}"; do
		if [ -e "${ED}/usr/etc/${f}" ]; then
			mkdir -p $(dirname "${ED}/etc/${f}")
			mv -v "${ED}/usr/etc/${f}" "${ED}/etc/${f}"
		fi
	done
	rmdir --ignore-fail-on-non-empty "${ED}/usr/etc"
}

src_compile() {
	cmake-utils_src_compile
}
