#!/bin/bash

# Install cask for Travis CI
# or if already installed, then check for updates
# Author: gonewest818 https://github.com/clojure-emacs/cider/pull/2139

set -x

WORKDIR=${HOME}/local
CASKDIR=$WORKDIR/cask

. tools/retry.sh

cask_upgrade_cask_or_reset() {
    cask upgrade-cask || { rm -rf $HOME/.emacs.d/.cask && false; }
}

cask_install_or_reset() {
    if [ $(cask eval "(princ emacs-major-version)") -gt "25" ]; then
        echo "!!!! ALERT WORKAROUND !!!!"
        set -x
        grep -v "org-plus-contrib" ./Cask > ./Cask.tmp
        mv ./Cask.tmp ./Cask
        set +x
    fi
    cask install || { rm -rf .cask && false; }
    # travis cache
    rsync -vazSHe ssh .cask $HOME/
}

# Bootstrap the cask tool and its dependencies
if [ ! -d $CASKDIR ] ; then
    git clone https://github.com/cask/cask.git $CASKDIR
fi

# Install dependencies for cider as descriped in ./Cask
# Effect is identical to "make elpa", but here we can retry
# in the event of network failures.
travis_retry cask_upgrade_cask_or_reset
travis_retry cask_install_or_reset && touch elpa-emacs
