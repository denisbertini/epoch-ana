
#sbatch --nodes 5 --tasks-per-node 10 --ntasks-per-core 1 --cpus-per-task 1 --no-requeue --job-name tnsa_j --mem-per-cpu 4000 --mail-type ALL --mail-user d.bertini@gsi.de --partition main --time 0-08:00:00 -D ./data -o %j.out.log -e %j.err.log  --constraint intel,xeon -- ./run-file-centos.sh

export SIMDIR=/lustre/rz/dbertini/collisions/

#sbatch --nodes 1 --tasks-per-node 1 --ntasks-per-core 1 --cpus-per-task 1 --no-requeue --job-name tnsa_c --mem-per-cpu 4000 --mail-type ALL --mail-user d.bertini@gsi.de --partition main --time 0-08:00:00 -D $SIMDIR/data -o %j.out.log -e %j.err.log   -- ./run-file.sh

sbatch --nodes 10 --tasks-per-node 10 --ntasks-per-core 1 --cpus-per-task 1 --no-requeue --job-name tnsa_c --mem-per-cpu 4000 --mail-type ALL --mail-user d.bertini@gsi.de --partition main --time 0-08:00:00 -D $SIMDIR/data -o %j.out.log -e %j.err.log   -- ./run-file.sh

