library(readr)
library(dplyr)
Trinity_fasta_x_SPU_peptide_fasta_crbl <- read_csv("./Trinity.fasta.x.SPU_peptide.fasta.crbl.csv")

gene_info_table <- read_delim("./annotation.build8/gene_info_table.txt",
"\t", escape_double = FALSE, col_names = FALSE,
trim_ws = TRUE)

tableDammit <- as_tibble(Trinity_fasta_x_SPU_peptide_fasta_crbl)

tableCombined <- tableDammit %>% inner_join(gene_info_table, by = c("s_name" = "X2"))

save(tableCombined, file="tableCombined.rda")

# load with load("tableCombined.rda")
go_table <- read_delim("./annotation.build8/go_table.txt",
"\t", escape_double = FALSE, col_names = FALSE,
trim_ws = TRUE)

colnames(go_table) <- c("SPU", "GOCategory", "Description", "GONumber", "Evidence")

tableCombined_2 <- tableCombined %>% inner_join(go_table, by = c("s_name" = "SPU"))

save(tableCombined_2, file = "tableCombined2.rda")
