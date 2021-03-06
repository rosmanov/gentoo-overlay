# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 python3_3 python3_4 )

#inherit qmake-utils python-single-r1 python-utils-r1 subversion
inherit eutils multibuild multilib python-r1 qmake-utils subversion

MY_PN="PythonQt"
MY_P="${MY_PN}${PV}"

DESCRIPTION="A dynamic Python binding for the Qt framework"
HOMEPAGE="http://pythonqt.sourceforge.net/"
SRC_URI=""
ESVN_REPO_URI="https://pythonqt.svn.sourceforge.net/svnroot/pythonqt/trunk"

LICENSE="LGPL-2.1"
SLOT="osmanov"
KEYWORDS=""
IUSE="+extensions"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/designer:5"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}"/${P}-lib_location.patch )
EPATCH_OPTS="--binary"


src_prepare() {
	subversion_src_prepare
	eqmake5 -recursive ${MY_PN}.pro
}

src_install() {
	emake DESTDIR="${D}" install

	insinto "/usr/include/PythonQt"
	doins ${S}/src/*.h || return ${?}
	dolib ${S}/lib/libPythonQt.so*

	if use extensions ; then
		insinto "/usr/include/PythonQt/extensions/PythonQt_QtAll"
		doins ${S}/extensions/PythonQt_QtAll/*.h || return ${?}
		dolib ${S}/lib/libPythonQt_QtAll.so*
	fi
}
