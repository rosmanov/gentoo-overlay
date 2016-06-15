# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

MY_P="PF_RING-${PV}"
LIBPCAP_VER="1.7.4"

DESCRIPTION="Libraries for PF_RING kernel module."
HOMEPAGE="http://www.ntop.org/products/pf_ring/"
SRC_URI="mirror://sourceforge/ntop/PF_RING/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE="+pcap +static-libs +redis +rdi"
DEPEND="
	=sys-kernel/pf_ring-kmod-${PV}
	pcap? (
		~net-libs/libpcap-${LIBPCAP_VER}:pfring=
	)
	redis? ( dev-db/redis )
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_configure() {
	cd userland/lib
	econf \
		$(use_enable redis) \
		$(use_enable rdi)
	cd -
}

src_compile() {
	cd userland/lib
	emake
	cd -
}

src_install() {
	cd userland/lib
	default
	# remove static libraries (--disable-static does not work)
	if ! use static-libs ; then
		find "${ED}" -name '*.a' -exec rm {} + || die
	fi
	prune_libtool_files
	cd -
}
