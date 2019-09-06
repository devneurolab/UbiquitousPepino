#Load appropriate packages
library(readr)
library(dplyr)

#Load the two files tables that we'll work on. One has the contigs in TRINITY_DN format with their respective expression data, 
#while the other has a namemap for how the contigs were renamed to Transcript_XXXX format

Trinity.fasta.dammit.namemap <-read_csv("./Trinity.fasta.dammit.namemap.csv")

Pepino_edgeR_Cv3dpe <- read_csv("./Pepino_edgeR_Cv3dpe.csv")

#Plug the files into variables as tibbles
tableNameMap <- as_tibble(Trinity.fasta.dammit.namemap)

tableExpression <- as_tibble(Pepino_edgeR_Cv3dpe)

#Fix the Name Map naming format for the TRINITY_DN column

tableNameMap_1 <- gsub(" .*", "", tableNameMap$original)
tableNameMap_1_fixed <-as_tibble(tableNameMap_1)

tableNameMap_2 <- gsub(" .*", "", tableNameMap$renamed)
tableNameMap_2_fixed <-as_tibble(tableNameMap_2)

#Rename column in one of the tables to avoid further troubles

colnames(tableNameMap_1_fixed) <-("Old_Name")

#Check everything's fine
View(tableNameMap_1_fixed)
View(tableNameMap_2_fixed)
View(tableNameMap)

#Combine the two tables for NameMaps

Final_NameMap<- merge(tableNameMap_1_fixed,tableNameMap_2_fixed, by="row.names")
View(Final_NameMap)
Final_NameMap$Row.names=NULL

#Save the NameMaps.
save(Final_NameMap,file="Final_NameMap.rda")

#Combine NameMap with Expression table.
Final_CombinedTable <- Final_NameMap %>% inner_join(tableExpression, by =c("Old_Name"="X1")) 
View(Final_CombinedTable)

#Save it.
save(Final_CombinedTable, file="Final_CombinedTable.rda")
