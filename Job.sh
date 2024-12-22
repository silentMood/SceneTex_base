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
# install PyTorch 2.0.1
conda install pytorch==2.0.1 torchvision==0.15.2 torchaudio==2.0.2 pytorch-cuda=11.7 -c pytorch -c nvidia -y

# install runtime dependencies for PyTorch3D
conda install -c fvcore -c iopath -c conda-forge fvcore iopath -y
conda install -c bottler nvidiacub -y

# install PyTorch3D
conda install pytorch3d -c pytorch3d -y

conda install xformers -c xformers -y

pip install -r requirements.txt --no-input
############################ dependencies install end ############################


############################ Job run ############################
stamp=$(date "+%Y-%m-%d_%H-%M-%S")
log_dir="outputs/" # your output dir
prompt="a bohemian style living room" # your prompt
scene_id="93f59740-4b65-4e8b-8a0f-6420b339469d/room_4" # preprocessed scene

date
srun python scripts/train_texture.py --config config/template.yaml --stamp $stamp --log_dir $log_dir --prompt "$prompt" --scene_id "$scene_id"
date
############################ Job run end ############################