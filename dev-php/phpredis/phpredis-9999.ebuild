# Copyright 2015 Ruslan Osmanov <rrosmanov@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
PHP_EXT_NAME="redis"
PHP_EXT_INI="yes"
USE_PHP="php5-3 php5-4 php5-5"
inherit php-ext-source-r2 confutils depend.php git-2

MY_PV="9999"
DESCRIPTION="The phpredis extension provides an API for communicating with the Redis key-value store."
HOMEPAGE="https://github.com/nicolasff/phpredis"
EGIT_REPO_URI="https://github.com/nicolasff/phpredis.git"

LICENSE="PHP-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

# make test would just run php's test and as such need the full php source
RESTRICT="test"

DEPEND="dev-lang/php"
RDEPEND="${DEPEND}"

src_configure() {
	#if ! PHPCHECKNODIE="yes" require_php_with_use session; then
	my_conf="--disable-redis-session" #; fi
	php-ext-source-r2_src_configure
}

src_install() {
	php-ext-source-r2_src_install
}

pkg_postinst() {
	elog "phpredis module has been successfully installed"
}
