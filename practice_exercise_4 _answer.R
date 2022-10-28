#Introduction to R - ARCHIVED
#Creating vectors/factors and dataframes

sex <- c("M", "F","M", "F","M", "F","M", "F","M", "F","M", "F")

stage <- c("I", "II","II", "I","II", "II","I", "II","II", "I","II", "II")

treatment <- c("A", "A","A", "A","B", "B","B", "B","P", "P","P", "P")

myc <- c("M", "F","M", "F","M", "F","M", "F","M", "F","M", "F")# saved vectors/factors as variables and used c() or rep() function to create

#Put them together into a dataframe called meta.
meta <- data.frame(sex, stage, treatment, myc)

# used data.frame() to
#create the table
#Use the rownames() function to assign row names to the dataframe (Hint: you can type out the row names as a vector, or if you want the process go faster try exploring the paste() function).

rownames(meta) <- c("sample1", "sample2","sample3", "sample4","sample5", "sample6","sample7","sample8","sample9", "sample10","sample11", "sample12")


#Your finished metadata table should have information for the variables sex, stage, treatment, and myc levels:


#Subsetting vectors/factors and dataframes
#Using the meta data frame from question #1, write out the R code you would use to perform the following operations (questions DO NOT build upon each other):

#return only the treatment and sex columns using []:
  meta[ , c(1,3)]
#return the treatment values for samples 5, 7, 9, and 10 using []:
  meta[c(5,7,9,10), 3]
#use filter() to return all data for those samples receiving treatment P:
  filter(meta, treatment == "P")
#use filter()/select() to return only the stage and treatment data for those samples with myc > 5000:
  filter(meta, myc > 5000) %>% select(stage, treatment)
#remove the treatment column from the dataset using []:
  meta[, -3]
#remove samples 7, 8 and 9 from the dataset using []:
  meta[-7:-9, ]
#keep only samples 1-6 using []:
  meta [1:6, ]
#add a column called pre_treatment to the beginning of the dataframe with the values T, F, F, F, T, T, F, T, F, F, T, T (Hint: use cbind()):
  pre_treatment <- c(T, F, F, F, T, T, F, T, F, F, T, T)

cbind(pre_treatment, meta)

#change the names of the columns to: "A", "B", "C", "D":
  colnames(meta) <- c("A", "B", "C", "D")


  #Extracting components from lists
#Create a new list, list_hw with three components, the glengths vector, the dataframe df, and number value. Use this list to answer the questions below . list_hw has the following structure (NOTE: the components of this list are not currently named):
  # Create a list containing a vector, a matrix and a list.

  species <- c("ecoli","human","corn")
  glengths <- c(4.6,  3000.0, 50000.0)
  number <- c(8)
  # Show the list.
  print(list_hw)

  data.frame(species, glengths)


#Write out the R code you would use to perform the following operations (questions DO NOT build upon each other):

  #return the second component of the list:
  list_hw[[2]]
#return 50000.0 from the first component of the list:
  list_hw[[1]][3]
#return the value human from the second component:
  list_hw[[2]][2, 1]
#give the components of the list the following names: "genome_lengths", "genomes", "record":
  names(list_hw) <- c("genome_lengths","genomes","record")

#Creating figures with ggplot2


#Create the same plot as above using ggplot2 using the provided metadata and counts datasets. The metadata table describes an experiment that you have setup for RNA-seq analysis, while the associated count matrix gives the normalized counts for each sample for every gene. Download the count matrix and metadata using the links provided.

#Follow the instructions below to build your plot. Write the code you used and provide the final image.

#Read in the metadata file using: meta
read.delim("Mov10_full_meta.txt", sep="\t", row.names=1)

#Read in the count matrix file using: data <-
  read.delim("normalized_counts.txt", sep="\t", row.names=1)

#Create a vector called expression that contains the normalized count values from the row in data that corresponds to the MOV10 gene.
mov10 <- c("MOV10_knockdown", "low")
normalized_counts <- c(36.4293407,43.842016,53.261952,49.0812334,58.148548,40.0925855)
expression <- data["Mov10","normalized_counts"]
#Check the class of this expression vector. data.frame
#Then, will need to convert this to a numeric vector using as.numeric(expression)

class(expression)

expression <- as.numeric(expression)

class(expression)
#Bind that vector to your metadata data frame (meta) and call the new data frame df.
df <- cbind(meta, expression) #or

df <- data.frame(meta, expression)


#Create a ggplot by constructing the plot line by line:

 # Initialize a ggplot with your df as input.

#Add the geom_jitter() geometric object with the required aesthetics

#Color the points based on sampletype

#Add the theme_bw() layer

#Add the title "Expression of MOV10" to the plot

#Change the x-axis label to be blank

#Change the y-axis label to "Normalized counts"

#Using theme() change the following properties of the plot:

 # Remove the legend (Hint: use ?theme help and scroll down to legend.position)

#Change the plot title size to 1.5x the default and center align

#Change the axis title to 1.5x the default size

#Change the size of the axis text only on the y-axis to 1.25x the default size

#Rotate the x-axis text to 45 degrees using axis.text.x=element_text(angle=45, hjust=1)

ggplot(df) +
  geom_jitter(aes(x= sampletype, y= expression, color = sampletype)) +
  theme_bw() +
  ggtitle("Expression of MOV10") +
  xlab(NULL) +
  ylab("Normalized counts") +
  theme(legend.position = "none",
        plot.title=element_text(hjust=0.5, size=rel(1.5)),
        axis.text=element_text(size=rel(1.25)),
        axis.title=element_text(size=rel(1.5)),
        axis.text.x=element_text(angle=45, hjust=1))
