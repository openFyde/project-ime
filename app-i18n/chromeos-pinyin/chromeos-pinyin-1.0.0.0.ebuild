# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI="4"
inherit eutils

DESCRIPTION="The Chinese Pinyin input engine for IME extension API"
HOMEPAGE="https://code.google.com/p/google-input-tools/"
#SRC_URI="http://commondatastorage.googleapis.com/chromeos-localmirror/distfiles/${P}.tar.gz"
#SRC_URI="${FILESDIR}/${P}.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"

S="${WORKDIR}"
Target_file="${P}.tar.gz"

src_prepare () {
        cros_enable_cxx_exceptions
	cp ${FILESDIR}/${Target_file} ${S}
        cd $S
        tar xf ${Target_file}
        rm ${Target_file}
}

src_install() {
	insinto /usr/share/chromeos-assets/input_methods/pinyin/
	doins -r ${WORKDIR}/chromeos-pinyin/*
}
