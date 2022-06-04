
library(readxl)
dataf4 <- read_excel("file.xlsx")
View(dataf4)

#head(dataf4)
# remove rows that contain NA values
ggplot(data=dataf, aes(x=logFC, y=PValue)) + geom_point()
p <- ggplot(data=dataf, aes(x=logFC, y=-log10(PValue))) + geom_point()
p <- ggplot(data=dataf, aes(x=logFC, y=-log10(PValue))) + geom_point() + theme_minimal()
p2 <- p + geom_vline(xintercept=c(-0.6, 0.6), col="red") +
  geom_hline(yintercept=-log10(0.05), col="red")
# The significantly differentially expressed genes are the ones found in the upper-left and upper-right corners.
# Add a column to the data frame to specify if they are UP- or DOWN- regulated (log2FoldChange respectively positive or negative)

# Re-plot but this time color the points with "diffexpressed"
p <- ggplot(data=dataf, aes(x=logFC, y=-log10(PValue), col=merged)) + geom_point() + theme_minimal()

# Add lines as before...
p2 <- p + geom_vline(xintercept=c(-0.6, 0.6), col="red") +
  geom_hline(yintercept=-log10(0.05), col="red")
## Change point color  

# 1. by default, it is assigned to the categories in an alphabetical order):
p3 <- p2 + scale_color_manual(values=c("blue", "green", "black"))

# 2. to automate a bit: ceate a named vector: the values are the colors to be used, the names are the categories they will be assigned to:
mycolors <- c("blue", "green", "black")
names(mycolors) <- c("DOWNCoding", "DOWNNoncoding", "UPCoding", "UPNonCoding", "nonsigcoding", "nonsignoncoding")
p3 <- p2 + scale_colour_manual(values = mycolors)
# Now write down the name of genes beside the points...
# Create a new column "delabel" to de, that will contain the name of genes differentially expressed (NA in case they are not)

ggplot(data=dataf, aes(x=logFC, y=-log10(PValue), col=Regulation, shape=Coding, label=id)) + 
  scale_shape_manual(values = c(5, 16)) +
  geom_point() + 
  theme_minimal() +
  geom_text()
library(ggrepel)
ggplot(data=dataf, aes(x=logFC, y=-log10(PValue), col=Regulation, shape=Coding, label=id)) +
  geom_point() + 
  theme_minimal() +
  geom_text_repel() +
  scale_color_manual(values=c("blue", "green", "black")) +
  geom_hline(yintercept=-log10(0.05), col="red")
