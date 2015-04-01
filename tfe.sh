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

NAME="screengrab"  # exemplo.dtd exemplo.properties exemplo.xpi ...
PROFILE="qzxm84qt.default"
XPI="{02450914-cdd9-410f-b1da-db004e18c671}.xpi"
TMP="chrome/locale/pt-BR"

XPI=~/.mozilla/firefox/$PROFILE/extensions/$XPI

help () {
    PROGRAM=tfe
    echo
    echo "  $PROGRAM backup     - gets current xpi from Firefox profile"
    echo "  $PROGRAM original   - copy last backup as original version (take care)"
    echo "  $PROGRAM extract    - extracts files from the original xpi (take care with rewrites)"
    echo "  $PROGRAM install    - installs translations files on Firefox (restart needed)"
    echo "  $PROGRAM restore    - puts the original xpi into Firefox profile"
    echo "  $PROGRAM help       - shows this help"
    echo
}

case "$1" in
    backup)
        cp $XPI $NAME-$(date +%Y%m%d%k%M%S).xpi
        LAST_BACKUP=$(ls -1 $NAME-[^o]*.xpi | sort -r | head -n 1)
        ln -sf $LAST_BACKUP $NAME.xpi
        ;;
    original)
        cp $NAME.xpi $NAME-original.xpi
        ;;
    install)
        install -Dm644 contents.rdf $TMP/contents.rdf
        install -Dm644 $NAME.dtd $TMP/$NAME.dtd
        install -Dm644 $NAME.properties $TMP/$NAME.properties
        7z a -r $XPI $TMP
        7z a $XPI chrome.manifest install.rdf
        ;;
    restore)
        cp $NAME-original.xpi $XPI
        ;;
    extract)
        if [ -e "$NAME-original.xpi" ]; then
            7z e $NAME-original.xpi chrome.manifest install.rdf
            7z e $NAME-original.xpi chrome/locale/en-US/contents.rdf
            7z e $NAME-original.xpi chrome/locale/en-US/$NAME.dtd
            7z e $NAME-original.xpi chrome/locale/en-US/$NAME.properties
        else
            echo "The file $NAME-original.xpi is needed!"
        fi
        ;;
    help|*)
        help
esac
