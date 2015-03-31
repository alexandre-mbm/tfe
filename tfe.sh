#!/bin/bash
#
# The MIT License (MIT)
#
# Copyright (c) 2015 Alexandre Magno ‒ alexandre.mbm@gmail.com
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

NAME="screengrab"
PROFILE="qzxm84qt.default"
XPI="{02450914-cdd9-410f-b1da-db004e18c671}.xpi"
TMP="chrome/locale/pt-BR"

XPI=~/.mozilla/firefox/$PROFILE/extensions/$XPI

case "$1" in
    backup)
        cp $XPI $NAME-$(date +%Y%m%d%k%M%S).xpi
        LAST_BACKUP=$(ls -1 screengrab-[^o]*.xpi | sort -r | head -n 1)
        ln -sf $LAST_BACKUP screengrab.xpi
        ;;
    original)
        cp screengrab.xpi screengrab-original.xpi
        ;;
    install)
        install -Dm644 contents.rdf $TMP/contents.rdf
        install -Dm644 screengrab.dtd $TMP/screengrab.dtd
        install -Dm644 screengrab.properties $TMP/screengrab.properties
        7z a -r $XPI $TMP
        7z a $XPI chrome.manifest install.rdf
        ;;
    restore)
        cp screengrab-original.xpi $XPI
        ;;
    *)
        echo "none"
esac
