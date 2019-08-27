# Copyright 2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="libr3 is a high-performance path dispatching library."
HOMEPAGE="https://github.com/c9s/${PN}"
SRC_URI="https://github.com/c9s/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="-jemalloc -test"

DEPEND="sys-libs/glibc
	jemalloc? ( dev-libs/jemalloc )
	"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	default
	econf $(use_with jemalloc) \
		$(use_enable test check)
}

src_test() {
	default
	emake check
}
