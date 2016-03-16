# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

PHP_EXT_NAME="runkit"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="README.md"

USE_PHP="php5-6"

inherit php-ext-pecl-r2 confutils eutils

KEYWORDS="amd64 ia64 x86"
LICENSE="AS-IS"

DESCRIPTION="Runkit (official PECL PHP Runkit extension)"
SLOT="0"

DEPEND="sandbox? ( dev-lang/php:*[threads] )"
RDEPEND="${DEPEND}"

IUSE="sandbox super modify"

src_configure() {
	my_conf="--enable-runkit"

	enable_extension_enable "runkit-sandbox" "sandbox" 0
	enable_extension_enable "runkit-super" "super" 0
	enable_extension_enable "runkit-modify" "modify" 0

	php-ext-source-r2_src_configure
}
