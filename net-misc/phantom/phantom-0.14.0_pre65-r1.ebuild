# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="I/O engine with some modules"
HOMEPAGE="https://github.com/yandex-load/phantom"
GIT_SHA1="f703e51"
SRC_URI="https://github.com/yandex-load/phantom/tarball/${GIT_SHA1} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/yandex-load-${PN}-${GIT_SHA1}"

src_compile() {
	emake -R CXX="$(tc-getCXX)" || die "Make failed!"
}

src_install() {
	mkdir -p ${D}/usr/lib
	mkdir -p ${D}/usr/bin 
	cp -a ${S}/lib/* ${D}/usr/lib/
	cp -a ${S}/bin/phantom ${D}/usr/bin/phantom
}
