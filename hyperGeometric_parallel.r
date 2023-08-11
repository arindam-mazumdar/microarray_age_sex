library(foreach)
library(doParallel)


# Set the number of cores to be used for parallel execution
num_cores <- 6

# Register a parallel backend using doParallel
cl <- makeCluster(num_cores)
registerDoParallel(cl)

clusterEvalQ(cl, {
library("org.Hs.eg.db")
library("GSEABase")
library("GOstats")
library(dplyr)

})


sample_ids = read.csv('/media/arindam/DATA/Arjun_project/degs/filenames.csv')$filenames

# Define your loop using foreach
foreach(i = sample_ids[1:6], .errorhandling = "pass") %dopar% {
  # Code to execute for each iteration

frame = toTable(org.Hs.egGO)

# Select those go_ids which has more than 10 and less than 200 genes

grouped_frame = frame %>% group_by(go_id) %>% summarise(gene_num = n() )
important_goids = subset(grouped_frame, gene_num < 190 & gene_num > 15)

new_frame = frame[frame$go_id %in% important_goids$go_id, ]


goframeData = data.frame(new_frame$go_id, new_frame$Evidence, new_frame$gene_id)
goFrame=GOFrame(goframeData,organism="Homo sapiens")
goAllFrame=GOAllFrame(goFrame)

gsc <- GeneSetCollection(goAllFrame, setType = GOCollection())


universe = Lkeys(org.Hs.egGO)

###################################################


input_file = paste0('/media/arindam/DATA/Arjun_project/degs/',i)
  
degs= read.csv(input_file) 

genes = as.character(degs$ENTREZ_GENE_ID)[1:190]

params <- GSEAGOHyperGParams(name="GSEA based annot Params",
    geneSetCollection=gsc,
    geneIds = genes,
    universeGeneIds = universe,
    ontology = "BP",
    pvalueCutoff = 0.05,
    conditional = FALSE,
    testDirection = "over")
    
    
Over <- hyperGTest(params)


output_path = paste0('/media/arindam/DATA/Arjun_project/gsea_cut_off_190/',i)
write.csv(summary(Over), file = output_path)
#print(paste0('file ',i,' done'))

}

stopCluster(cl)

