# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit desktop udev unpacker

DESCRIPTION="The official client application for the Waves platform"
HOMEPAGE="https://github.com/wavesplatform/WavesGUI#readme"
SRC_URI="https://wavesplatform.com/files/WavesClient-linux.deb -> ${P}.deb"

KEYWORDS="~amd64 ~x86"
LICENSE="Apache-2.0"
SLOT="0"

RDEPEND=""
S="${WORKDIR}"

DOCS=( "usr/share/doc/waves-client/changelog.gz" )

QA_PREBUILT="
opt/Waves\\ Client/waves-client
opt/Waves\\ Client/*.bin
opt/Waves\\ Client/*.dat
opt/Waves\\ Client/*.so
opt/Waves\\ Client/*.pak
opt/Waves\\ Client/locales/*.pak
opt/Waves\\ Client/resources/*.asar
"

src_unpack() {
	unpack_deb ${A}
}

src_prepare() {
	default
}

src_install() {
	exeinto 'opt/Waves Client'
	doexe 'opt/Waves Client/waves-client'

	into 'opt/Waves Client/'
	dolib.so 'opt/Waves Client/'*.so
	for lib in "opt/Waves Client/"$(get_libdir)/*.so; do
		dosym ../"${lib}" "${lib}"
	done

	insinto 'opt/Waves Client'
	doins 'opt/Waves Client/'*.{bin,dat,pak}

	insinto 'opt/Waves Client/locales'
	doins 'opt/Waves Client/locales/'*.pak

	insinto 'opt/Waves Client/resources'
	doins 'opt/Waves Client/resources/'*.asar

	domenu usr/share/applications/waves-client.desktop

	for s in 32 64 128 256; do
		doicon -s $s usr/share/icons/hicolor/"${s}x${s}"/apps/waves-client.png
	done
}
