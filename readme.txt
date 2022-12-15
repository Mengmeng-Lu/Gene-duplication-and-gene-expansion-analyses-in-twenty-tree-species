This repo compasses the scripts that I used for our manuscript "Comparative studies reveal convergent evolution of pathogen response gene families in twenty forest tree species"


sh  ./get_transcript_with_high_tpm.sh  <transcript.fa>  <transcript_RSEM.genes.results>

sh  ./filter_by_blast.sh    <transcript.fa> 

sh ./annotation_for_transcript.sh <transcriptome.fa>
