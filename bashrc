# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi



SOFTPATH=/home/lyh/Soft
CLANGPATH=$SOFTPATH/clang
CMAKEPATH=$SOFTPATH/Cmake
CUDAPATH=$SOFTPATH/CUDA
EMACSPATH=$SOFTPATH/emacs
FFTWPATH=$SOFTPATH/fftw
GITPATH=$SOFTPATH/git
GLOBALPATH=$SOFTPATH/Global
MATLABPATH=$SOFTPATH/MATLAB
MPICHPATH=$SOFTPATH/MPICH
TEXLIVEPATH=$SOFTPATH/texlive
GLOBALPAHT=$SOFTPATH/global



PATH=~/:$CLANGPATH/bin:$CMAKEPATH/bin:$CUDAPATH/bin:$EMACSPATH/bin:$FFTWPATH/bin:$GITPATH/bin:$GLOBALPATH/bin:$MATLABPATH/bin:$MPICHPATH/bin:$TEXLIVEPATH/bin/x86_64-linux:$GLOBALPAHT/bin:$PATH
export PATH
