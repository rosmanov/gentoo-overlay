# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

MODULE_AUTHOR=MARKOV
MODULE_VERSION=0.63
inherit perl-module

DESCRIPTION="OAuth 2.0 protocol implementation"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="
  dev-perl/URI
  dev-perl/yaml
  dev-perl/HTTP-Message
  dev-perl/HTTP-Date
  dev-perl/LWP-UserAgent
  dev-perl/JSON
"
DEPEND="${RDEPEND}"

SRC_TEST="do"
