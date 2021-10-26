# Copyright 2003-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
WANT_LIBTOOL="none"

inherit autotools

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/s-yata/darts-clone"
else
	DARTS_CLONE_GIT_REVISION=""
fi

DESCRIPTION="Darts-clone (Double-ARray Trie System) C++ library"
# Original upstream: http://chasen.org/~taku/software/darts/
HOMEPAGE="https://github.com/s-yata/darts-clone https://code.google.com/archive/p/darts-clone/"
if [[ "${PV}" == "9999" ]]; then
	SRC_URI=""
else
	SRC_URI="https://github.com/s-yata/darts-clone/archive/${DARTS_CLONE_GIT_REVISION}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="BSD-2"
SLOT="0"
KEYWORDS=""
IUSE=""

BDEPEND=""
DEPEND=""
RDEPEND=""

if [[ "${PV}" != "9999" ]]; then
	S="${WORKDIR}/darts-clone-${DARTS_CLONE_GIT_REVISION}"
fi

src_prepare() {
        cros_enable_cxx_exceptions
	default
	eaclocal
	eautoconf
	eautomake
}

src_install() {
	default

	local language source_file target_file
	for source_file in doc/*/*.md; do
		language="${source_file#*/}"
		language="${language%%/*}"
		target_file="${source_file##*/}"
		target_file="${target_file%.md}.${language}.md"
		newdoc "${source_file}" "${target_file}"
	done
}
