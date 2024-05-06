#module load R-cbrg/current
source("/project/higgslab/yli/SNP/Tools/sasquatch/R_utility/functions_sasq_r_utility.R")

frag.type <- "DNase"

pnorm.tag <- "h_ery_1"

data.dir <- file.path("/project/higgslab/yli/SNP/Tools/sasquatch/data/human",frag.type)

list.files(path = data.dir, full.names = FALSE)[c(1,7,36,41)]

tissue <- "Dummy_tissue_example"

single.plot <- PlotSingleKmer(
    kmer="WACGTG", #selected k-mer
    tissue=tissue, #selecet tissue
    pnorm.tag=pnorm.tag,
    plot.shoulders=FALSE, #decide if to estimate and
    # plot the footprint shoulder regions
    data.dir=data.dir, #path to data repository
    frag.type=frag.type, #fragmentation type ["DNase" or "ATAC"]
    smooth=TRUE #flag if to smooth the cut profile
)


## size-zero empty pdf file
print(single.plot)
ggsave(single.plot,"/project/higgslab/yli/my_plot.png")

pdf('/project/higgslab/yli/SNP/DATA/my_plot.pdf')
plot(single.plot)
dev.off()

sfr <- GetSFR(
kmer = "WACGTG",
tissue = tissue,
data.dir = data.dir,
pnorm.tag=pnorm.tag,
vocab.file = TRUE, #flag if to use a vocabulary file
frag.type = frag.type
)

print(sfr)
#> [1] 1.32935

##############
library(BSgenome)
library(BSgenome.Hsapiens.UCSC.hg19)
genome <- BSgenome.Hsapiens.UCSC.hg19

chr <- "chr16"
start.pos <- 145852
end.pos <- start.pos + 30

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

InSilicoMutation.plot <- InSilicoMutationPlot(df.insilico, ylim=c(-4,4))

plot(InSilicoMutation.plot)