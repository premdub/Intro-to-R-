#Data subsetting with base R: vectors and factors
#Vector
age <- c(15, 22, 45, 52, 73, 81)
age[5]
age[-5]

age[c(3,5,6)]   ## nested

# OR

## create a vector first then select
idx <- c(3,5,6) # create vector of the elements of interest
age[idx]
age[1:4]

#Exercises

#Create a vector called alphabets with the following letters, C, D, X, L, F.
#Use the associated indices along with [ ] to do the following:
  #only display C, D and F
#display all except X
#display the letters in the opposite order (F, L, X, D, C)
alphabets <- c(C, D, X, L, F)
alphabets[1:3]
alphabets[1,2,4,5]
alphabets[5,4,3,2,1]
#--------------------------------------
age
age > 50


age > 50 | age < 18

age

age[age > 50 | age < 18]  ## nested

# OR

## create a vector first then select
idx <- age > 50 | age < 18
age[idx]


which(age > 50 | age < 18)

age[which(age > 50 | age < 18)]  ## nested

# OR

## create a vector first then select
idx_num <- which(age > 50 | age < 18)
age[idx_num]

#Factors

expression[expression == "high"]    ## This will only return those elements in the factor equal to "high"

#Exercise

#Extract only those elements in samplegroup that are not KO (nesting the logical operation is optional).
idx <- samplegroup != "KO"
samplegroup[idx]

#Releveling factors
expression
str(expression)

expression <- factor(expression, levels=c("low", "medium", "high"))     # you can re-factor a factor

str(expression)

#Exercise

#Use the samplegroup factor we created in a previous lesson, and relevel it such that KO is the first level followed by CTL and OE.

