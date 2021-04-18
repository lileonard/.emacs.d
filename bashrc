# my .bashrc file
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# basic path
SOFTPATH=/mnt/Soft/LinuxSoft
WORKPATH=/home/lyh/work
PROGRAMMINGPATH=/home/lyh/programming
# basic soft
CMAKEPATH=$SOFTPATH/CMake
CUDAPATH=$SOFTPATH/CUDA
EMACSPATH=$SOFTPATH/emacs
FFTWPATH=$SOFTPATH/FFTW3
GITPATH=$SOFTPATH/git
GLOBALPATH=$SOFTPATH/global
MATLABPATH=$SOFTPATH/Matlab
MPICHPATH=$SOFTPATH/mpich
TEXLIVEPATH=$SOFTPATH/texlive
PYTHONPATH=$SOFTPATH/anaconda3
GDBPAHT=$SOFTPATH/gdb
VALGRINDPATH=$SOFTPATH/valgrind3
ANACONDAPATH=$SOFTPATH/anaconda3
# all above pathes
PATH=$CMAKEPATH/bin:$CUDAPATH/bin:$EMACSPATH/bin:$FFTWPATH/bin:$GITPATH/bin:$GLOBALPATH/bin:$MATLABPATH/bin:$MPICHPATH/bin:$TEXLIVEPATH/bin/x86_64-linux:$GLOBALPAHT/bin:$GDBPAHT/bin:$VALGRINDPATH/bin:$ANACONDAPATH/bin:$PYTHONPATH/bin:$PATH


#libs installed for emacs 
PATH=$SOFTPATH/usr/bin:$SOFTPATH/usr/include:$SOFTPATH/usr/lib:$SOFTPATH/usr/lib64:$SOFTPATH/usr/share:$PATH
# useful lib
USEFULLIBPATH=$SOFTPATH/usr
LD_LIBRARY_PATH=$USEFULLIBPATH/lib:$USEFULLIBPATH/lib64:$LD_LIBRARY_PATH
C_INCLUDE_PATH=$USEFULLIBPATH/include:$C_INCLUDE_PATH
PATH=$USEFULLIBPATH/lib:$USEFULLIBPATH/lib64:$USEFULLIBPATH/include:$PATH

#LeSeis
LESEIS_DIR=$SOFTPATH/LeSeis
LESEIS_INC=$LESEIS_DIR/include
export LESEIS_DIR LESEIS_INC


#QT
QTDIR=$SOFTPATH/Qt/Qt4/Desktop/Qt/4.8.1/gcc
QTINC=$QTDIR/include
QTLIB=$QTDIR/lib
QCOMMON_DIR=$LESEIS_DIR/common
QSHARED_DIR=$PROGRAMMINGPATH/src/SeismicProcess/shared
QMAKESPEC=$QTDIR/mkspecs/linux-g++-64
export QTDIR QTINC QTLIB QCOMMON_DIR QSHARED_DIR QMAKESPEC

LD_LIBRARY_PATH=$LESEIS_DIR/lib:$QTDIR/lib:$LD_LIBRARY_PATH
C_INCLUDE_PATH=$QTINC:$LESEIS_INC:$C_INCLUDE_PATH
CPLUS_INCLUDE_PATH=$QTINC:$LESEIS_INC:$CPLUS_INCLUDE_PATH
PATH=$QTDIR/bin:$LESEIS_DIR/bin:$QTINC:$LESEIS_INC:$PATH

#QTCREATOR4
QTCREATORPATH=$SOFTPATH/Qt/Qt4/QtCreator
PATH=$QTCREATORPATH/bin:$PATH

#FFTW
FFTW_DIR=$FFTWPATH
PATH=$FFTW_DIR/include:$FFTW_DIR/lib:$FFTW_DIR/bin:$PATH
LD_LIBRARY_PATH=$FFTW_DIR/lib:$LD_LIBRARY_PATH
C_INCLUDE_PATH=$FFTW_DIR/include:$C_INCLUDE_PATH
CPLUS_INCLUDE_PATH=$FFTW_DIR/include:$CPLUS_INCLUDE_PATH
export FFTW_DIR
export LD_LIBRARY_PATH 
export C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH

#MPICH
MPI_HOME=$MPICHPATH
PATH=$MPI_HOME/include:$MPI_HOME/bin:$PATH
LD_LIBRARY_PATH=$MPI_HOME/lib:$LD_LIBRARY_PATH
C_INCLUDE_PATH=$MPI_HOME/include:$C_INCLUDE_PATH
CPLUS_INCLUDE_PATH=$MPI_HOME/include:$CPLUS_INCLUDE_PATH
#export PATH
export MPI_HOME
export LD_LIBRARY_PATH 
export C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH

export PATH

export MALLOC_TRACE=~/mtrace.out
# valgrind memery check
alias memCheck='valgrind --tool=memcheck --leak-check=full --error-limit=no --show-reachable=no --log-file=/home/liyuanheng/memlog.org  '

# terminal macro
# work backup
alias backup='mkdir ~/backup  && cp ~/.bashrc ~/backup/bashrc.bak && cp -rf ~/.emacs.d ~/backup/emacs.d.bak && cp -rf ~/work ~/backup/work.bak  && tar -czvf /mnt/Work/backup.tar ~/backup && rm -rf ~/backup'

