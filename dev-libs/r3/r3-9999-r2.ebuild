# Copyright 2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools git-r3

DESCRIPTION="libr3 is a high-performance path dispatching library."
HOMEPAGE="https://github.com/c9s/r3"
#SRC_URI="https://github.com/c9s/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI=""
EGIT_REPO_URI="https://github.com/c9s/${PN}.git -> ${PN}"
EGIT_BRANCH="2.0"
EGIT_CHECKOUT_DIR="${WORKDIR}/${PN}-${EGIT_BRANCH}"

S="${WORKDIR}/r3-2.0"

LICENSE="MIT"
SLOT="2"
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
