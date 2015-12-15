#! /bin/bash

#running structure on the command line
#ensure structure, param files and input file are in the working directory
#just fill in the following 3 variables (and make sure the param files are completed
#need to change extraparams file "#define RANDOMIZE" =0 and remove # from in front of "#define SEED"

NAME=Testdata1			#supply file name suffix
MINK=1					#supply minimum K value (usually 1)
MAXK=5					#supply max number of K value to test (K = 1-? )
NREP=10					#supply number of reps for each Kvalue test

if [ ! -d ./results ]
then mkdir results
fi
if [ -f ./commands.txt ]
then rm commands.txt
fi

echo "analysis started at $(date)"

COUNTER=$MINK 
while [  $COUNTER -le $MAXK  ]; do 
	REP=1
	while [ $REP -le $NREP ]; do
		echo "nohup ./structure -e extraparams_p -m mainparams_p -D $[RANDOM % 999999999] -K $COUNTER -o ./results/"$NAME"_K"$COUNTER"_rep"$REP" 2>&1 " >> commands.txt
		REP=$((REP+1))
		done
	let COUNTER=COUNTER+1
done	
nohup parallel < commands.txt &
sleep 2
echo "analysis started at $(date)"
echo "*"
echo "*"
echo "Enter 'ps' to see Structure processes running"
echo "*"
echo "*"

wait
echo "STRUCTURE complete"
echo "completed at $(date)"	