alias backup_Cluster='mkdir ~/backup && cp ~/.bashrc ~/backup/bashrc.bak && cp -rf ~/.emacs.d ~/backup/emacs.d.bak && cp -rf ~/programming ~/backup/programming.bak  && tar -czvf ~/lyh_backups/backup.tar ~/backup --exclude *.o --exclude build --exclude LeSeis --exclude LeSeis_back --exclude *.a --exclude *.out && rm -rf ~/backup'

alias pinyin='ibus engine libpinyin'
alias emacs_install='./autogen.sh && ./configure --prefix=/home/lyh/Soft/emacs/ && make -j8 && make install'
alias mymodel='g++ -O2 -fopenmp model.cpp && ./a.out && rm -rf ./a.out'
alias mymodel3D='g++ -O2 -fopenmp model3D.cpp && ./a.out && rm -rf ./a.out'
alias mylibinstall='cmake .. && make && make install'

alias cpGBKHM='rm -rf $SOFTPATH/LeSeis/bin/mpi/L_GBKHM && rm -rf $SOFTPATH/LeSeis/bin/GBKHM && cp $PROGRAMMINGPATH/src/SeismicProcess/GBKHM/GBKHM_GUI/GBKHM $SOFTPATH/LeSeis/bin/GBKHM && cp $PROGRAMMINGPATH/src/SeismicProcess/GBKHM/GBKHM/L_GBKHM $SOFTPATH/LeSeis/bin/mpi/L_GBKHM && rm -rf $SOFTPATH/myapp/bin/L_GBKHM && rm -rf $SOFTPATH/myapp/bin/GBKHM && cp $PROGRAMMINGPATH/src/SeismicProcess/GBKHM/GBKHM_GUI/GBKHM $SOFTPATH/myapp/bin/GBKHM && cp $PROGRAMMINGPATH/src/SeismicProcess/GBKHM/GBKHM/L_GBKHM $SOFTPATH/myapp/bin/L_GBKHM && cd $SOFTPATH/myapp/bin && tar -czvf ./putGBM.tar ./L_GBKHM ./GBKHM && mv -f ./putGBM.tar ~/putGBM.tar && cd'

alias cp2DGBM='rm -rf $SOFTPATH/LeSeis/bin/mpi/L_GBKHM && rm -rf $SOFTPATH/LeSeis/bin/GBKHM && cp /home/lyh/work/GBKHM-build-desktop-Desktop_Qt_4_8_1_for_GCC__Qt_SDK__Release/GBKHM/L_GBKHM $SOFTPATH/LeSeis/bin/mpi/L_GBKHM && cp /home/lyh/work/GBKHM-build-desktop-Desktop_Qt_4_8_1_for_GCC__Qt_SDK__Release/GBKHM_GUI/GBKHM $SOFTPATH/LeSeis/bin/GBKHM'

alias cp3DGBM='rm -rf $SOFTPATH/LeSeis/bin/mpi/L_GBM3D && rm -rf $SOFTPATH/LeSeis/bin/GBM3D && cp $PROGRAMMINGPATH/src/SeismicProcess/GBM_3D/GBM3D $SOFTPATH/LeSeis/bin/GBM3D && cp $PROGRAMMINGPATH/src/SeismicProcess/GBM_3D/mpi/L_GBM3D $SOFTPATH/LeSeis/bin/mpi/L_GBM3D && rm -rf $SOFTPATH/myapp/bin/L_GBM3D && rm -rf $SOFTPATH/myapp/bin/GBM3D && cp $PROGRAMMINGPATH/src/SeismicProcess/GBM_3D/GBM3D $SOFTPATH/myapp/bin/GBM3D && cp $PROGRAMMINGPATH/src/SeismicProcess/GBM_3D/mpi/L_GBM3D $SOFTPATH/myapp/bin/L_GBM3D && cd $SOFTPATH/myapp/bin && tar -czvf ./put3DGBM.tar ./L_GBM3D ./GBM3D && mv -f ./put3DGBM.tar ~/put3DGBM.tar && cd'

# a macro by lyh to copy exe quickly on les_01
alias cluster_cpGBMbin="tar -zxvf /soft/les_01/putGBM.tar && mv -f /soft/les_01/GBKHM /soft/les_01/LeSeis/bin/GBKHM && mv -f /soft/les_01/L_GBKHM /soft/les_01/LeSeis/bin/mpi/L_GBKHM && rm -rf /soft/les_01/putGBM.tar"
alias cluster_cp3DGBMbin="tar -zxvf /soft/les_01/put3DGBM.tar && mv -f /soft/les_01/GBM3D /soft/les_01/LeSeis/bin/GBM3D && mv -f /soft/les_01/L_GBM3D /soft/les_01/LeSeis/bin/mpi/L_GBM3D && rm -rf /soft/les_01/put3DGBM.tar"

alias broser="setsid firefox 2>&1 > broser.log"

alias tf="conda activate tensorflow"
alias py3="/mnt/Soft/LinuxSoft/anaconda3/envs/tensorflow/bin/python3"
alias qt5="/mnt/Soft/LinuxSoft/Qt/Qt5/Tools/QtCreator/bin/qtcreator"





# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/mnt/Soft/LinuxSoft/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/mnt/Soft/LinuxSoft/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/mnt/Soft/LinuxSoft/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/mnt/Soft/LinuxSoft/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

