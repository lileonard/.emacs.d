# this is a backup of my new bashrc file 
# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

SOFTPATH=/home/lyh/Soft
CLANGPATH=$SOFTPATH/clang
CMAKEPATH=$SOFTPATH/Cmake
CUDAPATH=$SOFTPATH/CUDA
EMACSPATH=$SOFTPATH/emacs
FFTWPATH=$SOFTPATH/fftw3
GITPATH=$SOFTPATH/git
GLOBALPATH=$SOFTPATH/Global
MATLABPATH=$SOFTPATH/MATLAB/R2015b
MPICHPATH=$SOFTPATH/MPICH3
TEXLIVEPATH=$SOFTPATH/texlive

PATH=~/:$CLANGPATH/bin:$CMAKEPATH/bin:$CUDAPATH/bin:$EMACSPATH/bin:$FFTWPATH/bin:$GITPATH/bin:$GLOBALPATH/bin:$MATLABPATH/bin:$MPICHPATH/bin:$TEXLIVEPATH/bin/x86_64-linux:$PATH
export PATH
