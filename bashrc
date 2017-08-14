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
GLOBALPATH=$SOFTPATH/global
MATLABPATH=$SOFTPATH/Matlab
MPICHPATH=$SOFTPATH/mpich
TEXLIVEPATH=$SOFTPATH/texlive
GLOBALPAHT=$SOFTPATH/global
GDBPAHT=$SOFTPATH/gdb

PATH=~/:$CLANGPATH/bin:$CMAKEPATH/bin:$CUDAPATH/bin:$EMACSPATH/bin:$FFTWPATH/bin:$GITPATH/bin:$GLOBALPATH/bin:$MATLABPATH/bin:$MPICHPATH/bin:$TEXLIVEPATH/bin/x86_64-linux:$GLOBALPAHT/bin:$GDBPAHT/bin:$PATH
export PATH

alias backup='mkdir ~/backup && cp -rf /mnt/D/李沅衡/实验结果相关报告论文等/ ~/backup/docs && cp ~/.bashrc ~/backup/bashrc.bak && cp -rf ~/.emacs.d ~/backup/emacs.d.bak && cp -rf ~/work ~/backup/work.bak  && tar -czvf /mnt/D/home/back/backup.tar ~/backup --exclude *.o --exclude build --exclude *.a --exclude *.out && rm -rf ~/backup'

alias pinyin='ibus engine libpinyin'
alias emacs_install='./autogen.sh && ./configure --prefix=/home/lyh/Soft/emacs/ && make && make install'
alias my_model='g++ -O2 -fopenmp model.cpp && ./a.out'
alias my_model3D='g++ -O2 -fopenmp model3D.cpp && ./a.out'
