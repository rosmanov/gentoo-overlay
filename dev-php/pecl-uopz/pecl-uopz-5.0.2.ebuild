# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

PHP_EXT_NAME="uopz"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

USE_PHP="php7-0 php7-1"

inherit php-ext-pecl-r3

KEYWORDS="~amd64 ~ia64 ~x86"
LICENSE="PHP-3.01"

DESCRIPTION="The uopz extension is focused on providing utilities to aid with unit testing PHP code."
SLOT="0"

DEPEND="
	php_targets_php7-0? ( dev-lang/php:7.0 )
	php_targets_php7-1? ( dev-lang/php:7.1 )
"

RDEPEND="${DEPEND}"

IUSE="sanitize"

src_configure() {
	local PHP_EXT_ECONF_ARGS=(
		--enable-uopz
		$(use_with sanitize uopz-sanitize)
	)
	php-ext-source-r3_src_configure
}
