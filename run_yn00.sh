### Prepare the pairwise alignment 

./mafft-7.490-with-extensions/core/mafft --thread 4 $input > $input.aln
		
### Convert FASTA format to PHYLIP format

perl fastatophylip.pl  -f $input.aln -o $input.aln.phy
	
### If necessary, edit the Phylip output to make sure its length are 3*N.

### For running YN00, replace stop codon to gaps, if necessary.

./paml4.9j/bin/yn00  yn00.ctl

