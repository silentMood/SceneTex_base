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
module load gcc/9.3
module load anaconda3/default
module load python/3.9.1/default
module load cuda/11.8/default

mkdir -p /speed-scratch/$USER/sceneTex/tmp
mkdir -p /speed-scratch/$USER/sceneTex/pkgs
setenv TMPDIR /speed-scratch/$USER/sceneTex/tmp
setenv CONDA_PKGS_DIRS /speed-scratch/$USER/sceneTex/pkgs
setenv CMAKE_CUDA_COMPILER /encs/pkg/cuda-11.5/root/bin/nvcc
setenv CMAKE_C_COMP

conda create -n scenetex python=3.9
conda activate scenetex

conda install pytorch==2.0.1 torchvision==0.15.2 torchaudio==2.0.2 pytorch-cuda=11.7 -c pytorch -c nvidia

# install runtime dependencies for PyTorch3D
conda install -c fvcore -c iopath -c conda-forge fvcore iopath
conda install -c bottler nvidiacub

# install PyTorch3D
conda install pytorch3d -c pytorch3d

conda install xformers -c xformers

pip install git+https://github.com/NVlabs/tiny-cuda-nn/#subdirectory=bindings/torch

pip install -r requirements.txt
# git clone --recursive https://github.com/NVlabs/tiny-cuda-nn.git
# cd tiny-cuda-nn
# cmake -DCMAKE_C_COMPILER=/encs/pkg/gcc-9.3.0/root/bin/gcc -DCMAKE_CXX_COMPILER=/encs/pkg/gcc-9.3.0/root/bin/g++ . -B build
# cmake --build build --config RelWithDebInfo -j
# cd bindings/torch
# python setup.py install

# date
# cd /encs/pkg/cuda-11.5/root/
# date

# setenv CMAKE_CXX_COMPILER /encs/pkg/gcc-9.3.0/root/bin/gcc

# cmake -DCMAKE_C_COMPILER=/encs/pkg/gcc-9.3.0/root/bin/gcc -DCMAKE_CXX_COMPILER=/encs/pkg/gcc-9.3.0/root/bin/g++ . -B build

# cmake . -B CMAKE_CXX_COMPILER=/encs/pkg/gcc-9.3.0/root/bin/gcc CMAKE_C_COMPILER=/encs/pkg/gcc-9.3.0/root/bin/gcc build