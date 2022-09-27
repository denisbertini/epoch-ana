#!/bin/bash
export OMP_NUM_THREADS=1
export SINGULARITY_DISABLE_CACHE=1
export SIMDIR=/lustre/rz/dbertini/collisions

# Set environment
. $SIMDIR/scripts/setup_mpi.sh -c gcc8
mpicc -showme:version
type gcc
type mpicc
type mpirun
type srun

# Set executable directory
export PATH=$SIMDIR/bin:$PATH
echo " "
echo "Epoch dev: setup done ... "
echo " "
echo $PATH
ulimit -c 0

#export OMPI_MCA_io=romio321
#export OMPI_MCA_mpi_leave_pinned=0
#export OMPI_MCA_btl_openib_allow_ib=1
#export OMPI_MCA_btl_openib_warn_no_device_params_found=0
#export OMPI_MCA_btl_openib_rdma_pipeline_send_length=100000000
#export OMPI_MCA_btl_openib_rdma_pipeline_frag_size=100000000


#echo "." | srun --mpi=pmi2 --export=ALL  -- epoch2d
#echo "." | srun --export=ALL --hint=memory_bound -- epoch2d
echo "." | srun --export=ALL -- $SIMDIR/bin/epoch3d

#echo "." | srun -l --propagate=STACK,CORE --cpu-bind=verbose,cores --hint=nomultithread --  epoch2d
#echo "." | srun -l --propagate=STACK,CORE --cpu-bind=verbose,cores  --  epoch2d


#echo "." | srun -l --propagate=STACK,CORE --cpu-bind=verbose,cores \#
#		--distribution=block:cyclic --hint=multithread --  epoch2d
