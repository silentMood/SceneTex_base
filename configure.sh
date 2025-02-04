############################ module install ############################
module load anaconda3/default
module load python/3.9.1/default
module load cuda/11.8/default
############################ module install end ############################

conda init tcsh
source ~/.tcshrc
conda activate scenetex

# create and activate the conda environment
conda create -n scenetex python=3.9
conda activate scenetex

mkdir /speed-scratch/$USER/tmp/py
setenv TMPDIR /speed-scratch/$USER/tmp/py