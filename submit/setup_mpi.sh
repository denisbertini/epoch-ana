#!/bin/bash

OPTIND=1

usage() { echo "Usage: $0  [-c <string>]" 1>&2; return; }

# check first if we have spack 
if ! [ -x "$(which spack)" ]; then
  echo 'Error: spack is not installed on this system, quiting ...' >&2
  return
fi


while getopts ":v:c:" o; do
    case "${o}" in
        v)
            v=${OPTARG}
            ;;
        c)
            c=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "${c}" ]; then
    usage
fi

echo "selected compiler = ${c}"

# Check in which VAE we are
vae_arch=`spack arch -o`
echo "selected vae: $vae_arch"

if [ $c == 'gcc8' ]
then
    echo "loading spack gcc v8 + openmpi v3.1..."
    spack load cmake %gcc target=x86_64
    spack load openmpi %gcc target=x86_64
    spack load --only package hdf5%gcc target=x86_64
#    export LD_LIBRARY_PATH=/lustre/rz/dbertini/soft/hdf5/lib:$LD_LIBRARY_PATH
    #    export PATH=/lustre/rz/dbertini/soft/hdf5/bin:$PATH
    
    if [ ${vae_arch} == "debian10" ]
    then
       echo "vae:debian10 -> do not load gcc"  

    elif [ ${vae_arch} == "centos7" ]
    then 	 
     spack load gcc    
    fi
elif [ $c == 'intel' ]
then
    echo "loading spack icc v19 + openmpi v3.1  ..."
    spack load openmpi@3.1.6%intel arch=linux-centos7-x86_64
    spack load hdf5%intel arch=linux-centos7-x86_64
    spack load gcc
    spack load intel-parallel-studio    
    spack load cmake%intel  
elif [ $c == 'gcc11' ]
then
    echo "loading local gcc v11.2 + openmpi v4.1 (ibverbs only) ..."    
    spack load cmake %gcc target=x86_64
    module use /lustre/rz/dbertini/modulefiles
    module load compiler/gcc/11.2.0_virgo
    #    export LD_LIBRARY_PATH=$MPI4_PATH/soft/ucx/1.11/lib:$LD_LIBRARY_PATH
    #    export PATH=$WD/soft/ucx/1.11/bin:$PATH
    export HDF5_PATH=/lustre/rz/dbertini/soft/hdf5-gcc11
    export LD_LIBRARY_PATH=$MPI4_PATH/soft/ompi4.1_gcc8_centos/lib:$LD_LIBRARY_PATH
    export LD_LIBRARY_PATH=$HDF5_PATH/lib:$LD_LIBRARY_PATH
    export PATH=$WD/soft/ompi4.1_gcc8_centos/bin:$PATH
    export PATH=$HDF5_PATH/bin:$PATH    
fi
