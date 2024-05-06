source("/project/higgslab/yli/SNP/Tools/sasquatch/R_utility/functions_sasq_r_utility.R")

frag.type <- "DNase"

pnorm.tag <- "h_ery_1"

data.dir <- file.path("/project/higgslab/yli/SNP/Tools/sasquatch/data/human",frag.type)

tissue <- "ENCODE_Duke_K562_V2_merged"

library(BSgenome)
library(BSgenome.Hsapiens.UCSC.hg19)
genome <- BSgenome.Hsapiens.UCSC.hg19

args <- commandArgs(trailingOnly = TRUE)

# enough parameters
if(length(args) < 2) {
  stop("Not enough arguments. Please provide two numbers.")
}

# get number
n <- as.numeric(args[1])
i <- as.numeric(args[2])

chr <- "chr16"
start.pos <- 152242+ceiling((i-1)*(234429-152242)/n)
end.pos=ceiling(i*(234429-152242)/n)+start.pos

seq <- as.character(getSeq(genome, "chr16", start=start.pos-6, end=end.pos+6))

df.insilico <- InSilicoMutation(sequence=seq,
    kl=7,
    chr="chr16",
    position=start.pos,
    report="all",
    damage.mode="exhaustive",
    tissue=tissue,
    data.dir=data.dir,
    pnorm.tag=pnorm.tag,
    vocab.flag=TRUE,
    frag.type=frag.type,
    progress.bar = FALSE
)
file_name1 = paste(tissue,'_',start.pos,"_",end.pos,'_(',i,'_',n,')_insilicomut.csv',sep='')
file_name2 = paste(tissue,'_',start.pos,"_",end.pos,'_(',i,'_',n,')_insilicomut.pdf',sep='')


write.csv(df.insilico, file.path("/project/higgslab/yli/SNP/plot",file_name1))


InSilicoMutation.plot <- InSilicoMutationPlot(df.insilico, ylim=c(-4,4))

pdf(file.path("/project/higgslab/yli/SNP/plot",file_name2))
plot(InSilicoMutation.plot)
dev.off()
