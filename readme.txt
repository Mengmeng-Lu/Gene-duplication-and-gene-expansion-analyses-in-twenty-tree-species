This repo encompasses the scripts that I used for our manuscript "Comparative transcriptomics reveals divergence in pathogen response gene families amongst 20 forest tree species". 

The article has been published:

Mengmeng Lu, Min Cao, Jie Yang, Nathan G Swenson, Comparative transcriptomics reveals divergence in pathogen response gene families amongst 20 forest tree species, G3 Genes|Genomes|Genetics, 2023;
https://doi.org/10.1093/g3journal/jkad233


To run the code:

sh  ./get_transcript_with_high_tpm.sh  <transcript.fa>  <transcript_RSEM.genes.results>

sh  ./filter_by_blast.sh    <transcript.fa> 

sh ./annotation_for_transcript.sh <transcriptome.fa>
