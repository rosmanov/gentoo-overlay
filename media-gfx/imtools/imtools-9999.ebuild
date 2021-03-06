# Copyright 2016 Ruslan Osmanov <rrosmanov@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

if [[ ${PV} == "9999" ]] ; then
	#EGIT_REPO_URI="http://bitbucket.org/osmanov/${PN}.git"
	EGIT_REPO_URI="https://github.com/rosmanov/${PN}.git"
	vcs=git-2
else
	SRC_URI=""
	KEYWORDS="~amd64 ~x86"
fi

inherit $vcs base cmake-utils git-r3

DESCRIPTION="Tools for image manipulation by means of the OpenCV library"
#HOMEPAGE="https://bitbucket.org/osmanov/imtools/"
HOMEPAGE="https://github.com/rosmanov/imtools"

DOCS="README.md LICENSE"
LICENSE="GPL-2"
SLOT="0"

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
		#mycmakeargs+=( "-DIMTOOLS_DEBUG=ON" )
		CMAKE_BUILD_TYPE="Debug"
	fi

	cmake-utils_src_configure
}
