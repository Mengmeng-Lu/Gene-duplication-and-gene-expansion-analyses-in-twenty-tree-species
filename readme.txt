sh  ./get_transcript_with_high_tpm.sh  <transcript.fa>  <transcript_RSEM.genes.results>

sh  ./filter_by_blast.sh    <transcript.fa> 

sh ./annotation_for_transcript.sh <transcriptome.fa>
