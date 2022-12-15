transcript_rd=$1

### Blastx the query sequences to nr, and assign the best known taxon id.

/afs/crc.nd.edu/user/m/mlu/bin/diamond  blastx -d  /scratch365/mlu/NCBI/nr_db_diamond_taxon  -q  $transcript_rd --outfmt 102  -o  $transcript_rd.besttaxon


### If the query sequences were assigned to green plant taxon id, keep it. Otherwise extract the potential non-plant sequences to 2nd round blastx.

awk 'FNR==NR{a[$1];next}($2 in a)' /scratch365/mlu/NCBI/green_plant_taxid.txt   $transcript_rd.besttaxon |awk '{print $1}'|sort|uniq |awk '{print ">"$0}'> keep_1.list


awk 'NR==FNR {exclude[$1];next} !($2 in exclude)' /scratch365/mlu/NCBI/green_plant_taxid.txt $transcript_rd.besttaxon|awk '{print $1}'|sort|uniq |awk '{print ">"$0}'> realign.list


awk '/^>/ {printf("%s%s\t",(N>0?"\n":""),$0);N++;next;} {printf("%s",$0);} END {printf("\n");}'< $transcript_rd>  $transcript_rd.linear.fasta 


awk 'FNR==NR{a[$1];next}($1 in a)' realign.list $transcript_rd.linear.fasta  |tr "\t" "\n" >  $transcript_rd.realign.fa


### Blastx the potential non-plant sequences to green plant nr, (default  e-value<1e-3)

/afs/crc.nd.edu/user/m/mlu/bin/diamond  blastx -d  /scratch365/mlu/NCBI/nr_db_diamond_taxon --taxonlist 33090  
-q $transcript_rd.realign.fa  --outfmt 6  -o   $transcript_rd.realign.blastx


### Collect those sequences with alignment to green plant nr 

awk '{print $1}' $transcript_rd.realign.blastx |sort|uniq |awk '{print ">"$0}'> keep_2.list

cat keep_1.list keep_2.list|sort|uniq >keep_total.list 


### The final sequences which align to the green plant nr.

awk 'FNR==NR{a[$1];next}($1 in a)' keep_total.list  $transcript_rd.linear.fasta  |tr "\t" "\n" > $transcript_rd.fil.fa



