#!/bin/bash
#SBATCH --job-name=Test
#SBATCH -p ct560 
#SBATCH -c 1         # Number of cores per MPI task
#SBATCH -N 10        # Maximum number of nodes to be allocated
#SBATCH --ntasks-per-node=56    # Maximum number of tasks on each node
#SBATCH -e job-%j.err
#SBATCH -o job-%j.out

module purge
module load compiler/intel/2022 IntelMPI/2021.6

mpirun -rmk slurm ~/bin/mpi_hello_world_intel.x

