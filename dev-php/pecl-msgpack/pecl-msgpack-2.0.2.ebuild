# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"

PHP_EXT_NAME="msgpack"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="README.md"

USE_PHP="php7-1"

MY_PV="${PV/rc/RC}"

inherit php-ext-pecl-r3

KEYWORDS="~amd64 ~ia64 ~x86"
LICENSE="PHP-3.01"

DESCRIPTION="API for communicating with MessagePack serialization."
LICENSE="BSD 3-Clause"
SLOT="0"

DEPEND=">=dev-libs/librdkafka-0.9.2-r1"
RDEPEND="${DEPEND}"

IUSE=""

src_configure() {
    local PHP_EXT_ECONF_ARGS=( "--with-msgpack" )
    php-ext-source-r3_src_configure
}
