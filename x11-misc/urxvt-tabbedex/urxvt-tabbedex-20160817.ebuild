# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="An extended version of rxvt-unicode's tabbed perl extension"
HOMEPAGE="https://github.com/mina86/urxvt-tabbedex"

MY_PN=${PN/urxvt-/}
MY_PV="089d0cb724eeb62fa8a5dfcb00ced7761e794149"
SRC_URI="https://github.com/mina86/urxvt-tabbedex/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	x11-terms/rxvt-unicode[perl]
"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/${PN}-${MY_PV}

src_install() {

	insinto /usr/$(get_libdir)/urxvt/perl
	doins ${MY_PN}

}

