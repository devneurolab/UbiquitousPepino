#Load appropriate packages
library(readr)
library(dplyr)
#I am an absolute noob at this so be sure to run the other two combination scripts first to have all the required files in the Global Environment and be able to
#create the huge table.

# They're both data frames. You'll need:
View(Final_CombinedTable)
View(tableCombined_2)

#Final_CombinedTable has the expression of the contigs in terms of logFC, logCPM, p-value and the old and new names. tableCombined_2 has the contig names (new)
#and GO analysis for each.

#Let's combine both by matching the "Transcript_XXXXX" names by column. In this case: value=q_name by column.

Final_Contigs_Table <- Final_CombinedTable %>% inner_join(tableCombined_2, by = c("value"="q_name"))

View(Final_Contigs_Table)

#Save it as a .csv for later analysis.

write_csv(Final_Contigs_Table, "./Final_Contigs_Table.csv")

#From here on out, we start constructing our frames for the GO analysis


goframeData = data.frame(Final_Contigs_Table$GONumber, Final_Contigs_Table$Evidence, Final_Contigs_Table$value)



goframeData$Final_Contigs_Table.GONumber <- sub("^", "GO:", goframeData$Final_Contigs_Table.GONumber)

goFrame=GOFrame(goframeData, organism="Holothuria glaberrima")


#Keep in mind that the universe is ALL of your genes, and that the "genes" per se are the differentially 
#expressed genes (you have to establish a p-value cutoff yourself)
goAllFrame=GOAllFrame(goFrame)

gsc <- GeneSetCollection(goAllFrame, setType = GOCollection())

universe <- Final_Contigs_Table$value

genes <- Final_Contigs_Table$value[Final_Contigs_Table$FDR < 0.01]

#Parameters for molecular function (MF) GO
params_mf <- GSEAGOHyperGParams(name="My Custom GSEA based annot Params_MF",
                             geneSetCollection=gsc,
                             geneIds=genes,
                             universeGeneIds=universe,
                             ontology="MF",
                             pvalueCutoff=0.05,
                             conditional=FALSE,
                             testDirection="over")

Over_MF <- hyperGTest(params_mf)

#Parameters for cellular component (CC) GO
params_cc <- GSEAGOHyperGParams(name="My Custom GSEA based annot Params_CC",
                                geneSetCollection=gsc,
                                geneIds=genes,
                                universeGeneIds=universe,
                                ontology="CC",
                                pvalueCutoff=0.05,
                                conditional=FALSE,
                                testDirection="over")

Over_CC <- hyperGTest(params_cc)

#Parameters for biological process (BP) GO
params_bp <- GSEAGOHyperGParams(name="My Custom GSEA based annot Params_BP",
                                geneSetCollection=gsc,
                                geneIds=genes,
                                universeGeneIds=universe,
                                ontology="BP",
                                pvalueCutoff=0.05,
                                conditional=FALSE,
                                testDirection="over")

Over_BP <- hyperGTest(params_bp)

#Save all your reports so that your PI can actually read them
htmlReport(Over_MF, file="Molecular_Function_GO.html")
htmlReport(Over_CC, file="Cellular_Component_GO.html")
htmlReport(Over_BP, file="Biological_Process_GO.html")


 
