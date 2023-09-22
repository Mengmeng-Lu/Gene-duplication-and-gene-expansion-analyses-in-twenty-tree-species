This repo encompasses the scripts that I used for our manuscript "Comparative transcriptomics reveals divergence in pathogen response gene families amongst twenty forest tree species". 

doi: https://doi.org/10.1101/2023.03.06.531373


To run the code:

sh  ./get_transcript_with_high_tpm.sh  <transcript.fa>  <transcript_RSEM.genes.results>

sh  ./filter_by_blast.sh    <transcript.fa> 

sh ./annotation_for_transcript.sh <transcriptome.fa>