factor(samplegroup, levels = c("KO", "CTL", "OE")

#Packages and Libraries

sessionInfo() #Print version information about R, the OS and attached or loaded packages

# OR

search() #Gives a list of attached packages


install.packages("ggplot2")
library(ggplot2)


#Exercise

#The ggplot2 package is part of the tidyverse suite of integrated packages which was designed to work together to make common data science operations more user-friendly. We will be using the tidyverse suite in later lessons, and so let’s install it. NOTE: This suite of packages is only available in CRAN.
install.packages("tidyverse")
library(tidyverse)
sessionInfo()

#Data wrangling: dataframes, matrices, and lists
# Extract value 'Wt'
metadata[1, 1]

# Extract value '1'
metadata[1, 3]

# Extract third row
metadata[3, ]

# Extract third column
metadata[ , 3]

# Extract third column as a data frame
metadata[ , 3, drop = FALSE]


# Dataframe containing first two columns
metadata[ , 1:2]


# Data frame containing first, third and sixth rows
metadata[c(1,3,6), ]

# Extract the celltype column for the first three samples
metadata[c("sample1", "sample2", "sample3") , "celltype"]

# Check column names of metadata data frame
colnames(metadata)

# Check row names of metadata data frame
rownames(metadata)


# Extract the genotype column
metadata$genotype

# Extract the first five values/elements of the genotype column
metadata$genotype[1:5]

#Exercises

#Return a data frame with only the genotype and replicate column values for sample2 and sample8.
metadata[c("sample2", "sample8"), c("genotype", "replicate")] # or
metadata[c(2,8), c(1,3)]
#Return the fourth and ninth values of the replicate column.

metadata$replicate[c(4,9)] # or
metadata[c(4, 9), "replicate"]
#Extract the replicate column as a data frame.
metadata[, "replicate", drop = FALSE]

#Selecting using indices with logical operators
metadata$celltype == "typeA"

logical_idx <- metadata$celltype == "typeA"

metadata[logical_idx, ]

which(metadata$celltype == "typeA")

idx <- which(metadata$celltype == "typeA")

metadata[idx, ]

which(metadata$replicate > 1)

idx <- which(metadata$replicate > 1)
metadata[idx, ]

metadata[which(metadata$replicate > 1), ]

sub_meta <- metadata[which(metadata$replicate > 1), ]

#Exercise

#Subset the metadata dataframe to return only the rows of data with a genotype of KO.
idx <- which(metadata$genotype=="KO")
metadata[idx, ]

#List
list1[[2]]

comp2 <- list1[[2]]
class(comp2)

list1[[1]]

#Exercises

#Create a list named random with the following components: metadata, age, list1, samplegroup, and number.
random <- list(metadata, age, list1, samplegroup, number)

#Extract the samplegroup component.
random[[4]]


names(list1)

# Name components of the list
names(list1) <- c("species", "df", "number")

names(list1)

# Extract 'df' component
list1$df

#Exercise

#Let’s practice combining ways to extract data from the data structures we have covered so far:

 # Set names for the random list you created in the last exercise.
names(random) <- c("metadata", "age", "list1", "samplegroup", "number")
#Extract the age component using the $ notation
random$age

#Logical operators for identifying matching elements

rpkm_data <- read.csv("data/counts.rpkm.csv")
head(rpkm_data)
ncol(rpkm_data)
nrow(metadata)

#The %in% operator

vector1 %in% vector2

A <- c(1,3,5,7,9,11)   # odd numbers
B <- c(2,4,6,8,10,12)  # even numbers

# test to see if each of the elements of A is in B
A %in% B

intersection <- A %in% B
intersection

A[intersection]

any(A %in% B)

all(A %in% B)

#Exercise 1

#Using the A and B vectors created above, evaluate each element in B to see if there is a match in A
B %in% A
#Subset the B vector to only return those values that are also in A.
B[B %in% A]


A <- c(10,20,30,40,50)
B <- c(50,40,30,20,10)  # same numbers but backwards

# test to see if each element of A is in B
A %in% B

# test to see if each element of A is in the same position in B
A == B

# use all() to check if they are a perfect match
all(A == B)

x <- rownames(metadata)
y <- colnames(rpkm_data)

all(x %in% y)
all(rownames(metadata) %in% colnames(rpkm_data))
x == y
all(x == y)

#Exercise 2
important_genes <- c("ENSMUSG00000083700", "ENSMUSG00000080990", "ENSMUSG00000065619", "ENSMUSG00000047945", "ENSMUSG00000081010", "ENSMUSG00000030970")

#Use the %in% operator to determine if all of these genes are present in the row names of the rpkm_data data frame.
important_genes %in% rownames(rpkm_data)
#Extract the rows from rpkm_data that correspond to these 6 genes using [] and the %in% operator. Double check the row names to ensure that you are extracting the correct rows.
idx <- rownames(rpkm_data) %in% important_genes
ans <- rpkm_data[idx, ]
idx2 <- which(rownames(rpkm_data) %in% important_genes)
ans2 <- rpkm_data[idx2, ]
#Bonus question: Extract the rows from rpkm_data that correspond to these 6 genes using [], but without using the %in% operator.
ans3 <- rpkm_data[important_genes, ]

#Advanced R, reordering to match datasets
teaching_team <- c("Jihe", "Mary", "Meeta", "Radhika")

# Extracting values from a vector
teaching_team[c(2, 4)]
teaching_team
# Extracting values and reordering them
teaching_team[c(4, 2)]
# Extracting all values and reordering them
teaching_team[c(4, 2, 1, 3)]
# Saving the results to a variable
reorder_teach <- teaching_team[c(4, 2, 1, 3)]

#Exercise
#Now that we know how to reorder using indices, let’s try to use it to reorder the contents of one vector to match the contents of another. Let’s create the vectors first and second as detailed below:
first <- c("A","B","C","D","E")
second <- c("B","D","E","A","C")  # same letters but different order

#The match function
match(first,second)
# Saving indices for how to reorder `second` to match `first`
reorder_idx <- match(first,second)
# Reordering the second vector to match the order of the first vector
second[reorder_idx]
# Reordering and saving the output to a variable
second_reordered <- second[reorder_idx]
first <- c("A","B","C","D","E")
second <- c("D","B","A")  # remove values

match(first,second)

second[match(first, second)]

# Check row names of the metadata
rownames(metadata)

# Check the column names of the counts data
colnames(rpkm_data)

genomic_idx <- match(rownames(metadata), colnames(rpkm_data))
genomic_idx

# Reorder the counts data frame to have the sample names in the same order as the metadata data frame
rpkm_ordered  <- rpkm_data[ , genomic_idx]


# View the reordered counts
View(rpkm_ordered)
all(rownames(metadata) == colnames(rpkm_ordered))

#Exercises

#After talking with your collaborator, it becomes clear that sample2 and sample9 were actually from a different mouse background than the other samples and should not be part of our analysis. Create a new variable called subset_rpkm that has these columns removed from the rpkm_ordered data frame.
subset_rpkm <- rpkm_ordered[ , c(1,3:8,10:12)]  #or
subset_rpkm <- rpkm_ordered[ , -c(2,9)]
#Use the match() function to subset the metadata data frame so that the row names of the metadata data frame match the column names of the subset_rpkm data frame.
idx <- match(colnames(subset_rpkm), rownames(metadata))
metadata[idx, ]


#Plotting and data visualization in R

mean(rpkm_ordered$sample1)
library(purrr)  # Load the purrr

samplemeans <- map_dbl(rpkm_ordered, mean)

# Named vectors have a name assigned to each element instead of just referring to them as indices ([1], [2] and so on)
samplemeans

# Check length of the vector before adding it to the data frame
length(samplemeans)
# Create a numeric vector with ages. Note that there are 12 elements here
age_in_days <- c(40, 32, 38, 35, 41, 32, 34, 26, 28, 28, 30, 32)

# Add the new vector as the last column to the new_metadata dataframe
new_metadata <- data.frame(metadata, samplemeans, age_in_days)

# Take a look at the new_metadata object
View(new_metadata)
