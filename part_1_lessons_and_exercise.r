# Intro to R Lesson

# Interaction with R
#I am adding 3 and 5, R is fun!
3+5

# type ctrl and '-' at the same time to bring
##the operation  "<-" Value one the right, variable on the left

x <- 3
y <- 5
y
x+y

number <- x + y
number <- 5 + y
number <- 5+ 10

#Exercises

#Try changing the value of the variable x to 5. What happens to number?
x <- 5
#Now try changing the value of variable y to contain the value 10. What do you need to do, to update the variable number?
y <- 10
number <- x + y

# Create a numeric vector and store the vector as a variable called 'glengths'
glengths <- c(4.6, 3000, 50000)
glengths


# Create a character vector and store the vector as a variable called 'species'
species <- c("ecoli", "human", "corn")
species

# Forget to put quotes around corn
species <- c("ecoli", "human", corn)


# Create a character vector and store the vector as a variable called 'species'
species <- c("ecoli", "human", "corn")

# Exercise

#  Try to create a vector of numeric and character values by combining the two vectors that we just created (glengths and species). Assign this combined vector to a new variable called combined. Hint: you will need to use the combine c() function to do this. Print the combined vector in the console, what looks different compared to the original vectors?

combined <- c(glengths, species)

# Create a character vector and store the vector as a variable called 'expression'
expression <- c("low", "high", "medium", "high", "low", "medium", "high")


# Turn 'expression' vector into a factor
expression <- factor(expression)


#Exercises

#Let’s say that in our experimental analyses, we are working with three different sets of cells: normal, cells knocked out for geneA (a very exciting gene), and cells overexpressing geneA. We have three replicates for each celltype.

#Create a vector named samplegroup with nine elements: 3 control (“CTL”) values, 3 knock-out (“KO”) values, and 3 over-expressing (“OE”) values.
samplegroup <- c("CTL", "CTL", "CTL", "KO", "KO", "KO", "OE", "OE", "OE")
#Turn samplegroup into a factor data structure.
samplegroup <- factor(samplegroup)

# Create a data frame and store it as a variable called 'df'
df <- data.frame(species, glengths)
df

#Exercise

#Create a data frame called favorite_books with the following vectors as columns:

titles <- c("Catch-22", "Pride and Prejudice", "Nineteen Eighty Four")
pages <- c(453, 432, 328)

list1 <- list(species, df, number)


# Let’s type list1 and print to the console by running it.

list1

# Exercise

#Create a list called list2 containing species, glengths, and number.
list2 <- list(species, glengths, number)


#function_name(input)

getwd()

glengths <- c(glengths, 90) # adding at the end
glengths <- c(30, glengths) # adding at the beginning

sqrt(81)

sqrt(glengths)

round(3.14159)
?round
args(round)
round(3.14159, digits=2)

round(3.14159, 2)


#Exercise

# Let’s use base R function to calculate mean value of the glengths vector. You might need to search online to find what function can perform this task.
mean(glengths)

# Create a new vector test <- c(1, NA, 2, 3, NA, 4). Use the same base R function from exercise 1 (with addition of proper argument), and calculate mean value of the test vector. The output should be 2.5.
#NOTE: In R, missing values are represented by the symbol NA (not available). It’s a way to make sure that users know they have missing data, and make a conscious decision on how to deal with it. There are ways to ignore NA during statistical calculation, or to remove NA from the vector. If you want more information related to missing data or NA you can go to this page (please note that there are many advanced concepts on that page that have not been covered in class).

test <- c(1, NA, 2, 3, NA, 4)
mean(test, na.rm=TRUE)

#Another commonly used base function is sort(). Use this function to sort the glengths vector in descending order.
sort(glengths, decreasing = TRUE)

#structure of a function
#name_of_function <- function(argument1, argument2) {
#statements or code that does something
#return(something)
#}


square_it <- function(x) {
  square <- x * x
  return(square)
}

square_it(5)


square_it <- function(x) {
  x * x
}

# Exercise

#Write a function called multiply_it, which takes two inputs: a numeric value x, and a numeric value y. The function will return the product of these two numeric values, which is x * y. For example, multiply_it(x=4, y=6) will return output 24.
multiply_it(x=4, y=6)

multiply_it <- function(x,y) {
  product <- x * y
  return(product)
}

#Reading data into R


metadata <- read.csv(file="data/mouse_exp_design.csv")

# OR
metadata <- read.csv(file="data/mouse_exp_design.txt")

#Exercise 1

#Download this tab-delimited .txt file and save it in your project’s data folder.
#Read it in to R using read.table() with the approriate arguments and store it as the variable proj_summary. To figure out the appropriate arguments to use with read.table(), keep the following in mind:
   #all the columns in the input text file have column name/headers
   #you want the first column of the text file to be used as row names (hint: look up the input for the row.names = argument in read.table())
#Display the contents of proj_summary in your console
proj_summary <- read.table(file = "data/project-summary.txt", header = TRUE, row.names = 1)

#Inspecting data structures
head(metadata)


#Exercise 2

#Use the class() function on glengths and metadata, how does the output differ between the two?
class(glengths)
class(metadata)
  #Use the summary() function on the proj_summary dataframe, what is the median “rRNA_rate”?
summary(proj_summary)
  #How long is the samplegroup factor?
length(samplegroup)
  #What are the dimensions of the proj_summary dataframe?
dim(proj_summary)
  #When you use the rownames() function on metadata, what is the data structure of the output?
str(rownames(metadata))
  #[Optional] How many elements in (how long is) the output of colnames(proj_summary)? Don’t count, but use another function to determine this.
length(colnames(proj_summary))

#Day 2 Activities
#Custom Functions - Let’s create a function temp_conv(), which converts the temperature in Fahrenheit (input) to the temperature in Kelvin (output).
#We could perform a two-step calculation: first convert from Fahrenheit to Celsius, and then convert from Celsius to Kelvin.
#The formula for these two calculations are as follows: temp_c = (temp_f - 32) * 5 / 9; temp_k = temp_c + 273.15. To test your function,
#if your input is 70, the result of temp_conv(70) should be 294.2611.
temp_conv <- function(temp_f) {
  temp_c = (temp_f - 32) * 5 / 9
  temp_k = temp_c + 273.15
  return (temp_k)
}
#Nesting Functions - Now we want to round the temperature in Kelvin (output of temp_conv()) to a single decimal place. Use the round() function with the newly-created temp_conv() function to achieve this in one line of code. If your input is 70, the output should now be 294.3.
round(temp_conv(70), digits = 1)
