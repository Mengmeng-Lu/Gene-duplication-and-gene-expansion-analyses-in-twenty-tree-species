transcript_file=$1
rsem_gene_file=$2


mkdir rsem_result

awk '/^>/ {printf("%s%s\t",(N>0?"\n":""),$0);N++;next;} {printf("%s",$0);} END {printf("\n");}'< $transcript_file > ./rsem_result/$transcript_file.linear

awk '$6 > 1.5' $rsem_gene_file | awk '{print $1"\t"$6}'> ./rsem_result/$rsem_gene_file.tmp1

cd rsem_result

awk '{print $1"\t"$0}' $rsem_gene_file.tmp1 | awk '{gsub("Graph_","",$1)}1' |sed 's/ /\t/g'|awk '{gsub("_.*","",$1)}1'|sed 's/ /\t/g' > $rsem_gene_file.tmp2


#module load R
Rscript agg_max.R



sed 1d max.txt |awk '{print $1"_"$2}' >max.txt.key

awk '{print $1"_"$3"\t"$0}' $rsem_gene_file.tmp2 > $rsem_gene_file.tmp3

awk 'FNR==NR{a[$1];next}($1 in a)' max.txt.key $rsem_gene_file.tmp3|awk '{print ">"$3}' >sel.key

awk 'FNR==NR{a[$1];next}($1 in a)'   sel.key $transcript_file.linear |tr "\t" "\n" > TransLiG_fit.rsem_uniq.fa



