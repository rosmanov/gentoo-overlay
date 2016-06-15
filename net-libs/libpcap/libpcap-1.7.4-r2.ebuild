# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

PF_RING_VER="6.4.0"
MY_P="PF_RING-${PF_RING_VER}"

DESCRIPTION="PF_RING-capable libpcap library"
HOMEPAGE="http://www.ntop.org/products/pf_ring/"
SRC_URI="mirror://sourceforge/ntop/PF_RING/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="pfring"

KEYWORDS="~amd64 ~x86"
IUSE="+bluetooth +usb +dbus +ipv6 +static-libs +redis +rdi"
DEPEND="
	=sys-kernel/pf_ring-kmod-${PF_RING_VER}
	!net-libs/libpcap:0
	bluetooth? ( net-wireless/bluez )
	dbus? ( sys-apps/dbus )
	~net-libs/pf_ring-${PF_RING_VER}[redis?,rdi?]
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	cd userland/libpcap
	mkdir -p bluetooth || die
	cp "${FILESDIR}"/mgmt.h bluetooth/ || die
	cd -
}

src_configure() {
	cd userland/lib
	econf \
		$(use_enable redis) \
		$(use_enable rdi)
	cd -

	cd userland/libpcap
	econf \
		$(use_enable bluetooth) \
		$(use_enable usb) \
		$(use_enable dbus) \
		$(use_enable ipv6)
	cd -
}

src_compile() {
	cd userland/lib
	emake
	cd -

	cd userland/libpcap
	default
	cd -
}

src_install() {
	cd userland/libpcap
	default
	# remove static libraries (--disable-static does not work)
	if ! use static-libs ; then
		find "${ED}" -name '*.a' -exec rm {} + || die
	fi
	prune_libtool_files
	cd -
}
