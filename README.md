# Age and Sex Bias in Microarray Human Gene Expression
For single gene, we follow the following steps:
- Download description files (HTML) of each sample 
- Find the age/sex information (if any)
- Download the .CEL files corresponding to samples which have age/sex information.
- Process the .CEL files to convert raw expression values to $z$-score
- Build an ML model which determines the sex bias in a given age group and  vice-versa.
- Show results of age/sex bias for every particular gene.

### Determine the age/sex bias of biological processes. 
steps:
- For every sample, check which GOBP (Gene Ontology Biological Process) is more enriched than others using a Fisher's test of GOStat.
- Collect the anomalously enriched GOBP terms.
- Keep those GOBP terms which are significantly observed in various samples.
- Reject genesets of size less than 15 and more than 190 to get rid of general bio-logical processes and insignificant processes.
- For the GOBP term of interest perform a permutation test to check the sex/age bias.
- Show the results of age/sex bias for every particular GOBP.
