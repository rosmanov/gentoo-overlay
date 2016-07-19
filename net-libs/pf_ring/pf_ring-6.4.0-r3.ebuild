# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit flag-o-matic eutils 


MY_P="PF_RING-${PV}"
LIBPCAP_VER="1.7.4"

DESCRIPTION="Libraries for PF_RING kernel module."
HOMEPAGE="http://www.ntop.org/products/pf_ring/"
SRC_URI="mirror://sourceforge/ntop/PF_RING/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE="+pcap +static-libs +redis +rdi debug"
DEPEND="
	redis? ( dev-db/redis )
"
RDEPEND="
	pcap? (
		~net-libs/libpcap-${LIBPCAP_VER}:pfring=
	)
  =sys-kernel/pf_ring-kmod-${PV}
  ${DEPEND}
"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	use debug && sed -i -e 's%^\s*//\s*#define *RING_DEBUG%#define RING_DEBUG%g' userland/lib/pfring.c
	use debug && sed -i -e 's%^\s*//\s*#define *RING_DEBUG%#define RING_DEBUG%g' userland/lib/pfring_mod.c
}

src_configure() {
	cd userland/lib
	use debug && append-cppflags "-DRING_DEBUG=1"
	econf \
		$(use_enable redis) \
		$(use_enable rdi)
	cd -
}

src_compile() {
	cd userland/lib
	use debug && append-cppflags "-DRING_DEBUG=1"
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
