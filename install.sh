#!/encs/bin/tcsh

#SBATCH --job-name=scene_tex    ## Give the job a name 
#SBATCH --mail-type=ALL        ## Receive all email type notifications 
#SBATCH --chdir=./             ## Use currect directory as working directory 
#SBATCH --nodes=1              ## Number of nodes to run on 
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8      ## Number of MPI threads 
#SBATCH --mem=160G             ## Assign 160G memory per node
#SBATCH --gpus=1

############################ module install ############################
module load anaconda3/default
module load python/3.9.1/default
module load cuda/11.8/default

mkdir -p /speed-scratch/$USER/sceneTex/tmp
mkdir -p /speed-scratch/$USER/sceneTex/pkgs
setenv TMPDIR /speed-scratch/$USER/sceneTex/tmp
setenv CONDA_PKGS_DIRS /speed-scratch/$USER/sceneTex/pkgs
############################ module install end ############################
conda create -n scenetex --force python=3.9
conda activate scenetex
############################ dependencies install ############################

setenv CUDAToolkit_ROOT /nfs/encs/ArchDep/x86_64.EL7/pkg/cuda-11.8/root/bin
git clone --recursive https://github.com/NVlabs/tiny-cuda-nn.git
cd tiny-cuda-nn
cmake . -B build
cmake --build build --config RelWithDebInfo -j
cd bindings/torch
python setup.py install
