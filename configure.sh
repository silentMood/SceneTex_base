############################ module install ############################
module load anaconda3/default
module load python/3.9.1/default
module load cuda/11.8/default
############################ module install end ############################

# create and activate the conda environment
conda create -n scenetex python=3.9
conda activate scenetex