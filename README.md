# Age and Sex Bias in Microarray Human Gene Expression
For single gene, we follow the following steps:
- Download description files (HTML) of each sample
- Find the age/sex information (if any)
    - Check the *microarray.ipynb* notebook 
- Download the .CEL files corresponding to samples which have age/sex information.
    - Check the download.sh script
- Process the .CEL files to convert raw expression values to $z$-score
    - check the get_z_score_parallel.r
- Build an ML model which determines the sex bias in a given age group and  vice-versa.
    - check the *model.ipynb* notebook
- Show results of age/sex bias for every particular gene.
    - check the *results.ipynb* notebook

### Determine the age/sex bias of biological processes. 
steps:
- Download the GO database. Keep the biological processes(BP).
- Reject genesets of size less than 15 and more than 190 to get rid of general bio-logical processes and insignificant processes.
- Perform permutation test on each GOBP.
- Find the Sex bias and the age trend of the bias of the biological processes.
- Check *results.ipynb*.
