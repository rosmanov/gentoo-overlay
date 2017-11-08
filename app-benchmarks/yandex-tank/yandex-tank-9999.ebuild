# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_{6,7} )

inherit bash-completion-r1 python-r1

DESCRIPTION="Load and performance benchmark tool"
HOMEPAGE="http://clubs.ya.ru/yandex-tank/"
GIT_SHA1="21a4a29"
SRC_URI="https://github.com/yandex-load/yandex-tank/tarball/${GIT_SHA1} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="bash-completion jmeter mysql postgres"

RDEPEND="${PYTHON_DEPS}
	dev-python/progressbar
	dev-python/psutil
	dev-python/ipaddr
	dev-python/lxml
	jmeter? ( app-benchmarks/jmeter )
	mysql? ( dev-python/sqlalchemy[mysql] )
	postgres? ( dev-python/sqlalchemy[postgres] )"

DEPEND="${RDEPEND}"
S="${WORKDIR}/yandex-yandex-tank-${GIT_SHA1}"

python_install() {
	for mod in Tank Tank/{MonCollector,MonCollector/agent,Plugins,Plugins/bfg,stepper} tankcore.py; do
		python_domodule $mod
	done
	newbin ${S}/tank.py yandex-tank
	newbin ${S}/ab.sh yandex-tank-ab

	mkdir -p ${D}/usr/lib/python2.7/site-packages/Tank/Plugins
	cp ${S}/Tank/Plugins/*.{tpl,xml,txt,html} ${D}/usr/lib/python2.7/site-packages/Tank/Plugins/

	if use jmeter; then
		newbin ${S}/jmeter.sh yandex-tank-jmeter
	fi

	if use bash-completion; then
		newbashcomp yandex-tank.completion yandex-tank
	fi

	dodir /etc/yandex-tank
	insinto /etc/yandex-tank
		doins ${FILESDIR}/load.ini
		doins ${FILESDIR}/00-base.ini
		doins ${FILESDIR}/sysctl.conf
}

src_install() {
	python_foreach_impl python_install
}

pkg_postinst() {
	elog
	elog "After installation and before firing of targets,"
	elog "it's recommended to change sysctl setting."
	elog "See example in /etc/yandex-tank/sysctl.conf"
	elog "Also useful to increase open files limit with 'uname -n 30000'"
	elog
}
