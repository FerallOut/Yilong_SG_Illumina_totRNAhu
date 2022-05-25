#!/bin/bash -l
module load samtools

dir_file='/data/manke/processing/balan/Yilong_SG_data/2022.03_DE_genes_transcript/analysis_bam_default_dive_into_reads/analysis_bam_default_fC-R/featureCounts'
out_file=${dir_file}/reads_tags_fC_flags

for k in $(find ${dir_file} -iname 's*.filtered.bam.featureCounts.bam' -printf '%P\n' | sort -V)
do
    echo '*** starting with file:' $k
    
    echo $k >> ${out_file} 
    tot=$(samtools view -c $k)
    echo $tot 'Number of total reads' >> ${out_file}
#############################################
    
    uniq_r_nr=$(samtools view -c -f 2 -F 4 -F 256 -F 1024 $k)
    arrTot=(${uniq_r_nr// / })
    perc_uniq=$(echo "scale=2;(${arrTot[0]})*100/$tot" | bc -l)

    echo $uniq_r_nr $'\t' '1) Number of unique reads' $'\t' $perc_uniq >> ${out_file}
    
    uniq_r=$(samtools view -f 2 -F 4 -F 256 -F 1024 $k | grep -oh '\w*XS:Z:\w*' | cut -d ':' -f 3 | sort | uniq -c) 
    #echo $outs | tr ' ' '\t' | sed 's/\t/\n/2;P;D'  >> ${out_file} 

    arrVals=(${uniq_r// / })   # make an array of the components of the assignment variable
    #echo ${arrVals[@]}
    #echo ${#arrVals[@]}
  
    for index in $(seq 0 2 ${#arrVals[@]})   #${!arrVals[@]}          #${#arrVals[@]}
    do
        #echo $index
        perc=$(echo "scale=2; ${arrVals[$index]}*100/$uniq_r_nr" | bc -l) #this gives error but works!
        echo ${arrVals[$index]}$'\t'' - '${arrVals[$index+1]} $'\t'$perc >> ${out_file}
    done
##############################################
    
    dupl_r_nr=$(samtools view -c -F 4 -f 1024 $k)
    arrTot=(${dupl_r_nr// / })
    perc_dupl=$(echo "scale=2;(${arrTot[0]})*100/$tot" | bc -l)

    echo $dupl_r_nr $'\t' '2) Number of duplicated reads' $'\t' $perc_dupl >> ${out_file}

    dupl_r=$(samtools view -F 4 -f 1024 $k | grep -oh '\w*XS:Z:\w*' | cut -d ':' -f 3 | sort | uniq -c)
    #echo $outs | tr ' ' '\t' | sed 's/\t/\n/2;P;D'  >> ${out_file} 

    arrVals=(${dupl_r// / })   # make an array of the components of the assignment variable
    #echo ${arrVals[@]}
    #echo ${#arrVals[@]}

    for index in $(seq 0 2 ${#arrVals[@]})   #${!arrVals[@]}          #${#arrVals[@]}
    do
        #echo $index
        perc=$(echo "scale=2; ${arrVals[$index]}*100/$dupl_r_nr" | bc -l) #this gives error but works!
        echo ${arrVals[$index]}$'\t'' - '${arrVals[$index+1]} $'\t'$perc >> ${out_file}
    done

##############################################

    mm_r_nr=$(samtools view -c -F 4 -f 256 $k)
    arrTot=(${mm_r_nr// / })
    perc_mm=$(echo "scale=2;(${arrTot[0]})*100/$tot" | bc -l)

    echo $mm_r_nr $'\t' '3) Number of multimapped reads' $'\t' $perc_mm >> ${out_file}

    mm_r=$(samtools view -F 4 -f 256 $k | grep -oh '\w*XS:Z:\w*' | cut -d ':' -f 3 | sort | uniq -c)
    #echo $outs | tr ' ' '\t' | sed 's/\t/\n/2;P;D'  >> ${out_file} 

    arrVals=(${mm_r// / })   # make an array of the components of the assignment variable
    #echo ${arrVals[@]}
    #echo ${#arrVals[@]}

    for index in $(seq 0 2 ${#arrVals[@]})   #${!arrVals[@]}          #${#arrVals[@]}
    do
        #echo $index
        perc=$(echo "scale=2; ${arrVals[$index]}*100/$mm_r_nr" | bc -l) #this gives error but works!
        echo ${arrVals[$index]}$'\t'' - '${arrVals[$index+1]} $'\t'$perc >> ${out_file}
    done

##############################################

    echo $k 'done'
done

echo '**Processing complete!**'


