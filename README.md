# Ubiquitous-Pepino

This is a working repository to store and share all of the necessary scripts for the sea cucumber work I've been on to. 

To anyone reading:
Keep in mind I'm a biologist so my code is messy and inefficient, I intend to practice and get better at this, so think of this as a timeline of my progress as a Bioinformatician.

Inside this repository you will find:

-Code used for quality trimming and filtering of raw reads

-Code for digital normalization of our filtered data

-Code used for de-novo transcriptome assembly (using Trinity)

-Code for downstream, quantitative analysis of our transcriptome database, including differential expression analysis

-Scripts used to construct messy tables that were used for GO enrinchment analysis and KEGG analysis (hopefully)

IMPORTANT NOTICES:
If you're here to run the scripts for the GO tables, they must be run in the following order:
1.Expression or Namemap (order is irrelevant here)
2.Combine the final tables
Otherwise, you won't get the final table as needed. 

Also, you will need a few files which are too big to store here in Github. If needed, I can provide them, just send me a message.
