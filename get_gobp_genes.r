library("org.Hs.eg.db")
library(dplyr)

frame <- toTable(org.Hs.egGO)


# Select those go_ids which has more than 15 and less than 190 genes

grouped_frame = frame %>% group_by(go_id) %>% summarise(gene_num = n() )
important_goids = subset(grouped_frame, gene_num < 190 & gene_num > 15)

new_frame = frame[frame$go_id %in% important_goids$go_id, ]


new_frame$terms <- Term(new_frame$go_id)

new_frame = new_frame[new_frame$Ontology == 'BP', ]


write.csv(new_frame, 'GO_db.csv')
