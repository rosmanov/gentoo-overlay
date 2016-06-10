# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

MY_P="PF_RING-${PV}"

DESCRIPTION="Libraries for PF_RING kernel module."
HOMEPAGE="http://www.ntop.org/products/pf_ring/"
SRC_URI="mirror://sourceforge/ntop/PF_RING/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE="+pcap +bluetooth +usb +dbus +static-libs +ipv6 +redis +rdi"
DEPEND="
	=sys-kernel/pf_ring-kmod-${PV}
	pcap? (
		!net-libs/libpcap
		bluetooth? ( net-wireless/bluez )
		dbus? ( sys-apps/dbus )
	)
	redis? ( dev-db/redis )
"
RDEPEND="${DEPEND}"
REQUIRED_USE="
	pcap? ( || ( bluetooth usb dbus ) )
"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	if use pcap ; then
		cd userland/libpcap
		mkdir -p bluetooth || die
		cp "${FILESDIR}"/mgmt.h bluetooth/ || die
		cd -
	fi
}

src_configure() {
	cd userland/lib
	econf \
		$(use_enable redis) \
		$(use_enable rdi)
	cd -

	if use pcap ; then
		cd userland/libpcap
		econf \
			$(use_enable bluetooth) \
			$(use_enable usb) \
			$(use_enable dbus) \
			$(use_enable ipv6)
		cd -
	fi
}

src_compile() {
	cd userland/lib
	emake
	cd -

	if use pcap ; then
		cd userland/libpcap
		default
		cd -
	fi
}

src_install() {
	cd userland/lib
	if use static-libs ; then
		emake DESTDIR="${D}" install-static
	fi
	emake DESTDIR="${D}" install-shared
	cd -

	if use pcap ; then
		cd userland/libpcap

		if use static-libs; then
			emake DESTDIR="${D}" install-archive || \
				die "emake install-archive failed"
		fi
		emake DESTDIR="${D}" install-shared || \
			die "emake install-shared failed"
		cd -
	fi
}
