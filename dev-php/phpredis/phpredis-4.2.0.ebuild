# Copyright 2015 Ruslan Osmanov <rrosmanov@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6
PHP_EXT_NAME="redis"
PHP_EXT_INI="yes"
USE_PHP="php7-0 php7-1"

inherit php-ext-source-r3 autotools

MY_PV="${PV/rc/RC}"
DESCRIPTION="The phpredis extension provides an API for communicating with the Redis key-value store."
HOMEPAGE="https://github.com/nicolasff/phpredis"
SRC_URI="https://github.com/phpredis/phpredis/archive/${MY_PV}.tar.gz"

LICENSE="PHP-3"
SLOT="0/1"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE=""

# make test would just run php's test and as such need the full php source
RESTRICT="test"

DEPEND="dev-lang/php"
RDEPEND="${DEPEND}"

src_configure() {
    local PHP_EXT_ECONF_ARGS=( "--disable-redis-session" )
	php-ext-source-r3_src_configure
}

src_install() {
	php-ext-source-r3_src_install
}

pkg_postinst() {
	elog "phpredis module has been successfully installed"
}
