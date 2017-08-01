# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_PHP="php5-6 php7-0 php7-1"
PHP_EXT_NAME="redis"
PHP_EXT_INI="yes"

inherit php-ext-pecl-r3 git-r3

MY_PV="9999"
DESCRIPTION="The phpredis extension provides an API for communicating with the Redis key-value store."
HOMEPAGE="https://github.com/nicolasff/phpredis"
SRC_URI=""
EGIT_REPO_URI="https://github.com/nicolasff/phpredis.git"

LICENSE="PHP-3"
SLOT="0"
#KEYWORDS="amd64 x86"
IUSE=""

# make test would just run php's test and as such need the full php source
RESTRICT="test"

DEPEND="dev-lang/php"
RDEPEND="${DEPEND}"

src_unpack() {
	git-r3_src_unpack
	php-ext-source-r3_src_unpack
}

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
