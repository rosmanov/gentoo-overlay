# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2034
EAPI=6

DESCRIPTION="Manage active wine version"
HOMEPAGE="https://github.com/bobwya/wine.eselect"
SRC_URI="https://github.com/bobwya/wine.eselect/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="app-admin/eselect
		dev-util/desktop-file-utils
		!!app-emulation/wine:0"

pkg_pretend() {
	ewarn "If updating ${CATEGORY}/${PN} from version 1.4 (or earlier)"
	ewarn "the eselect configuration ABI has changed."
	ewarn "Please run the tool:"
	ewarn " \"${FILESDIR}/update_symlinks.sh\""
	ewarn "once - immediately after you have updated this package."
	ewarn

	ewarn "${CATEGORY}/${PN}::bobwya is not compatible with the ::gentoo implementation"
	ewarn "of the multislotted Wine packages:"
	ewarn " * app-emulation/wine-desktop-common::gentoo"
	ewarn " * app-emulation/wine-any::gentoo"
	ewarn " * app-emulation/wine-d3d9::gentoo"
	ewarn " * app-emulation/wine-staging::bobwya"
	ewarn " * app-emulation/wine-vanilla::gentoo"
	ewarn
	ewarn "${CATEGORY}/${PN}::bobwya is only designed to be used with the packages:"
	ewarn " * app-emulation/wine-desktop-common::bobwya"
	ewarn " * app-emulation/wine-staging::bobwya"
	ewarn " * app-emulation/wine-vanilla::bobwya"
	ewarn
}

src_install() {
	keepdir "/etc/eselect/wine"

	insinto "/usr/share/eselect/modules"
	doins "wine.eselect"
	doman "man/wine.eselect.5"
}

src_unpack() {
    unpack "${A}"
    ln -s "wine.eselect-${PV}" "${P}"
}

pkg_prerm() {
	# Avoid conflicts with app-emulation/wine:0 - if this is installed later on
	if [[ -z "${REPLACED_BY_VERSION}" ]]; then
		elog "${CATEGORY}/${PN} is being uninstalled, removing symlinks"
		eselect wine unset --all --force --clean || die "eselect wine unset failed"
	else
		einfo "${CATEGORY}/${PN} is being updated/reinstalled, not modifying symlinks"
	fi
}
