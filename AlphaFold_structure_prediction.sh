## to be used in slurm system

# Load AlphaFold environment
module load alphafold #install from https://github.com/google-deepmind/alphafold
export SINGULARITY_LOCALCACHEDIR=$SCRATCH_LOCAL
DB_PATH="{path/where/alphafold/is}"

# inputs
input="${1}"  # sequence name without .fasta suffix 
#project_name="${3}"
db_preset="full_dbs"

# temporary directories
TMP_DIR="$temporary/directory "
IN_PATH="${TMP_DIR}/Archaea/input/monomers/"
OUT_PATH="${TMP_DIR}/Archaea/output//monomers_ptm/"
mkdir -p ${IN_PATH}
mkdir -p ${OUT_PATH}

# final directories
MAIN_PATH="$main/path/for/alpha/fold"
FINAL_IN_PATH="${MAIN_PATH}/input/"  # MUST EXIST !!!
FINAL_OUT_PATH="${MAIN_PATH}/relaxed_structures/"
mkdir -p ${FINAL_OUT_PATH}

echo "Sequence name: ${input}"
echo "Copying input sequence to TMPDIR..."
cp "${FINAL_IN_PATH}/${input}.fasta" "${IN_PATH}/${input}.fasta"

echo "Changing working directory to ${TMP_DIR}"
cd "${TMP_DIR}"

run_alphafold.sh \
  --fasta_paths="${IN_PATH}/${input}.fasta" \
  --output_dir="${OUT_PATH}" \
  --db_preset="${db_preset}" \
  --data_dir="${DB_PATH}/" \
  --model_preset="monomer_ptm" \
  --bfd_database_path="${DB_PATH}/bfd/bfd_metaclust_clu_complete_id30_c90_final_seq.sorted_opt" \
  --uniref30_database_path="${DB_PATH}/uniclust30/uniclust30_2018_08/uniclust30_2018_08" \
  --uniref90_database_path="${DB_PATH}/uniref90/uniref90.fasta" \
  --mgnify_database_path="${DB_PATH}/mgnify/mgy_clusters_2018_12.fa" \
  --pdb70_database_path="${DB_PATH}/pdb70/pdb70" \
  --template_mmcif_dir="${DB_PATH}/pdb_mmcif/mmcif_files/" \
  --max_template_date=2022-06-06 \
  --obsolete_pdbs_path="${DB_PATH}/pdb_mmcif/obsolete.dat"

echo "Copying output from TMPDIR..."
cp -r "${OUT_PATH}/${input}" "${FINAL_OUT_PATH}"

diff=$(echo "$(date +%s.%N) - ${start}" | bc)
echo "Total time [s]: " $diff
