# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

MY_PV="${PV/rc/RC}"

PHP_EXT_NAME="runkit"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="README.md"

USE_PHP="php5-6"

inherit php-ext-pecl-r2

KEYWORDS="~amd64 ~ia64 ~x86"
LICENSE="AS-IS"

DESCRIPTION="Runkit (official PECL PHP Runkit extension)"
SLOT="0"

IUSE="sandbox super +modify"
REQUIRED_USE="|| ( sandbox modify )"

DEPEND="sandbox? ( dev-lang/php:*[threads] )"
RDEPEND="${DEPEND}"

src_configure() {
	my_conf="--enable-runkit"

	enable_extension_enable "runkit-sandbox" "sandbox" 0
	enable_extension_enable "runkit-super" "super" 0
	enable_extension_enable "runkit-modify" "modify" 0

	php-ext-source-r2_src_configure
}
