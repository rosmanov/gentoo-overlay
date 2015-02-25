# Copyright 2015 Ruslan Osmanov <rrosmanov@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit vcs-snapshot cmake-utils

DESCRIPTION="Some tools for image manipulation by means of the OpenCV library"
HOMEPAGE="https://bitbucket.org/osmanov/imtools/"
SRC_URI="https://bitbucket.org/osmanov/imtools/get/${PV}.tar.gz -> ${P}.tar.gz"

DOCS="README.md LICENSE"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="debug profiler +threads boost extra"
REQUIRED_USE="
profiler? ( debug )
boost? ( threads )
"

DEPEND="
	media-libs/opencv
	sys-libs/glibc
	threads? (
	  boost? (
		dev-libs/boost[threads]
		dev-cpp/threadpool
	  )
	)
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
	  -DCMAKE_INSTALL_PREFIX=/usr
	  $(cmake-utils_use debug IMTOOLS_DEBUG)
	  $(cmake-utils_use threads IMTOOLS_THREADS)
	  $(cmake-utils_use boost IMTOOLS_THREADS_BOOST)
	  $(cmake-utils_use extra IMTOOLS_EXTRA)
	  $(cmake-utils_use profiler IMTOOLS_DEBUG_PROFILER)
	)

	if use debug; then
		CMAKE_BUILD_TYPE="Debug"
	fi

	cmake-utils_src_configure
}
