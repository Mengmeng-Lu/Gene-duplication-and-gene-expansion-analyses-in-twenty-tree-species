input=$1

### Do blastx using diamond for Blast2GO
/afs/crc.nd.edu/user/m/mlu/bin/diamond  blastx -d  /scratch365/mlu/NCBI/nr_db_diamond_taxon --taxonlist 33090  -q $input  -p 12  --very-sensitive -f 5  -o $input.diamond.xml


### Get longest ORF
module load  R/4.1.1/gcc 
/afs/crc.nd.edu/user/m/mlu/bin/TransDecoder-TransDecoder-v5.5.0/TransDecoder.LongOrfs -t $input 
/afs/crc.nd.edu/user/m/mlu/bin/TransDecoder-TransDecoder-v5.5.0/TransDecoder.Predict -t $input  
/afs/crc.nd.edu/user/m/mlu/bin/TransDecoder-TransDecoder-v5.5.0/util/get_longest_ORF_per_transcript.pl  $input.transdecoder.pep > $input.longest_orf.pep.fasta


### Transdecoder append * to each pep sequcence, but these * can't be recognized by interproscan, so delete *
sed -i 's/*//g'  $input.longest_orf.pep.fasta
grep ">" -c $input.longest_orf.pep.fasta  $input.transdecoder.pep  $input
rm -f -R $input.transdecoder.*  pipeliner.*  $input.transdecoder_dir*



### Do eggnog annotation

#conda activate py38, instead, run conda in the submission script.
export PATH=/afs/crc.nd.edu/user/m/mlu/bin/eggnog-mapper/eggnogmapper/bin:"$PATH"
/afs/crc.nd.edu/user/m/mlu/bin/eggnog-mapper/emapper.py  -m diamond --sensmode more-sensitive  --cpu 12 -i $input.longest_orf.pep.fasta  --output $input.egg  --tax_scope 33090 --tax_scope_mode 33090


### Do interproscan annotation 
/afs/crc.nd.edu/user/m/mlu/bin/interproscan/interproscan-5.54-87.0/interproscan.sh  -i $input.longest_orf.pep.fasta -b $input.inter  -dra -f XML -goterms -pa 


