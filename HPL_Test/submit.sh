#!/bin/bash
#SBATCH --job-name=HPL
#SBATCH -p ct56 
#SBATCH -c 1         # Number of cores per MPI task
#SBATCH -N 1        # Maximum number of nodes to be allocated
#SBATCH --ntasks-per-node=56    # Maximum number of tasks on each node
#SBATCH -e job-%j.err
#SBATCH -o job-%j.out

module purge
module load compiler/intel/2022 IntelMPI/2021.6

export I_MPI_DEBUG=5

for NPROC in 8 16 32 56
do
        NP=$(($(echo "scale=0; sqrt($NPROC)" | bc)/2*2))
        if [ ${NPROC} -eq 56 ]; then
                NP=7
        fi
        NQ=$((${NPROC}/${NP}))

        /bin/cp -f HPL_INPUT HPL.dat
        sed -i "s/NP/${NP}/g" HPL.dat
        sed -i "s/NQ/${NQ}/g" HPL.dat

        mpirun -np ${NPROC} ${HOME}/T3_Training/Compile_Program/HPL/hpl-2.3/bin/Linux_Intel64/xhpl 2>&1 | tee HPL_log-${NPROC}.log
done
