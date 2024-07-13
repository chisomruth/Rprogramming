### DS TOOLKITS- TOPIC 1  ###

#a)INSTALL R AND RSTUDIO b) INSTALL PACKAGES{tidyverse} 
?cor
args("cor")
cor
# Six fundamental data types in R to note;Numeric,Integer,Complex,Character,Logical
# These 5 data types are often combined to form data structures
int <- as.integer(2.99)
int
class(int)

comp <- 12 + 3i
comp
class(comp)

char <- "Ikorodu"
char
class(char)

a <- 12
b <- 22
log <- a > b #This will assign TRUE to log if a < b else FALSE
log
class(log)

dat <- as.Date.character("2022-02-22", format = "%Y-%m-%d")
dat
class(dat)

# Today's Date:
today <- Sys.time()
today
today <- Sys.Date()
today


### DESCRIPTIVE STATISTICS- TOPIC 2  ###

covid_data <- read.csv("C:/Users/YADTECH/Documents/Data_science/covid_19.csv")
covid_data

confirmed_summary <- covid_data %>%
  summarize(mean_total_confirmed = mean(total_confirmed),
            median_total_confirmed = median(total_confirmed),
            sd_total_confirmed = sd(total_confirmed))
confirmed_summary

library(esquisse)
library(ggplot2)  
library(plotly) 
esquisser(covid_data)

ggplot(covid_data, aes(x = states, y = total_confirmed)) +
  geom_bar(stat = "identity") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

ggplot(covid_data, aes(x=total_confirmed, y=states)) + 
  geom_boxplot(outlier.colour="red", outlier.shape=8,
               outlier.size=4)

covid_data2 <- covid_data %>% 
  filter(!(states == "Lagos"| states == "FCT" | states == "Kaduna"))

ggplot(covid_data2, aes(x = states, y = total_confirmed)) +
  geom_bar(stat = "identity", fill= "green") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

ggplot(covid_data2, aes(x=states, y=total_confirmed)) + 
  geom_boxplot(outlier.colour="red", outlier.shape=8,
               outlier.size=4)

oja <- read.csv(
  "C:/Users/YADTECH/Desktop/R/Datasets/nigeria_markets.csv")
oja

# Calculate the mean and the median of total_confirmed cases
covid_data %>%
  summarize(mean = mean(total_confirmed), median = median(total_confirmed))


### PROBABILITY DISTRIBUTION - TOPIC 3  ###

# Bernoulli distribution :
#   This distribution is used to describe a random variable that can take on two values,
# such as heads or tails.
# 
# The Bernoulli distribution arises as the result of a binary outcome
# 
# Bernoulli random variables take (only) the values 1 and 0 with probabilities of (say) p
# and 1−p
# respectively
# 

# Binomial distribution :
#   This distribution is used to describe a random variable that can take on a finite
# number of values, such as the number of heads that come up when you flip a coin 10 times.
# 
# Bernoulli & Binomial
# We talk of Bernoulli Distribution when we are looking at the success or failure of a 
# single Bernoulli trial while the Binomial Distribution represents the number of successes
# and failures in n independent Bernoulli trials for some given value of n.
x = rbinom(n = 5, size = 10, prob = 0.5)
plot(x, type = "h", xlab = "Number of Successes", ylab = "Probability")
x

# Poisson distribution:
#   This distribution is used to describe a random variable that measures the number of 
# times an event occurs in a fixed interval of time or space. For example, the number of 
# SAIL Data Fellowship participants that will visit the materials website in a day.
# 
# Some uses for the Poisson distribution
# Modeling event/time data
# 
# Modeling survival data
# 
# Approximating binomials when n
# is large and p
# is small

# Examples of calculating Poisson probabilities:

#Calculate the probability of 3 successes, given a mean of 5
dpois(3, 5)
#Calculate the probability of 5 successes, given a mean of 7
dpois(5, 7)

x = rpois(n = 10, lambda = 1)
plot(x, type = "h", xlab = "Number of Successes", ylab = "Probability")
x

ppois(3, lambda = 2.5 * 4)


x <- 1:4
x
lamb <- 2.5
sum(dpois(0:3, lamb) * dpois(x, lamb))

# If we flip a coin with success probablity 0.01
# five hundred times.
# What’s the probability of 2 or fewer successes?
pbinom(2, size = 500, prob = .01)
ppois(2, lambda=500 * .01)

# Normal distribution :
#   This distribution is the most common continuous probability distribution.
# It is often used to model data that is approximately bell-shaped. Theoretically it is the 
# only distribution where the approximatedmean = approximated median = mode
set.seed(234)
x = rnorm(n = 100, mean = 10, sd = 1)
x
plot(x, type = "h", xlab = "Trials", ylab = "Values")
hist(x, main = "Normal Distribution", col = "lightblue")

#Using the 'rnorm' function
n <- 10 #set sample size
mu <- 0 #mean
sd <- 5 #standard deviation
rnorm(n, mean = mu, sd = sd) #Generates 10 random normally distributed numbers

set.seed(234)
#Using the 'qnorm' function
n <- 10 #set sample size
mu <- 0 #mean
sd <- 5 #standard deviation
qnorm(runif(n), mean = mu, sd = sd) #Generates 10 random normally distributed numbers

set.seed(234)
# Generating 100 samples from a normal distribution with mean of 10 and sd 1
x <- rnorm(100, mean = 10, sd = 1)
# Plot the samples
hist(x, main = "Normal Distribution", col = "lightblue")
# Generating and plotting samples from a standard normal distribution
y <- rnorm(105000)
hist(y, main="Standard Normal Distribution", col="lightgreen")

# Usefulness of Probability Distribution in Data Science
# Modeling uncertainty
# Probability distributions can be used to model uncertainty in data.
# For example, if you are trying to predict the number of customers who will visit your 
# store on a given day, you can use a binomial distribution to model the uncertainty in the
# number of customers.
library(tidyverse)
# Load the mtcars dataset 
data("mtcars")
# Visualize data distribution
my_data <- mtcars 
ggplot(data=my_data, aes(x = mpg, y=qsec)) + geom_point()

# Making predictions
# Probability distributions can be used to make predictions about future events. For example,
# if you know the probability distribution of the number of customers who visit your store
# on a given day, you can use that information to predict the number of customers who will
# visit your store on a future day.
# Make predictions, using linear regression 
#  Fit the Model 
my_data <- mtcars 
my_model <- lm(qsec ~ mpg, data = my_data)
# Make Predictions 
predictions <- predict(my_model, newdata = my_data)
# Step 3 : Visualise Prediction 
ggplot(data=my_data, aes(x = mpg , y = qsec)) + 
  geom_point() + 
  geom_line(aes(x = mpg, y = predictions))

# We can visualize the uncertainty of data by predicted residual errors 
# Step 1 : Residual Error 
my_data <- mtcars 
my_model <- lm(qsec ~ mpg, data = my_data)


# Make Predictions 
predictions <- predict(my_model, newdata = my_data)
my_data$err <- (predictions - my_data$qsec)
# Step 2 : Plot Prediction with residuals
ggplot(data = my_data) + 
  geom_point(aes(x=mpg, y = qsec)) + 
  geom_line(aes(x = mpg, y = predictions)) +
  geom_line(aes(x=mpg, y=err), colour = "red")+
  geom_hline(yintercept = 0)
# To understand the uncertainty, we look at the range of residual errors 
min(my_data$err); max(my_data$err)
# The residual errors show that the mpg is correlated with qsec. 
# The uncertainty range is between -3.64 and 2.64 
# This means that as mpg changes, we can predict the qsec range with some uncertainty.

# Sample use cases
# In finance:
#   It can be used to understand the risk of investing in stocks i.e., to model the 
# distribution of stock prices.
# In medicine:
#   It can be used to understand the risk of developing a disease i.e., model the 
# distribution of diseases.
# In marketing
# It can be used to understanding the demand for productsi.e., model the distribution of 
# customer preferences

# Testing & Interpreting Hypothesis Tests
### Generate two normal distributions
x1 = rnorm(n = 10, mean = 0, sd = 1)
x2 = rnorm(n = 10, mean = 0.5, sd = 1)
### Perform t-test
t.test(x1, x2)## Interpret results
### The p-value is less than 0.05, indicating that the means of the two distributions
# are statistically different.

# Welch Two Sample t-test
# data:  x1 and x2
# t = -0.90873, df = 16.984, p-value = 0.3762
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
#   -1.4948693  0.5948551
# sample estimates:
#   mean of x mean of y 
# 0.2404829 0.6904900 

# QQplot
# We can also use the qqnorm() function to create a QQ plot of the number of COVID-19 cases 
# in Nigeria.A QQ plot is a graphical way to compare the distribution of a set of data
# to a theoretical distribution
qqnorm(covid_data$total_confirmed)
covid_data <- read.csv("data/covid19_nigeria_states.csv") 
hist(covid_data$total_confirmed)

# Conclusion
# In this lesson you learned about the use of probability distributions in data science.
# How probability distributions are used in data science
# Probability distributions can also be used to make decisions. For example, you can use a
# probability distribution to model the risk of an investment. The model can then be used to
# make a decision either to invest in a particular security or not.

### Introduction into Programming in R- TOPIC 4 ###

# Data Structures
# We discussed data types in “session 2”.
# In this section we will discuss data structures in R before delving into Programming in R.
# R has the following basic data structures:
#   Vector,List,Matrix,Data frame,Array,Factor

# Vectors
# Vectors are single-dimensional, homogeneous data structures. We use the c() function to
# create a vector.Run the code. Try and create a vector of your own. Call it whatever you
# like with number of elements you like and any data type of your choice.
vecr <- c(10, 20, 30) # We have created a vector assigned to an object named vecr
vecr

# Lists
# Lists are similar to vectors except they can store data of different types i.e., lists are
# heterogeneous data structures. We use the list() function to create a list.Run the code.
# Try and create a list of your own. Call it whatever you like with number of elements you
# like and combining more than one data type of your choice.
cchub_list <- list(254, "Herbert Macaulay", "Yaba", "Kigali", "Nairobi", "Namibia", 
c(22, 29, 2), TRUE, 3+4i, 6L)
cchub_list

# Matrix
# Matrices have rows and columns i.e., they are two-dimensional, homogeneous data structures. 
# However,all values in a matrix have to be of the same type. If more than one data type
# coercion takes place.By default, matrices are in column-wise order. The basic syntax to
# create a matrix is:matrix(data, nrow, ncol, byrow, dimnames)
# Matrix arguements:
# data is the input values given as a vector, nrow is the number of rows, ncol is the number 
# of columns,byrow (logical) which tells the function to arrange the matrix row-wise. 
# It is by default set to FALSE, dimnames is a list of the names of the rows/columns created.
# We will create a 4 X 4 order matrix with values from 1 to 16 (column-wise order).
matrix_1 <- matrix(c(1:16), ncol = 4)
matrix_1

rownames <- c("row1", "row2", "row3", "row4")
colnames <- c("col1", "col2", "col3", "col4")
matrix_2 <- matrix(c(1:16), ncol = 4, dimnames = list(rownames, colnames))
matrix_2

# Data frames:
#   Data frames are two-dimensional, heterogeneous data structures. They are lists of 
# vectors of equal lengths. Data frames have the following constraints placed upon them:
#   Use the data.frames() function to create a data frame,
# Required to have column-names
# Each row is required to have a unique name,
# Each item in a single column is required to be of the same type,
# Column required to have the same number of items,
# Different columns allowed to have different data types.
id <- c(1:10)
name <- c("Olu", "Oke", "Mariam", "Ezekiel", "Abdul", "Rasheed", "Oyinyen", "Amaka",
          "Ngugi", "Katung")
position <- c("second", "fifth", "second", "fourth", "first", "absent", "eighth", "tenth", 
              "absent", "sixth")
df_data <- data.frame(id , name, position)
df_data

# Array
# Arrays are collections of matrices stacked on top of the other
# (homogeneous data structures). They are three dimensional.The array() can be used to
# create an array.array_name = array(data, dim, dimnames)
# Consisting of: data to be filled inside the array ; a vector containing the dimensions of
# the array, list containing the names of the rows, columns, and matrices inside the array.
arr1 <- array(c(1:18),dim=c(2,3,3))
arr1

arr <- array(c(1:48),dim=c(4,4,3))
arr

rownames <- c("row1", "row2", "row3", "row4")
colnames <- c("col1", "col2", "col3", "col4")
matrix_names<- c("olu", "agift", "Ajala")
arr <- array(c(1:48) , dim=c(4,4,3) , dimnames = list(rownames, colnames, matrix_names))
arr

# Factors
# Factors are vectors but can store only predefined values. Mostly used for storing 
# categorical data. They have two attributes (class & levels).
# Class = “factor”
# Levels = Set of allowed values
# Factors can be created using the factor().
fac <- factor(c("a", "b", "a", "b", "b"))
fac

# Control Structure in R
# Now that we have covered, data type and data structure, we can start our programming in R, 
# starting with the control structure.
# In programming, the control structures allow us to control the flow of execution of a
# program. This enables us to specify statements to be executed, and in what order they are
# to be executed. This often depends on the value of a variable or the outcome of a
# condition.
# Types of Control Structures in R
# We have 3 main types of control structures in R:
# Sequence: Statements are executed in the order in which they appear in the code.
# Selection: Statements are executed only if a certain condition is met.
# Loop: Statements are executed repeatedly until a certain condition is met.

# Sequence
# The sequence control structure simply executes statements in the order in which they
# appear in the code.
# 

# Selection (If-else & Switch)
# The selection control structure allows us to specify which statement(s) to be executed
# based on the value of a variable or the outcome of a condition.
# There are two main types of selection control structures in R:
#   If-else:
#   The if-else control structure allows you to specify two different sets of statements to
# be executed, depending on the value of a variable.
# Switch:
#   The switch control structure allows you to specify multiple sets of statements to be
# executed, depending on the value of a variable.

# Loop (For & While)
# Statements are executed repeatedly until a certain condition is met. In R, we have 2 main
# types of loop control structures:
#   For:
#   For loop allows us to execute a set of statements a specified number of times.
# While:
#   While loop allows us to execute a set of statements as long as a certain condition is 
# met.

# Control Structures Generalised
# Bringing the 3 structure types together, R therefore provides different control structures.
# These structures can be used individually or in combinations to control programming flow.
# We can then have:
#   If – else
#     ifelse() function
# Switch,For loops,While loops,Break statement,Next statement,Repeat loops
# if – else
# We enforce conditional execution of code with if-else . It enables us to make a decision
# if a condition holds.The statement contains a condition that evaluates to a logical output.
# If the condition evaluates to TRUE it will then runs the enclosed code block. It will skip
# the code block if the condition is evaluated to be FALSE.
# 
Olu <- 25
Agift <- 26
if(Olu < Agift){
  print("Agift is Older than Olu")
}

Efraim  <- 25
Agift <- 26
if(Efraim > Agift){
  print("Efraim is older than Agift")
} else{
  print("Agift is older than Efraim")
}

# Decision Making & Loops (Control Structures)
# For our solution-focused training, using R for decision-making is key to us. Structures
# like if-else that control execution of the program conditionally and looping structures 
# that loop or repeat code executions based on certain condition(s) and state(s), become 
# must-understood concept.
# From our earlier exercise, we know that we can use the else if statement to select between
# multiple options:
sch <- "Pretoria"
if (sch == "Pretoria" | sch == "Windhoek" |sch == "Lusaka" |sch == "Harare") {
  print("Candidates falls within Southern geographical zone!")
} else {
  print("I am unsure if the candidate falls within area of interest")
}

# ifelse() Function
# The ifelse() is similar to if-else structure. Syntax of the ifelse():
#   `ifelse(Condition, Exp_if_true, Exp_if_false)`
# Where:
# Condition evaluates to either TRUE or FALSE,
# Exp_if_true is the expression that should be returned if the condition results is TRUE,
# Exp_if_false is the expression that should be returned if the condition results is FALSE.
# Use ifelse for same above
# begin introduction to vectorisation
sch <- "Erongo"
ifelse(sch == "Erongo" | sch == "Karas" |sch == "Kavango West" |sch == "Oshana", 
      "Candidates falls within SAIL geographical zone!", "I am unsure if the candidate
      falls within area of interest")
# Caprivi, Erongo, Hardap, Karas, Kavango West, Kavango East, Khomas, Kunene, Ohangwena,
# Omaheke, Omusati, Oshana, Oshikoto and Otjozondjupa
# 
# switch
# Switch is similar to if-else statement but more appropriate forn use when the 
# alternatives are multiples. It takes a single input argument and executes a particular
# code based on the value of the input (called a case).
city <- "Abuja"
switch(city,
       "Lusaka" = "Zambia",
       "Nairobi" = "Kenya",
       "Bamako" = "Mali",
       "Abuja" = "Nigeria",
       "Cairo" = "Egypt",
       "Kampala" = "Kwara State",
       "Kigali" = "Rwanda",
       "Windhoek" = "Namibia",
       "Tunis" = "Tunisia",
       "Kingston" = "Jamaica",
       "Pretoria" = "South Africa"
)
city

# for loops
# We use loop in R to perform repeated tasks i.e., loop through sequences to perform
# repeated tasks.
# for(variable in sequence){
#   what/code_to_repeat
# }
# Where:
#   variable = iterative variable,
# sequence = sequence which we need to loop through,
# what/code_to_repeat = code that runs every iteration.
melo <- c(1:10)
for(i in melo){
  print(paste0("This is number ", melo[i], " of 10"))
}

# while loops
# While loop, loops through the code block as long as the condition is evaluated to be TRUE.
# It exits the loop if the condition evaluates to FALSE. *** While loop may result in an 
# infinite loop ***. while loop’s syntax:
i <- 0
while(i < 10){
  print(paste("This is attempt number ", i))
  i <- i + 1
}

# break Statement
# The break statement is used to “break” us out of the loop early. For instance, if we are
# looking for an element in a sequence, the loop will go on until it finds the element or 
# until the end of the sequence. If it finds the element early, before the end of the 
# sequence, it stops from continuing with the loop.
participants <- c(1:30)
for(i in participants){
  print(paste("This is participant number ", i))
  if(i == 22){
    print("Partcipant number 22 has been found !!")
    break
  }
}

participants <- c('Squarepants', 'Star', 'Tentacles', 'Krabs', 'Cheeks', 'Squirrel',
                  'The Lobster', 'Snail', 'Crabs', 'Efraim', 'Krabs', 'Snail', 'Firey',
                  'Puff')
for(i in participants){
  print(paste("This is participant ", i, " I am still looking for Efraim"))
  if(i == "Efraim"){
    print("Efraim has been found out")
    break
  }
}

# next Statement
# The *** next *** statement causes the loop to skip the current iteration and move to the next 
# one.
mutum <- c(1 : 22)
for(i in mutum){
  if(i==5 || i==7 || i==9){
    print("Baya nan")
    next
  }
  print(paste("Wona mutum ni ", i))
}

# repeat loop
# The repeat loop is useful when we don’t know the required number of iterations. It 
# initially initiates an infinite loop. We must use the break statement to avoid an infinite
# loop.The repeat loop is similar to the while loop, but the repeat loop will continue to
# execute the code until the condition is met.
x <- 21
i <- 11
repeat{
  if(i == x){
    print("I have found it")
    break
  }
  print(paste("I have not found it", i))
  i <- i+1
}

#### Exercise on probability distribution 1 ###

# A forested nature reserve has 13 bird-viewing platforms scattered
# throughout a large block of land. The naturalists claim that at
# any point in time, there is a 75 percent chance of seeing birds at
# each platform. Suppose you walk through the reserve and visit
# every platform. If you assume that all relevant conditions are satisfied,
# let X be a binomial random variable representing the total
# number of platforms at which you see birds.
# a. Visualize the probability mass function of the binomial distribution
# of interest.
# b. What is the probability you see birds at all sites?
#   c. What is the probability you see birds at more than 9 platforms?
#   d. What is the probability of seeing birds at between 8 and 11
# platforms (inclusive)? Confirm your answer by using only the
# d-function and then again using only the p-function.
# e. Say that, before your visit, you decide that if you see birds at
# fewer than 9 sites, you’ll make a scene and demand your entry
# fee back. What’s the probability of your embarrassing yourself in
# this way?
#   f. Simulate realizations of X that represent 10 different visits to the
# reserve; store your resulting vector as an object.
# g. Compute the mean and standard deviation of the distribution of
# interest.

n <- 13  # Number of platforms
p <- 0.75  # Probability of seeing birds
x <- 0:n  # Possible number of successful platforms (0 to 13)
pmf <- dbinom(0:13, size = 13, prob = 0.75)  # Calculate PMF using dbinom function
barplot(x, pmf, type = "h", xlab = "Number of Platforms with Birds", ylab = "Probability",
        main = "PMF of Bird Sightings")
pmf

p_all_sites <- dbinom(13, size = 13, prob = 0.75)
cat("Probability of seeing birds at all sites:", p_all_sites)


p_more_than_9 <- 1 - pbinom(9, size = n, prob = p)
cat("Probability of seeing birds at more than 9 sites:", p_more_than_9)

# prob_more_than_9 <- pbinom(9, size = n, prob = p, lower.tail = FALSE)
# cat("Probability of seeing birds at more than 9 platforms:", prob_more_than_9, "\n")

p_between_8_11 <- pbinom(11, size = n, prob = p) - pbinom(7, size = n, prob = p)
cat("Probability of seeing birds between 8 and 11 sites (d-function):", p_between_8_11)

individual_probs <- dbinom(8:11, size = n, prob = p)
p_between_8_11_p <- sum(individual_probs)
cat("Probability of seeing birds between 8 and 11 sites (p-function):", p_between_8_11_p)

p_less_than_9 <- 1 - pbinom(8, size = n, prob = p)
cat("Probability of seeing birds at fewer than 9 sites:", p_less_than_9)

visits <- rbinom(10, size = n, prob = p)
visits

mean_visits <- mean(visits)
sd_visits <- sd(visits)
cat("Mean number of platforms with birds:", mean_visits)
cat("Standard deviation of number of platforms with birds:", sd_visits)

## Standard deviation in a function ##
standard_deviation <- function(data){
  if (length(data) == 0 | !is.numeric(data)) {
    return(NA)
  }
  mean <- mean(data)
  squared_deviation <- (data - mean)^2
  variance <- mean(squared_deviation)
  stand_dev <- sqrt(variance)
}

db <- c( rbinom(10, size = 13, prob = 0.75))
db
ans <- standard_deviation(db)
ans


### PROGRAMMING IN R - TOPIC 5 ###
# Functions in R Programming
# In this sub-section, we will learn:
# What a function in R is?
# Purpose of functions,Writing functions,Calling functions,Built-in functions,
# Creating user-defined functions,Arguements,Vectorisation

# Function in R?
# A function is a block of code that performs a specific task. R treats functions as 
# objects. The interpreter can pass control to them along with the arguments required by the
# function. Once the function has achieved its objective(s), it passes control back to the
# interpreter.
# Syntax of function
# The following is the syntax for a user-defined function in R:
#   Function_name <- function(arguments){
#     function_body
#     return (return)
#   }
# Where:function_name = name of the function,
# arguments = input arguments needed by the function,function_body = body of the function,
# return = value the function should return.Let’s look at each component of the syntax.

# Components of R function
# The following are the components of a function in R. A function may not necessarily have
# all or some of them.
# Function name:
# Every function needs a name. The name is used to call the function from other parts of the
# program. This is because R stores a function as an object with the name assigned to it.
# Arguments:
# Arguments are placeholders for the inputs a function may require. When we call a function,
# we need to provide the proper values for all the arguments the function needs. A function
# may or may not necessarily have arguments.
# Function body:
# A function’s body contains a set of instructions/statements. A function completes its task
# by running the code inside its body.
# Return value:
# After the function has executed its task, it may or may not return a value. The returned
# value can be the result of the task done by the function or a confirmation about the
# completion/failure of the task.

# The purpose of a function
# The purpose of a function is to simplify the process of performing a specific task.
# - Instead of writing several lines of code to carryout a specific task, we can use a 
# function to perform the same task saving time. It saves us time and saves us from
# repeating the same task multiple times (take a case of a number multiplying itself 4 times).
# 
# Example.
# Suppose we want to create a function named helloSAIL that prints a welcome message for 
# participant in this fellowship.
# *** Function with no arguement***
  helloSAIL <- function(){
    print(paste("You are welcome to this cohort of SAIL, Data Science for society"))
  }
helloSAIL()
# 
# Calling Functions
# To call a function, we use the function’s name along with parentheses. For our example 
# above:
  leke <- function(niyi)
  {
    return (niyi ^ 4)
  }
# We can call the `leke()` function by passing any value as an argument:
leke(10)

# Built-in functions
# In addition to us being able to create custom functions, R also provides many built-in
# functions (recall mean(), median()). These functions are already defined and can be used
# to simplify tasks - (lm()).
# Exercise:Create a numeric vector, give it a name you want. Use some in-built functions
# on the  vector.
sol <- c(1:20)
sol
mean(sol)
median(sol)
sd(sol)
mode(sol)

# Calling R function?
#   When a function has been created, we can call it from anywhere in the environment in
# which the function is declared.
# *** Please, read more on global and local environments.***
# To call a function, we simply have to use the function’s name and provide appropriate 
# arguments. For example:
#   function_name(arguments)
# Where function_name is the name of the function you want to call,and arguments are the
# arguments needed by the function.If the function doesn’t need any arguments, the 
# parenthesis can be left empty.When do you need the R function? We need a function if we 
# need to run the same instruction more than once.
# 

# Function Arguments
# Functions have named arguments which potentially have default values.The formal arguments
# are the arguments included in the function definition.The formals function returns a list
# of all the formal arguments of a function.Not every function call in R makes use of all 
# the formal arguments.Function arguments can be missing or might have default values

# Argument Matching
# This is serious as we will begin to use various in-built function.R functions arguments 
# can be matched by position or by name. The following calls to to use standard deviation (),
# sd are all equivalent
set.seed(234)
sample_data <- rnorm(100)
sd(sample_data)
sd(x = sample_data)
sd(x = sample_data, na.rm = FALSE)
sd(na.rm = FALSE, x = sample_data)
sd(na.rm = FALSE, sample_data)


# Argument Matching 1
# You can mix positional matching with matching by name. When an argument is matched by name,
# it is “taken out” of the argument list and the remaining unnamed arguments are matched in
# the order that they are listed in the function definition.
# args(lm)
# function (formula, data, subset, weights, na.action,
#           method = "qr", model = TRUE, x = FALSE,
#           y = FALSE, qr = TRUE, singular.ok = TRUE,
#           contrasts = NULL, offset, ...)
#   The following two calls are equivalent.
# lm(data = yourdata, y ~ x, model = FALSE, 1:100)
# lm(y ~ x, yourdata, 1:100, model = FALSE)

# Argument Matching 2
# Most of the time, named arguments are useful on the command line when you have a long
# argument list and you want to use the defaults for everything except for an argument near
# the end of the list.Named arguments also help if you can remember the name of the argument
# and not its position on the argument list (plotting is a good example).

# Argument Matching 3
# Function arguments can also be partially matched, which is useful for interactive work.
# The order of operations when given an argument is
# Check for exact match for a named argument,Check for a partial match,Check for a positional
# match

# Defining a Function
your_function_name <- function(abuja, b = 1, c = 2, d = NULL) {
}
your_function_name

# Lazy Evaluation
# Arguments to functions are evaluated lazily, so they are evaluated only as needed.
f <- function(a, b) {
  a^2
} 
f(10)
# This function never actually uses the argument b, so calling f(2) will not produce an 
# error because the 2 gets positionally matched to a.

f <- function(a, b) {
  print(a)
  print(b)
}
f(234)
# Running the code above will throw an error. However, we should observe that “234” or 
# whatever value/arguement provided, will be printed before the error is triggered. This is
# because b is evaluated after print(a) instruction. The moment, the function tries to 
# evaluate print(b) it will throw an error.


# Vectorisation in R
# This segment is to introduce the concept of vectorisation and some of the related 
# functions in R. Vectorisation is a process of creating a single vector (a list of elements)
# from a set of smaller vectors (elements) using “apply (and related) functions”.
# The tutorial covers the use of the following functions:
# lapply,mapply,sapply,tapply

# lapply
# The lapply() function allows you to perform an operation on a list of elements. It 
# returns a list of results, each of which is the result of the operation performed on each
# element in the list.
# For example, if we have a list x:
x <- list(1,2,3,4,5,6,7,8,9,10)
# We can perform an operation on each element x using lapply:
y <- lapply(x, function(n) n^2)
# This returns a list of the result of the operation multipling each element by 
# itself:
x <- list(c(1:10))
y <- lapply(x, function(n) n^2)
y

# mapply
# The mapply() function is similar to lapply(), but it allows us to pass multiple arguments
# to our function(s).
# For instance, if we have two lists x and y:
# `x<-list(1,2,3,4)
# y<-list(10,20,30,40)`
# We can perform an operation on each element of the two lists using mapply:
x <- list(c(1:10))
y <- lapply(x, function(n) n^2)
z <- mapply(function(a, b) a*b, x, y)
z

# sapply
# The sapply() is similar to lapply(), but it is used when the function being applied returns a vector or list.
# For example, if we recall our list x:
x <- list(c(1:10))
# We can perform an operation on each element of the list using sapply:
y <- sapply(x, function(n) n*2)
# This returns a vector of the result of the operation multipling each element by itself:
x <- list(c(1:10))
y <- sapply(x, function(n) n^2)
y

# tapply
# The tapply() function is used to apply a function to each sub-group of a data set.
# For example, if you have the vector x:
# x<-c(1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 4)
# You can apply a function to each group of this vector using the tapply function:
# y <- tapply(x, x, function(n) n*2)
x<-c(1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 4)
y1 <- tapply(x, x,  function(n) n*2)
y1
y2 <- tapply(x, x, function(n) n*n)
y2

# This returns a vector of the result of the operation (y1) multipling each group element by two and (y2) squaring each group element.
# > y1 $1` [1] 2 2 2
# $2 [1] 4 4 4
# $3 [1] 6 6 6
# $4 [1] 8 8 8 8 `
# > y2 $1` [1] 1 1 1
# $2 [1] 4 4 4
# $3 [1] 9 9 9
# $4 [1] 16 16 16 16`

# The “…” Argument
# The … argument indicate a variable number of arguments that are usually passed on to other
# functions.… is often used when extending another function and you don’t want to copy the 
# entire argument list of the original function
# yourplot <- function(x, y, type = "l", ...) {
#   plot(x, y, type = type, ...)
# }
# yourplot(x,y)
# yourplot2 <- function(x, y, type, ...) {
#   plot(x, y, type = "point", ...)
# }
# yourplot2(x,y)

# The “…” Argument
# The … argument is also necessary when the number of arguments passed to the function
# cannot be known in advance.
# args(paste)
# function (..., sep = " ", collapse = NULL)
#   args(cat)
# function (..., file = "", sep = " ", fill = FALSE,
#           labels = NULL, append = FALSE)

# Arguments Coming After the “…” Argument
# One catch with … is that arguments that appear after … on the argument list must be named
# explicitly and cannot be partially matched.
args(paste)
function (..., sep = " ", collapse = NULL)
paste("a", "b", sep = ":")
paste("a", "b", se = ":")

getwd()

sz <- as.data.frame(state.x77)
head(sz)
head(sz$Income)
zz <- mapply(function(a,b) a/b, sz$Population, sz$Area)
zz

install.packages('skimr')
library(skimr)
sierra_lone_ebola <- read.csv("C:/Users/YADTECH/Desktop/R/Datasets/ebola_sierra_leone - ebola_sierra_leone.csv.csv")
view(sierra_lone_ebola)
ggplot(sierra_lone_ebola)
dim(sierra_lone_ebola)
str(sierra_lone_ebola)
skim(sierra_lone_ebola)

install.packages("esquisse")
install.packages("plotly")

library(esquisse)
library(ggplot2)  
library(plotly)  
esquisser(sierra_lone_ebola)

### CLASSWORK USING FUNCTION TO SOLVE QUADRATIC EQUATION ###
Quad_eqtn <- function(a,b,c){
  quad1 = (-b + sqrt(b^2 - 4*a*c))/2*a
  quad2  = (-b - sqrt(b^2 - 4*a*c))/2*a
  return (paste("The roots of the equation are:", c(quad1), "and", c(quad2)))
}
Quad_eqtn(1, 2, 1)


#################### Data Gathering in R- TOPIC 6 ######################

# About this session
# We will cover basic ideas behind obtaining data ready for analysis
# 1)Finding and extracting data 2)Principles of tidy data and how to produce tidy data
# 3)Implementating a range of R packages 4)Necessary to have understood5)The Data Scientist’s Toolbox
# 6)R Programming
# Session will be useful;1)Data Exploration 2)Reporting/Reproducing Data Analysis

# Definition of data
# Data is a collection of facts or figures that can be used to make decisions or solve problems.
# It can be quantitative or qualitative, and it can be structured or unstructured.

# The four things you should have
# 1)Raw data.2)Tidy data set.3)Your code book - Describing your variables and values in 2.
# 4)An explicit steps and notes on how you move from 1 -> 2 -> 3.

# The raw data
# Hand-entered numbers or text collected (survey, questionnaires, observations etc.)
# Unformatted Excel file with many worksheets
# Nested JSON data from scraping the web, Twitter, LinkedIn etc.
# Discussing raw data when: No manipulation has taken place on the data, nothing has been
# cleaned, no summary of any form or no software applied on it.

# The tidy data
# One variable per column-One observation per row-One table per subject
# Common column(s) in the case of multiple tables (in the table that allows them to be linked
# (allow linking or merging).
# Other notes:
# A row with variable names at the top of each file.Sensible variable names human readable
# (DeathRate X DRate).Saved one file per table.

# The code book
# 1)Information about your variables (units, sources, caveat) that are not included in the tidy
# data.
# 2)Information about the summarisation applied (grouping, treated options - missing, 
# outliers) choices you made
# 3)Information about your Research Methodology
# Other notes:
# A Word/text file format.
# 1)Segment referred to as Research Methodology or Study design if it is
# experimental. This should provide a detailed description of how data was collected.
# 2)Segment referred to as the “Code book”. That should describe your variable(s) and their
# unit(s).

# Instruction list
# R or Python Scripts (in this fellowship)
# 1)The raw data is the input
# 2)The tidy data (the processed data) is the output
# There are no parameters to the script
# Reality of scripting all the instructions
# It will be impossible to script every step in the Data Generating Process (DGP). We should
# provide instructions like:
#   
# Step 1 - read the raw file - state the software, the version and parameters e.g.,
# x=1, y=2, z=3
# 
# Step 2 - Split the sample and run the software separately for each sample (state sampling 
# method, e.g., set seed)
# 
# Step 3 - take specific column(s) and/or row(s) of the output file for each sample and apply
# a function …

# Key you know your working directory
# 2 important commands in managing your working directory getwd() and setwd().
# Understand absolute and relative paths
# Absolute - setwd("/Users/agiftajala/Documents/data_science")
# Relative - setwd("./data_science"), setwd("../")
# Note the difference between Macs & Windows’ paths: setwd("C:\\Users\\agiftajala\\Downloads")

getwd()
setwd(./Data_science)

# Directories: - checking and creating directories
# Check to see if the directory exists file.exists("name_of_directory")
# Create a directory if it doesn’t exist dir.create("name_of_directory")
# Attempt creating a directory called “data_science” if it doesn’t exist

# R Code
if(!file.exists("Data_science")){
  dir.create("Data_science")
}

# Getting data from the internet - download.file()
# Downloads a file from the internet
# For reproducibility, we are encouraged to use download.file
# Key parameters to note: url, destfile, method
# Useful for downloading tab-delimited, csv, and other flat files
# 
# Webscraping
# Webscraping: Programatically extracting data from the HTML code of websites.

# Example - Our covid-19 data
# Link to covid_19 data - ekoanalytics.net
# 
# Using R to download the file from the web
fileUrl <- "https://www.ekoanalytics.net/data/covid19_nigeria_states.csv"
# download.file(fileUrl, destfile = "./Data_science/covid_19.csv", method = "curl")
download.file(fileUrl, destfile = "./Data_science/covid_19.csv")
list.files("./Data_science")

install.packages("tidyverse")

dateDownloaded <- date()
dateDownloaded

# Important notes about download.file()
# We can use download.file() when the url starts with http.Same will work on Windows even if 
# the url starts with https.With Mac however, we may need to set method = “curl” if the url
# starts with https.Download time may depend on the file size.
# Record when the download takes place (last accessed in academic practice).

# Reading downloaded/local files
# After downloading needed file(s), in our case the covid_data, we then need to know how to
# read files from our local drive(s).
# 
# Loading flat files - read.table()
# read.table() can be the default function for reading data into R.It is flexible and robust
# but in some cases will require more parameters
# 
# Parameters such as; file, header, sep, row.names, nrows
# Related: read.csv(), read.csv2()
# I am a proponent of file_type specific function or a more general function (easyr).We should
# note that reading big data into RAM - may cause some problems. There are so many ways to
# handle big data when your RAM is small.

# covid_data example
covidData <- read.table("./Data_science/covid_19.csv")
head(covidData)
# Error in scan(file = file, what = what, sep = sep, quote = quote, dec = dec,: line 1 
# did not have 3 elements
covidData2 <- read.table("./data_science/covid_19.csv", sep=",", header=TRUE)
head(covidData2)
# if you experience the error: cannot open the connection, your path to the file needs to
# be corrected
covidData3 <- read.csv("./data_science/covid_19.csv")
head(covidData3)
# if you experience the error: cannot open the connection, your path to the file needs to
# be corrected

# Some other important parameters
# nrows : Number of rows to read from the file (e.g. nrows=10 will read 10 lines).
# skip : Number of lines to skip before starting to read the file
# quote : You can tell R whether there are quoted values quote="" means no quotes.
# na.strings : Used to set the character that represents a missing value.
# Quotation marks ` or ” placed in data values, can cause some troubles in reading flat file,
# setting quote=“” often resolves the problem.
# 
# Excel files
# The file format still remains one of the most widely used file format (sharing data).
# Download Nigeria trade excel file
# Recall how we downloaded our covid_data.
fileUrl <- "https://ekoanalytics.net/data/nigeria_intra_Africa_trade_connectedness.xlsx"
download.file(fileUrl, destfile = "./Data_science/nigeria_africa_trade.xlsx")
list.files("./Data_science")
# xlsx packages
# read.xlsx(), read.xlsx2() {xlsx package}
library(readxl)
naijaTrade <- read_excel("./Data_science/nigeria_intra_Africa_trade_connectedness.xlsx")
head(naijaTrade)

# Reading specific rows and columns
library(readxl)
#subset row 1-4 and column 2 - 3
naijaTradeSubset <- read_excel("./Data_science/nigeria_intra_Africa_trade_connectedness.xlsx")[1:4,2:3]
naijaTradeSubset

# Notes
# To write out an Excel file, we can use writexl(), write.xlsx () amongst other. Please, note
# varying arguements for each function you intend to use.I suggest that you save your data in
# comma separated files (.csv) or tab separated files (.tab/.txt) as they are easier to 
# distribute.
# For writing and manipulating Excel files, You can look at: (XLConnect package)

# JSON
# JSON = Javascript Object Notation
# Lightweight data storage
# It is a common format for data from APIs (Application Programming Interfaces)
# JSON structure is similar to that of XML but they are different interms of syntax/format.
# 
# Data stored as
# Numbers (double)
# Strings (double quoted)
# Boolean (true or false)
# Array (ordered, comma separated enclosed in square brackets [])
# Object (unorderd, comma separated collection of key:value pairs in curley brackets {})


# Reading JSON data {jsonlite package}
library(jsonlite)
ajJsonData <- fromJSON("https://api.github.com/users/bunmiaj/repos")
names(ajJsonData )
ajJsonData$name

# Nested objects in JSON
library(jsonlite)
ajJsonData <- fromJSON("https://api.github.com/users/bunmiaj/repos")
names(ajJsonData$owner)
ajJsonData$owner$repos_url

# Writing data frames to JSON
library(jsonlite)
myjson <- toJSON(iris, pretty=TRUE)
cat(myjson)

# Convert back to JSON
library(jsonlite)
myjson <- toJSON(iris, pretty=TRUE)
iris2 <- fromJSON(myjson)
head(iris2)

# mySQL
# Widely used open source database software
# Often used in internet based applications
# Data are structured in
# Databases
# Tables within databases
# Fields within tables
# Each row is referred to as a record
# http://www.mysql.com/

# Interact with database
# create a connection
# list the tables
# read the table(s)
# Participants will be allowed limited time (4 hours) of practice on this for some reasons! 
# The connection will be disconnected thereafter.

#source("connecting_to_database.R")


sail_con <- dbConnect(RPostgres::Postgres(),
                      dbname = dsn_database,
                      host = dsn_host,
                      port = 5432,
                      user = "postgres",
                      password = dsn_password)
#list the number of tables 
#ls = dbListTables(sail_con) 
#ls
#read data 
#data = DBI::dbReadTable(sail_con, 'cscc_african_tweets')

# Conclusion
# In this section we have learnt about how to produce tidy data. We also learnt about a 
# number of ways to extract/acquire data. We have focused on the ones that will necessarily
# be useful for us to undertake our capstone project(s).


uber <- read_csv("./Data_science/Uber_Data (1).csv")
uber
view(uber)
summary(uber)
library(skimr)
skim(uber)
glimpse(uber)
# skim(covid_data)
# bor <- unique(na.omit(uber$borough))
# bf <-(na.omit(uber$borough))
# bf

grouped <- summarise(na.omit(group_by(uber,borough)), Freq=dplyr::n())
grouped

# install.packages("lubridate")
# library(lubridate)
# library(tidyr)
# uber$pickup_dt <- mdy_hm(uber$pickup_dt)
# uber %>%
#   separate(pickup_dt, into = c("day", "month", "year", "time"), sep= c("/", "/", " ", " "))
# 
# uber$pickup_dt <- factor(uber$pickup_dt)
# uber$pickup_dt


pairs(uber[3:6])
pairs(uber[3:12])



uber$pickup_dt = gsub("-", "/", uber$pickup_dt)
view(uber)

# library("lubridate")
library(lubridate)
uber$pickup_dt = ymd_hms(uber$pickup_dt)
uber$year = year(uber$pickup_dt)
uber$month_no = month(uber$pickup_dt)
uber$month = month(uber$pickup_dt, label =TRUE, abbr = TRUE)
uber$day = wday(uber$pickup_dt, label = TRUE)
view(uber)

install.packages("DataExplorer")
install.packages("myReports")
library(DataExplorer)
covid_data %>%
  report(
    target      = total_death,
    output_dir  = "reports/",
    output_file = "covid_death_nigerian_states_plots.html"
  )
library(DataExplorer)
covid_report <- create_report(covid_data)
write.html(covid_report, file = "reports/covid_death_nigerian_states_plots.html")



####### Cleaning Data & Regular Expression - TOPIC 7 #############

# About this session
# Sequel to our earlier discussions on Tidy Data, we will learn about data cleaning, covering
# handling of strings and dates.
# Changing character case |Splitting characters |vectorisation with vector |Necessary to have
# understood |Gathering Data
# R Programming
# Session will be useful; Data Exploration |Reporting/Reproducing Data Analysis

# Character vectors - tolower(), toupper()
# Recalling our learning from the last session, we should be able to acquire data from some
# sources (including) from the web. We can attempt
# if(!file.exists("./data")){dir.create("./data")}
# fileUrl <- "FILE_LINK"
# download.file(fileUrl,destfile="./data/FILENAME",method="curl")

ambulancesData <- read.csv("C:/Users/YADTECH/Documents/Data_science/R/Datasets/nigeria_markets.csv")
names(ambulancesData)
toupper(names(ambulancesData))
tolower(names(ambulancesData))

# Splitting character vectors
# Good for automatically splitting variable names
# Important parameters: x, split
splitNames = strsplit(names(ambulancesData), "\\_")
ambulancesData <- splitNames[[5]]
ambulancesData <- splitNames[[6]]
view(ambulancesData)

# Subsetting - lists
eloho <- list(letters = c("Serious", "Studious", "Stable", "Others"), numbers = 1:6, matrix(1:12, ncol = 3))
head(eloho)
eloho[1]
eloho$letters
eloho[[1]]
# 
# Vectorisation with characters
# Applies a function to each element in a vector or list
# Important parameters: X, FUN
splitNames = strsplit(names(ambulancesData), "\\_")
splitNames[[6]][1]
firstElement <- function(x){x[1]}
sapply(splitNames,firstElement)
# 
# Substituting character vectors
# Important parameters: pattern, replacement, x
head(ambulancesData,2)
names(ambulancesData)
sub("_", "", names(ambulancesData),)

# String substitution
maria <- "so_long_a_letter"
sub("_", "", maria)
gsub("_", "", maria)

# Finding values
str(ambulancesData)

grep("racheal.olarewaju", ambulancesData$editor)
table(grepl("racheal.olarewaju", ambulancesData$editor))
ambulances2 <- ambulancesData[!grepl("racheal.olarewaju", ambulancesData$editor),]
ambulances2

# In R, grep and grepl are two functions used for pattern matching within character vectors.
# They help you identify whether a specific pattern (sequence of characters) exists within
# elements (strings) of a character vector. Here's a breakdown of their functionalities and
# key differences:
# Grep:
# The grep function searches for the specified pattern within each element of a character 
# vector.It returns a vector of indices corresponding to the elements in the character vector
# where a match is found.If no match is found in any element, grep returns an empty integer 
# vector.

# More on grep()
grep("Ijare", ambulancesData$market_settlement_name, value=TRUE)
grep("Ilaramoko", ambulancesData$market_settlement_name)
length(grep("Ilaramoko", ambulancesData$market_settlement_name))
length(grep("Ijare", ambulancesData$market_settlement_name))

# More useful string functions
library(stringr)
sa <- "Senator Adetokunbo"
nchar(sa)
sa_b4 <- substr(sa, 9,18)
sa_b4
sa_ft <- paste("HRM", sa_b4)
sa_ft

# More useful string functions
paste0("Senator","Adetokunbo")
str_trim("Senator      ")

# String replace
ambulances2 <- ambulancesData %>% 
  mutate(market_settlement_name = str_replace(market_settlement_name, "Ilaramoko", "EDE"))
ambulances2

# Replace multiple strings at a time
ambulancesData <- read.csv("./Data_science/R/Datasets/nigeria_markets.csv")
rep_str = c('Ero'='South East','General'='South East','Ayede'='North East')
ambulancesData$state_name <- str_replace_all(ambulancesData$market_settlement_name, rep_str)
ambulancesData

# head(ai_papers_sample/iris_sample)
iris_sample <- iris
iris_sample
head(iris)
names(iris)
splitNames = strsplit(names(iris), "\\.")
splitNames[1]
splitNames[3]
iris_sample$Petal.Length <-  sub(".", "/", iris_sample$Petal.Length)
as.data.frame(iris_sample$Petal.Length)

# Notes on text in data sets
# Names of variables:
# Use lower case when possible |Avoid duplicateion |Avoid dots, white spaces and underscore |
# Variables with character values |Treat variables with character as factors (depending on 
# application)|Make use of descriptive (TRUE/FALSE instead of 0/1, Male/Female instead of 0/1 or M/F)
 
# Handling Dates in R
# "Date-time data can be frustrating to work with in R."
# "R commands for date-times are generally unintuitive and change depending on the type of
# date-time object being used."
# "Methods we use with date-times must be robust to time zones, leap days, daylight savings 
# times, and other time related quirks."
# Source: Lubridate Team (Github/tidyverse/lubridate)

# Date class
# Let’s recall our earlier discussions on dates (Data Structure)
yomi = Sys.Date()
yomi
class(yomi)

# Understanding dates formats
# %d = day as number (0-31)
# %a = weekday abbreviated
# %A = weekday unabbreviated
# %m = month (00-12)
# %b = month abbreviated
# %B = month unabbrevidated
# %y = 2 digit year
# %Y = four digit year
yomi = Sys.Date()
format(yomi,"%a %b %d")

# Creating dates
aba = c("14feb2023", "22feb2023", "18jun2023", "28jun2023", "14jul2023")
layi = as.Date(aba, "%d%b%Y")
layi
layi[2] - layi[1]
as.numeric(layi[2]-layi[1])

# Converting to Julian
yomi = Sys.Date()
weekdays(yomi)
months(yomi)
julian(yomi)

# Handling times in dates
ymd_hms("2011-08-03 10:15:03")
ymd_hms("2011-08-03 10:15:03",tz="GMT")
?Sys.timezone

# Syntax differences in dates
aba = dmy(c("14feb2023", "22feb2023", "18jun2023", "28jun2023", "14jul2023"))
wday(aba[1])
wday(aba[1], label=TRUE)
day_name <- format(aba[1], "%A")
day_name

# Conclusion
# In this section we have learnt about how to handle strings as part of cleaning data and 
# importantly, how to handle dates.Feedback Please, do not hesitate to give your feedback or
# seek clarification regarding this section. Scan the barcode.

# Notes and further resources
# Make use of stringr material on github for handling strings (cheatsheet available there)
# https://github.com/tidyverse/stringr
# Make use of lubridate material on github for dates (cheatsheet available there)
# https://github.com/tidyverse/lubridate


###### EDA & Auto EDA -  TOPIC 9  ###### 

# Important Notice
# Get Twitter API |Get Google Map API |Get OpenAI API

# About this session
# At the end of the lesson, learners should be able to:
# Explain the concept of EDA/Auto EDA and why they are important.
# Demonstrate the use of the Auto EDA package to summarize a dataset.
# Utilize EDA/auto EDA package(s) to identify data patterns.
# Explore text columns and gain insight on key words
# 
# Necessary to have understood:
# Gathering Data |Cleaning Data
# 
# Session will be useful for:
# Data Analysis |Reporting/Reproducing Data Analysis

install.packages("tidyverse")
install.packages("learnr")
install.packages("DataExplorer")
install.packages("explore")
install.packages("SmartEDA")
install.packages("wordcloud2")
install.packages("readxl")
install.packages("tidytext")
install.packages("wordcloud")
install.packages("topicmodels")
install.packages("tm")
install.packages("visNetwork")
install.packages("qdapRegex")
install.packages("syuzhet")
install.packages("ggraph")    


library(tidyverse)
library(learnr)
library(DataExplorer)
library(explore)
library(SmartEDA)
library(wordcloud2)
library(readxl)
library(DataExplorer)
library(tidytext)
library(wordcloud)
library(topicmodels)
library(tm)
library(visNetwork)
library(qdapRegex)
library(syuzhet)
library(ggraph)

# EDA
# Exploratory Data Analysis (EDA) is a systematic process of investigating a dataset to gain
# insights about its structure, distributions, and relationships.
# It is an important step in the data science process, as it can help you to understand your
# data and to identify potential problems or opportunities.
# Steps in EDA
# We will usually consider 3 main areas in EDA:
# Data Exploration
# Data exploration is the process of getting to know your data. This includes investigating
# the structure of the data, the distributions of the variables, and the relationships between
# variables.
# 
# Data Cleaning
# Data cleaning is the process of improving the quality of the data. This includes identifying
# and correcting errors, missing values, and outliers.
# 
# Data Visualization
# Data visualization is the process of representing data graphically. This can help you to
# understand the data and to identify patterns and trends.

# Benefits of EDA
# EDA can provide a number of benefits, including:
# Helping us to Understand our data |Helping us to Identify potential problems or opportunities
#  Improving the quality of your data |Helping us to Communicate our findings to others |Making
# better decisions

# Recall Probability/Data Distribution
# We can recall some distribution types:
# Gaussian Distribution|Uniform Distribution|Exponential Distribution
# Rectangular Distribution: When there is an arbitrary outcome that lies between certain bounds.
# 
# Plotting Distribution
# We made use of some visualisations (plots):
# Histogram|Boxplot|Density Plot|Q-Q Plot
# Q-Q Plots
# Q-Q plots are used to find the type of distribution for a random variable. We can tell the
# type of distribution using the power of the Q-Q plot.

# 3 Guided Steps in Data Exploration
# We are all conversant with these 3 steps by now. We will however, briefly discuss how to 
# apply these techniques.
# Data Preparation Stage|Univariate Analysis Stage|Multivariate Analysis Stage

# Data Preparation Stage:
## read in our data in any format ... read.csv(), read_csv(), read_excel(), fromJSON()
#covid_data
## Inspect the data ... head(), names(), glimpse()
str(covid_data)
## Select and group the data (if necessary) ... filter(), subset()
covid_data %>% 
  subset(states == "Kaduna") %>% 
  group_by(states, month) %>% 
  summarize(count = n()) %>% 
  as.data.frame()

# Univariate Analysis Stage:
## obtain summary statistics ... mean(), median(), and quantile()
summary(covid_data)

## visually represent the distribution of the variable/data ... bar plots, histograms,
# boxplots
set.seed(234)
##  Create a Q-Q plot for total_death variable
ggplot(covid_data, aes(sample = total_death)) +
  stat_qq() 

# Normal sample Q-Q plot
library(ggplot2)
set.seed(234)
# Create a Q-Q plot for the Sepal.Length variable
ggplot(iris, aes(sample = Sepal.Length)) +
  stat_qq() 
#geom_abline(intercept = 0, slope = 1)
# Interpretation
# The Q-Q plot of the Sepal.Length variable shows that the distribution is 
# approximately normally distributed.The points on the Q-Q plot fall close to the 
# line, which indicates that the  distribution of the variable is similar to the 
# normal distribution.We observed few points that fall not on the line, (i.e., 
# these values are slightly lower than what would be expected under a normal 
# distribution).This could be due to a number of factors (measurement error or 
# outliers).Overall, the Q-Q plot suggests that the Sepal.Length variable is 
# approximately normally distributed

# Multivariate Analysis Stage:
# Under multivariate analysis, we explore relationships between the different 
# variables in the dataset.
## explore relationships between variables ... cor()
## We can use scatterplots and boxplots
str(covid_data)
# par(mfrow = c(2, 1), mar = c(4, 4, 2, 1))
hist(subset(covid_data, states == "Ogun")$total_death, col = "green")
hist(subset(covid_data, states == "Oyo")$total_death, col = "green")


# DataExplorer
# Using special data exploration libaries in R (DataExplorer, explore, smartEDA,
# GGally )
##data distribution
covid_data %>% introduce()
#covid_data %>% plot_intro()
## Missing Values ----
#covid_data %>% plot_missing()
#covid_data %>% profile_missing()
## Continuous Features ----
#covid_data %>% plot_density()
#covid_data %>% plot_histogram()
## Categorical Features ----
#covid_data %>% plot_bar()
## Relationships ----
#covid_data %>% plot_correlation(maxcat = 15)

# Explore
#covid_data %>% explore() ## if you run: This function can only be used in an
# interactive R session
install.packages("explore")
library(explore)
covid_data %>% select(-new_recoveries) %>% explore() ## if you run: This function can
# only be used in an interactive R session
summary(covid_data)
skim(covid_data)
## Describe ----
covid_data %>% describe_all()
covid_data %>% describe_cat(states)
## Explore All Variables ----
covid_data %>%
  explore_all(
    target = total_death,
    ncol   = 3
  )
## Explore Bivariate Plot ----
covid_data %>%
  explore(
    target = total_death,
    var    = total_death,
    var2   = states
  )

# Auto EDA?
# Automatic Exploratory Data Analysis (Auto EDA)) is a technique used to quickly
# summarize and understand a dataset.It is a process based on summary statistics
# and visualizations that help to identify the underlying structure and trends 
# of a dataset.Used to identify data patterns in a dataset which becomes useful
# in determining the best model parameters and/or the need to further refine 
# the dataset.Useful in data science and machine learning since it helps to 
# quickly understand the characteristics and trends in the data.

# Reporting explore
# Faster html plotting !
## Running this on the learning platform may take some minutes
covid_data %>%
  report(
    target      = total_death,
    output_dir  = "reports/",
    output_file = "covid_death_nigerian_states_plots.html"
  )

Reporting DataExplorer
Interactive report
## Running this on the learning platform may take some minutes
library(DataExplorer)
covid_data %>%
  create_report(
    output_file  = "covid_data_report",
    output_dir   = "reports/",
    y            = "total_death",
    report_title = "EDA Report - Covid Death in Nigerian States"
  )
# Wasting time on manual exploration?
library(readxl)
ai_papers_sample <- read.csv("C:/Users/YADTECH/Documents/Data_science/ai_sample_papers.csv")
view(ai_papers_sample)
names(ai_papers_sample)
ai_papers_sample %>% introduce()
ai_papers_sample %>% describe()
ai_papers_sample %>% plot_missing()

# Auto Limitations
# This weakness will be clear if you can explore ai_paper_sample in an 
# interactive environment.The question is how do we get insight of columns that
# are not numerical and not clearly factors?This is your first step into text
# analysis
## ai_papers_sample %>% explore() ## if you run: This function can only be 
# used in an interactive R session
#PREPROCESSING OF TEXT COLUMN
install.packages("text mining")
library(tm)
ai_papers_sampleemmyCool <- ai_papers_sample$abstract %>% 
  str_replace_all("[^A-Za-z]"," ") %>% 
  VectorSource() %>% 
  Corpus() %>% 
  tm_map(tolower) %>% 
  tm_map(removeWords, stopwords("english")) %>% 
  tm_map(stripWhitespace) 
ai_papers_sample

#DISPLAYING IT IN A WORDCLOUD
library(wordcloud)
set.seed(234)
w_cloud <- wordcloud(emmyCool, max.words = 250,
          colors = brewer.pal(8, "Dark2"),
          scale=c(5,1), random.order = FALSE)

#WORD FREQUENCY
dtm <- DocumentTermMatrix(emmyCool)
freq = colSums(as.matrix(dtm))
ord = order(freq, decreasing = TRUE)
plot = data.frame(words = names(freq), count = freq)
plot = subset(plot, plot$count > 150) 
plot <- plot[with(plot, order(-count)), ]
plot

# Notes and further resources
# Make use of DataExplorer materials on github for auto EDA
# https://github.com/boxuancui/DataExplorer
# Make use of explore materials on github for auto EDA
# https://github.com/rolkra/explore



###### Data Visualisation - TPOIC 10 ############
# About this session
# Data visualization is an important tool for understanding and communicating your
# findings. R is a powerful language for data visualization. The importance of this
# section can not be over-emphasised.
# Learning Objectives
# By the end of this lesson, you will be able to:
# Understand the basic syntax for producing visualizations with R
# Appreciate the grammar of ggplot2
# Recognize the importance of data visualization
# Analyze and interpret data from visualizations
# Use R to create basic visualizations
# Use R to create interactive visualizations
# Necessary to have understood:
# Data Exploration;Session will be useful-Reporting/Reproducing Data Analysis
# Required Libraries:
install.packages("SmartEDA")
install.packages("plotly")
install.packages("wordcloud2")
library(tidyverse)
library(DataExplorer)
library(explore)
library(SmartEDA)
library(wordcloud2)
library(readxl)
library(plotly)

# Recalling EDA?
# Exploratory plots are “quick and dirty”
# Let you summarize the data (usually graphically) and highlight any broad features
# Explore basic questions and hypotheses (and perhaps rule them out)
# Suggest modeling strategies for the “next step”

# What is ggplot2?
# ggplot2 was written by Hadley Wickham (while he was a graduate student)
# A “third” graphics system for R (along with base and lattice)
# Abstraction of graphics ideas/objects (grammar of graphics)
# Allows for a “theory” of graphics on which to build new graphics and graphics
# objects

# Grammar of Graphics
# The grammar tells us that, a statistical graphic is:
# a mapping from data to aesthetic attributes (colour, shape, size)of geometric
# objects (points, lines, bars).The plot may be drawn on a specific coordinate and
# may require some transformations of the data.

# Base & Lattice
# Base plotting
# Idea of a blank canvas and build up from down (palette model)
# Start with plot then continue to add/modify (text, lines, points, axis)
# Plot is just a series of R commands
# 
# Lattice plotting
# Use a single function to create plots - (xyplot, bwplot, etc.)
# Entire plot is specified at once (margins/spacing set automatically)
# Impossible to “add” to the plot once it’s created (think of our padlet barcode)

# ggplot2 Plotting Systems
# Overcoming weaknesses of base and lattice plotting
# Easier and more intuitive to use
# Makes many choices (default) but can be customised and allows us to annotate by
# “adding”
# 
# Basics: qplot()
# Works much like the plot () in base graphics system
# Similar to ggplot2, plots are made up of aesthetics and geoms
# It however hides what goes on underneath. ggplot() is flexible in handling
# qplot’s limitations

# ggplot2 Components
# data - (dataframe)
# aesthetic - maps our data (to color, size)
# geoms - geometric objects (points, lines, shapes)
# facets - for conditional plots
# stats - for transforming our dat (quantiles, binning, smoothing)
# scales - defining what scales for aesthetic (eg., West = green, East = yellow,
# North = blue)
# coordinate system -(coord_cartesian() , coord_flip() , coord_fixed())

# Check more on https://ggplot2-book.org/coord.html
# Building Plots with ggplot2
# Closest analogy for plotting in ggplot2 is the “artist’s palette”.
# Plots are built up in layers
# Plot the data
# Overlay it with necessary summary
# Annotate on it/Metadata 

# Basic Plot
library(ggplot2)
covid_data
oruko <- unique(covid_data$states)
oruko
install.packages("magrittr")
library(magrittr)
covid_data2 <- covid_data %>% 
  subset(states %in% oruko[11:20])
qplot(total_death, total_confirmed, data = covid_data2, facets = . ~ states, 
      geom = c("point", "smooth"))
qplot(total_death, total_confirmed, data = covid_data2, facets = . ~ states,
      geom = c("point", "smooth"), method = "lm")

# Building Up Layers
oruko <- unique(covid_data$states)
covid_data2 <- covid_data %>% 
  subset(states %in% oruko[11:20])
g <- ggplot(covid_data2, aes(total_death, total_confirmed))
summary(g)
g
# Layer (point)
g + geom_point()
# Let's add more layers (smooth)
g + geom_point() + geom_smooth()
g + geom_point() + geom_smooth(method = "lm")
g + geom_point() + facet_grid(. ~ states) + geom_smooth(method = "lm")

# Annotate on plots
# Labels:
#   xlab()
# ylab()
# labs()
# ggtitle()
# Recall, we can modify the “geom” (geom_point(), geom_smooth())
# Use theme() for things that will affect the entire plot
# e.g., theme(legend.position = "none")
# Two standard appearance themes are included
# theme_gray(): (gray background) - default
# theme_bw(): (plain background)

# Aesthetics Modification
oruko <- unique(covid_data$states)
covid_data2 <- covid_data %>% 
  subset(states %in% oruko[11:20])
g <- ggplot(covid_data2, aes(total_death, total_confirmed))
g + geom_point(color = "steelblue", size = 4, alpha = 2/2)
g + geom_point(aes(color = states), size = 4, alpha = 2/2)

# Labels Modification
covid_data2 <- covid_data %>% 
  subset(states %in% oruko[11:20])
g <- ggplot(covid_data2, aes(total_death, total_confirmed))
g + geom_point(aes(color = states), size = 4, alpha = 1/2) + 
  labs(title = "Selected Stated Covid Death & Cases") + 
  labs(x = expression("Number of Death"), y = "Total Confirmed Cases")

# Smooth Modification
covid_data2 <- covid_data %>% 
  subset(states %in% oruko[11:20])
g <- ggplot(covid_data2, aes(total_death, total_confirmed))
g + geom_point(aes(color = states), size = 4, alpha = 1/2) +
  geom_smooth(linewidth = 4, linetype = 3, method = "lm", se = FALSE) +
  labs(title = "Selected Stated Covid Death & Cases") + 
  labs(x = expression("Number of Death"), y = "Total Confirmed Cases")

# Theme Modification
covid_data2 <- covid_data %>% 
  subset(states %in% oruko[11:20])
g <- ggplot(covid_data2, aes(total_death, total_confirmed))
g + geom_point(aes(color = states), size = 4, alpha = 1/2) +
  theme_bw(base_family = "Times") +
  geom_smooth(size = 4, linetype = 3, method = "lm", se = FALSE) +
  labs(title = "Selected Stated Covid Death & Cases") + 
  labs(x = "Number of Death", y = "Total Confirmed Cases")

# Interactive plot
# load plotly i.e., 
library(plotly)
covid_data2 <- covid_data %>% 
  subset(states %in% oruko[11:20])
foma <- ggplot(covid_data2, aes(total_death, total_confirmed)) +
  geom_point(aes(color = states), size = 4, alpha = 1/2) +
  theme_bw(base_family = "Times") +
  geom_smooth(size = 4, linetype = 3, method = "lm", se = FALSE) +
  labs(title = "Selected Stated Covid Death & Cases") + 
  labs(x = "Number of Death", y = "Total Confirmed Cases")
ggplotly(foma)

# Saving Plots
# We will first need to specify files to save our images using a () such as jpeg(), 
# png(), svg() or pdf(). Additional argument indicating the width and the height of
# the image can be also used.
# We then create the plot;Necessary to close the file with dev.off()

## Opening the graphical device
#pdf("images/mysample__plot.pdf")
# Creating a plot
plot(rnorm(20))
# Closing the graphical device
#dev.off() 

# Conclusion
# In this lesson, we explored visualization in R. We learned from basic plotting to
# interactive plotting and how to interpret the visualizations.
# We have highlighted how understanding ggplot2 grammar can become a powerful and
# flexible tools in our hands
# Further Exercise
# It is time to mess around with the package and all sorts of data you can think of.
# Feedback Please, do not hesitate to give your feedback or seek clarification
# regarding this section. Scan the barcode

### GEO-CODING ###
install.packages("tidygeocoder")
install.packages("sf")
install.packages("mapview")
install.packages("leaflet")
install.packages("rgdal")
library(tidygeocoder)
library(sf)
library(mapview)
library(leaflet)
library(plotly)
library(rgdal)
#Getting the CRS for for dataset or spatial data analysis
# bbox <- bbox(naija_markets[, c("longitude", "latitude")]) 
# crs_guess <- CRS.guess(bbox)
# crs_guess
# my_sf <- st_as_sf(naija_markets[, c("longitude", "latitude")], 
#                   crs = st_crs("+proj=longlat +datum=WGS84")) # Provisional WGS84
# print(st_crs(my_sf))

# If your data source lacks CRS information, online resources can help identify it 
# based on location or projection details. Here are some options:
# Spatial Reference System Authority (SRSA): This official website;
# (https://spatialreference.org/) provides a searchable database of CRS definitions
# with details like projection and usage.
# QGIS: This open-source Geographic Information System (GIS) software;
# (https://www.qgis.org/en/site/) has a built-in tool for defining or identifying
# the CRS of your data based on location and projection properties.

naija_markets <- read.csv("C:/Users/YADTECH/Documents/Data_science/nigeria_markets.csv")
# view(naija_markets)
naija_markets_sf <- naija_markets %>%
  st_as_sf(
    coords= c("longitude", "latitude"),
    crs = 4326
  )
# Option A
naija_markets_sf %>%
  leaflet() %>%
  addProviderTiles(providers$Esri.WorldImagery, group = "World Imagery") %>%
  addProviderTiles(providers$Stamen.TonerLite, group = "Toner Lite") %>%
  addLayersControl(baseGroup = c("Toner Lite", "World Imagery")) %>%
  addMarkers(label = naija_markets_sf$market_settlement_name,
             clusterOptions = markerClusterOptions(),
             popup = ifelse(naija_markets_sf$objectid != NA,
                            naija_markets_sf$objectid ,
                            "Not sure of the market's location"))

mapview(naija_markets_sf)

# Option B
naija_markets_sf %>%
  leaflet() %>%
  addProviderTiles(providers$Esri.WorldImagery, group = "World Imagery") %>%
  addProviderTiles(providers$Stadia.Stamen.TonerLite, group = "Toner Lite") %>%
  addLayersControl(baseGroup = c("Toner Lite", "World Imagery")) %>%
  addMarkers(label = naija_markets_sf$market_settlement_name,
             clusterOptions = markerClusterOptions(),
             popup = ifelse(naija_markets_sf$objectid != NA,
                            naija_markets_sf$objectid ,
                            "Not sure of the market's location"))

# mapview(naija_markets_sf)

# Option C
naija_markets_sf %>%
  leaflet() %>%
  # addProviderTiles(providers$Esri.WorldImagery, group = "World Imagery") %>%
  addProviderTiles(providers$OpenStreetMap, group = "OpenStreetMap") %>%
  addLayersControl(baseGroup = c("OpenStreetMap")) %>%
  addMarkers(label = naija_markets_sf$market_settlement_name,
             clusterOptions = markerClusterOptions(),
             popup = ifelse(naija_markets_sf$objectid != NA,
                            naija_markets_sf$objectid ,
                            "Not sure of the market's location"))

# view in viewer in R studio and then select if you want it in html or image 
# format


# To get data for Geo-location of all countries download the file from GADM website
# For SAIL  practice datasets- https://ekoanalytics.net/data-catalogue.html

uba_branches <- read_csv("C:/Users/YADTECH/Documents/Data_science/uba_branches.csv")
uba_branches

#GEO-CODING FREE BELOW GADM3

geo_code_tbl <- uba_branches %>% 
  #geocode Address to Lat/Lon
  tidygeocoder::geocode(
    address = Address,
    method = "osm"
  )

#G00GLE MAP API RECOMMENDED
# 1) Register for google map api_info_reference
# 2) Save your API in a secure place
# 3) Open your r_enviroment with this; usethis::edit_r_environ()
# 4) Add the.... GOOGLEGEOCODE_API_KEY = "Blansddsscsc24edbcdnd89932882" 
#This is no your key Get Yours!
# 5) Restart your studio
# 6) Then Geo-code

# GEOCODING WITH GOOGLE API
geo_code_tbl <- uba_branches %>% 
  #geocode Address to Lat/Lon
  tidygeocoder::geocode(
    address = Address,
    method = "google"
  )

## Using tidygeocoder with google i,e., method
## "google": Google, An API key must be stored in the environmental variable "GOOGLEGEOCODE_API_KEY "


######## Statistical Inference - TOPIC 12   #######

# About this session
# In this session, we will learn about some key concepts in statistical inference 
# without saddling us with the mathematics or the algebra.
# The concepts have been choosen amongst so many we will continue to meet along
# our Data Science journey because of their importance in understanding Regression
# Analysis and Machine Learning.

install.packages("UsingR")
install.packages("devtools")
install.packages("BSDA")
library(tidyverse)
library(UsingR)
library(BSDA)

# Statistical inference defined
# The process of drawing formal conclusions from data (Statistical Inference).
# As Data Scietists however, we must try to control or account for uncertainty 
# around our data and estimation, particularly when we attempt making inferences
# about a population from samples.
# 
# Motivation 1:
# Predicting Election Results
# Current population of Nigeria: Over 220 Million (Worldometer, July 2023)
# Registered voters in Nigeria: Over 93 million (INEC, 2023)
# Importance of correctly predicting election results (Who is going to win?)
# We have a clear prediction target:
# Y= PercentageofElectroratethatwillVoteforeachCandidate
# Considerations:
#   We can’t poll 93 million people before the election (Sampling)
# Even for smaller electorate (200), people can change their minds before election
# date (Uncertainty)

# Motivation 2:
# is lockdown effective in curbing COVID-19 spread in Africa?
# Lockdown or COVID-19 ?
# Economic hardships == Severe global economic downturn (IMF, 2020)
# Global GDP growth to fall by 3.0
# Cumulative output loss of $9 trillion over 2020-21 (4th, 5th & 6th)
# Greater impacts than 2009 global financial crisis (IMF, 2020
# 5.25 million new claims of unemployment benefits (Week ending April 11, 2020)
# 6.6 million new claims the week before that
# What is happening in developing countries? Policy persistence with little evidence,
# politics, no vaccines, etc.We have some inferential problems.Is Lockdown effective? 
# How long should we use it?
                                                     
# Concerns
# As Data Scientist, we will have some concerns when it comes to reaching 
# conclusions about a population. Some of these could be:
# How representative is our sample of the population that we’d like to draw 
# inferences about?
# Are there observed and/or unobserved variables that may affect our conclusions?
# Are there underlining biaseness created by missing data or by the design/conduct
# of our analysis?
# How randomn is our data and how do we use or adjust for it?
# Are we estimating mechanism or a phenomena in the study?
# Depending on the situation, undertaking Statistical Inference will usually
# require navigating some sets of assumptions and tools before drawing conclusions
# from data.

# Goals of inference
# Quantifying the uncertainty of an estimate of a population behaviour 
# (the proportion of people who will vote for a candidate in an election).
# Determining if a population quantity is a benchmark value (“is the treatment 
# effective?”).
# Infering a mechanistic relationship when quantities are measured with noise 
# (“What is the slope of Nigerian income elasticity for luxury goods?”)
# Determining the impact of a policy? (“If we increase lockdown intensity, 
# will COVID-19 spread reduce?”)

# Key terms to note
# Randomization
# *Balancing unobserved variables that may confound inferences of interest
# 
# Random sampling
# *Obtaining data that is representative of the population
# 
# Sampling models
# *Creating a model for the sampling process (iid) - independent and identically distributed
# 
# Hypothesis testing
# *Decision making under uncertainty
# 
# Confidence intervals
# *Quantifying uncertainty in an estimation
# 
# Study design
# *Designing an experiment to minimize biases and variability
# Nonparametric bootstrapping
# *the process of using the data to create inferences, with minimal model assumptions

# Significance testing
# A type of statistical inference is called significance testing in which a 
# hypothesis is tested using an appropriate statistical model, with associated 
# tests of significance.
# Significance testing includes the following types of tests
# Z-tests |Student’s t-test |Chi-square tests

# Confidence Interval
# A confidence interval is an interval associated with a particular test or
# procedure, which provides a likely range of outcomes for the procedure given a
# certain confidence level or alpha value. A confidence interval gives an estimate
# of an area of interest in a population from which a sample is taken.

# P-values
# Most common measure of “statistical significance”
# Idea: Suppose nothing is going on - how unusual is it to see the estimate we got?
# Approach:
# Define the hypothetical distribution of a data summary (statistic) when “nothing
# is going on” (null hypothesis) Calculate the summary/statistic with the data we 
# have (test statistic) Compare what we calculated to our hypothetical distribution
# and see if the value is “extreme” (p-value)

# Hypothesis testing
# Hypothesis testing is concerned with making decisions using data
# A null hypothesis is specified that represents the status quo, usually labeled H0
# The null hypothesis is assumed true and statistical evidence is required to 
# reject it in favor of a research or alternative hypothesis

# Hypothesis testing errors
# Usually, the alternative hypotheses are typically of the form < , > or ≠
# There are four possible outcomes of our statistical decision process
# 
# TRUTH	DECIDE	RESULT
# H0     H0     Correctly accept null
# H0     Ha     Type I error
# Ha     Ha     Correctly reject null
# Ha     H0     Type II error

# One Sample Z-Tests
# In this example, we will use a Z-test to test if the class average daily 
# interaction with the learning materials is 100 minutes. Let’s assume that sample
# are obtained from normal distributions, with a known standard deviation.
# 
# Randomnly select 30 participants
# We might want to test the hypothesis that
# H0:μ=100
# Ha:μ≠100
# where μ
# is the population Average interaction with learning materials seconds per day.

library(BSDA)
set.seed(234) # to get the same results
# Generate sample data from normal distribution (Average interaction with 
# learning materials seconds per day)
cohort1<- rnorm(n=22, mean = 57, sd=30)
# perform one sample z-test
z.test(cohort1, mu=100, sigma.x=30)


# Two Sample Z-Tests
# In this example, we will use a Z-test to identify whether two population means 
# are the same or different. We will assume that the class attendance of the two
# populations are obtained from normal distributions, with the same standard
# deviation, but possibly different means.
# Group EmmyCool mean = 56
# Group Tope mean = 80
# Sample size of both populations = 30
# We might want to test the hypothesis that
# H0:
#   Group EmmyCool average = Group Tope average
# Ha:
#   Group EmmyCool average ≠
# Group Tope average

library(BSDA)
set.seed(234) # to get the same results
emmyCool_group<- rnorm(n=30,mean = 56, sd=3)
tope_group<- rnorm(n=30,mean = 80, sd=3)
sd(emmyCool_group)
sd(tope_group)
# Run a Z-test to identify whether two population means are equal or different
z.test(emmyCool_group, tope_group, alternative="two.sided", mu=0, sigma.x= 3, sigma.y=3,conf.level=.95)

# IID random variables
# When random variables are `iid if they are independent and identically distributed
# This is often the default for random samples.Many important theories of
# statistics are founded on assuming that variables are iid
# Asymptotics
# The behavior of statistics as the sample size approaches infinity (or some other
# relevant number)

# Discussion
# An estimator is consistent if it converges to what you want to estimate
# Consistency is neither necessary nor sufficient for one estimator to be better
# than another

library(UsingR)
data(father.son)
t.test(father.son$sheight - father.son$fheight)

# Summary
# A type of statistical inference, significance testing, is used to test a
# hypothesis using appropriate statistical model. A confidence interval is an
# interval associated with a particular test or procedure that provides a likely
# range of outcomes for the given confidence level or alpha value. An example of
# Z-test has been used to illustrate the concept.

# Group Exercise 3
# Exercise Brief
# The aim of this exercise is to establish team building, team working and
# primarily assess participants’ ability to summarise data and undertake 
# statistical inference

# Exercise Instruction
# Form a group of your choice consisting of 4 - 6 participants
# Carefully select your group members
# Summarise the covid data by regions
# Test each region against other to test if their average death number from
# COVID-19 is same.
# Present your test as a Data Scientist
# Upload your final code and conclusion onto Padlet under your group’s name
# Participants have till noon of tomorrow to complete the tasks.
# 
# Things of interest:
# It is important to take note of this terms below. Important to understand them.
 
# P-values
# The P-value is the probability under the null hypothesis of obtaining evidence as
# extreme or more extreme than would be observed by chance alone
# If the P-value is small, then either H0
# is true and we have observed a rare event or H0
# is false

# Power
# Power is the probability of rejecting the null hypothesis when it is false
# A type II error (a bad thing, as its name would suggest) is failing to reject the
# null hypothesis when it’s false; the probability of a type II error is usually 
# called β
# Note Power =1−β
# Note: Support materials from Cousera Github

#######   Regression Analysis - TOPIC 13 #########

# About this session
# In this session, we will learn about regression analysis.
# Learning Objectives
# Under this topic (split into 2), we intend to:
# Visualise and fit linear regression models.
# Understand model coefficients and make predictions from linear regression models.
# Assess the quality of the linear regression model.
# Undertake similar steps with logistic regression models
# Introduce us into Time Series analysis
# Necessary to have understood
# Statistical Inference
# Session will be useful
# Machine Learning

# Required Libraries
library(tidyverse)
library(usingR)
library(manipulate)
library(broom)
library(BSDA)
library(broom)
library(ggfortify)

# Regression
# What is regression?
# Regression is a statistical/modelling method of exploring the relationship 
# between a dependent (response) variable and some explanatory variables.
# Using regression analysis (when we know the values of explanatory variables),
# we can predict the values of the dependent variable.
# 
# Familiar terms
# Dependent variable (a.k.a. Response variable): This is the variable that you want
# to predict.
# Independent variables (a.k.a. Explanatory variables): these are the variables
# that explain how the dependent variable will change.
# Linear regression: Used when the dependent variable is numeric.
# Logistic regression: Used when the dependent variable is binary/logical.
# Simple linear/logistic regression: Used when there is only one explanatory variable.
# Multivariable regression: Used when there is more than one explanatory variable.

# Questions
# Regression genesis questions:
# The most popular regression question: Why do children from very tall parents tend
# to be tall, but a little shorter than their parents and why children from very
# short parents tend to be short, but a little taller than their parents?
# (‘Regression to the mean’.) … Regression to the mean means extreme cases don’t 
# persist over time.
# Can we use parents’ heights to predict how tall their children will be?
# Can we investigate the differences in children’s height in relation to their 
# parents’ heights (residual variation)?
# Can we quantify what impact inheritance has on children’s height outside their
# parental height?
# Can we ascertain what will be necessary assumptions to generalize findings beyond 
# the data used?

# Galton’s Data
# Galton (Statistician - cousin of Charles Darwin) coined the term and concepts of
# regression and correlation.
# Data available in UsingR library.Only heterosexual couples.Correction for gender 
# via multiplying female heights by 1.08.

par(mfrow=c(1,2))
hist(galton$child,breaks=100, col = "lightblue", border = "pink")
hist(galton$parent,breaks=100, col = "lightblue", border = "pink")

# Middle using least squares
# This can be considered as the physical center of mass of the histrogram
# How can we define/describe the “middle” of the children’s height?
# One possible definition, is to let Yi
# be the height of child i
# for i=1,…,n=928
# We can then define the middle as the value of μ
# that minimizes
# ∑i=1n(Yi−μ)2
# This will bring us back to μ=X¯

# The empirical mean (ls)
ggplot(galton, aes(x = child)) + 
  geom_histogram(binwidth = 1, colour = "lightblue", fill = "lightblue") +
  geom_vline(xintercept = mean(galton$child), colour = "blue", lwd = 5)

# Visualizing children & parents’ heights
ggplot(galton, aes(parent, child) ) +
geom_point()
ggplot(galton, aes(parent, child))+
geom_point()+ 
geom_smooth(method = "lm", se =FALSE)

# Regression through the origin
# Let the parent’s height in Galton’s data be our Explanatory Variable or the 
# Independent Variable i.e., Xi are the parents’ heights.
# 
# Let’s pick the slope of a straight line β
# that minimizes
# ∑i=1n(Yi−Xiβ)2
# This is exactly using the origin as a pivot point picking the line that minimizes
# the sum of the squared vertical distances of the points to the line
# 
# Achieving same in R
lm(I(child - mean(child))~ I(parent - mean(parent)) - 1, data = galton)

# Visualizing the best fit line
# Size of points are frequencies at that X, Y combination
freq_galton <- as.data.frame(table(galton$child, galton$parent))

names(freq_galton) <- c("child", "parent", "freq")

plot(as.numeric(as.vector(freq_galton$parent)), 
     as.numeric(as.vector(freq_galton$child)),
     pch = 21, col = "black", bg = "lightblue",
     cex = .05 * freq_galton$freq, 
     xlab = "Parents", ylab = "Children")

lm1 <- lm(galton$child ~ galton$parent)
lines(galton$parent,lm1$fitted,col="red",lwd=3)

# Basic regression model with additive Normal errors.
# Least squares is an estimation tool, how do we do inference?
# Linear regression model
# Yi=β0+β1Xi+ϵi
# The ϵi is assumed iid N(0,σ2)
# E[Yi | Xi=xi]=μi=β0+β1xi
# Var(Yi | Xi=xi)=σ2
# Likelihood equivalent model specification is that the Yi
# are independent N(μi,σ2)

# Likelihood
# Note that log of an exponential (log linearisation) can make an exponential
# function linear
# L(β,σ)=∏i=1n{(2πσ2)−1/2exp(−12σ2(yi−μi)2)}
# so that the twice the negative log (base e) likelihood is
# −2log{L(β,σ)}=1σ2∑i=1n(yi−μi)2+nlog(σ2)
# Discussion
# Maximizing the likelihood is the same as minimizing -2 log likelihood
# The least squares estimate for μi=β0+β1xi
# is exactly the maximimum likelihood estimate (regardless of σ)

# Interpretting coefficients, intercept
# The intercept, β0
# is the expected value of the response when the predictor/explanatory variable(s)
# is 0
# E[Y|X=0]=β0+β1×0=β0
# Most often, it is impossible for the explanatory variable to be zero, for instance 
# when X=0 may not make economic sense. (X is parent’s height etc.)
# That:
# Yi=β0+β1Xi+ϵi=β0+aβ1+β1(Xi−a)+ϵi=β~0+β1(Xi−a)+ϵi
# Such that shifting the X
# values by value a changes the intercept, but not the slope.
# Often a is set to X¯ This can be interpreted as the expected outcome at the
# average X value.

# Interpretting coefficients - the slope β1 is the expected change in dependent
# variable for a unit change in the independent variable
# E[Y | X=x+1]−E[Y | X=x]=β0+β1(x+1)−(β0+β1x)=β1
# We should recall our interpretation of marginal effects or analogy from 
# elasticity in Economics

# Using regression coeficients for prediction
# If we are interested in predicting the outcome at a given value of the 
# explanatory variable(X), the regression model predicts β^0+β^1X
# At the observed value of X
# s, we obtain the predictions
# μ^i=Y^i=β^0+β^1Xi
# Recall that least squares minimizes
# ∑i=1n(Yi−μi)
# for μi expressed as points on a line

# Diamond Example
# diamond data is from UsingR library
# Data is diamond prices (Singapore Dollars) and diamond weight in carats
# (standard measure of diamond mass, 0.2 g). To get the data use library(UsingR);

data(diamond)
ggplot(diamond, aes(x = carat, y = price)) +
  geom_point(color = "black", size = 1.1, shape = 21) +
  geom_smooth(method = lm, se = FALSE, col = "darkblue", linewidth = 1.1) + 
  theme_classic() + 
  theme(panel.background = element_rect(fill = "lightblue")) +
  xlab("Mass (Carats)") + 
  ylab("Price (SIN $)")

# Fitting the linear regression model
fit <- lm(price ~ carat, data = diamond)
coef(fit)
## a - is the expected price of a diamond with zero carat
round(coef(fit)[1], 2)
##b (SIN) dollar increase in price for every carat increase in mass of diamond.
round(coef(fit)[2], 2)

# Getting a more interpretable intercept
fit2 <- lm(price ~ I(carat - mean(carat)), data = diamond)
coef(fit2)

# Predicting the price of a diamond
newX <- round(newX, 2)
coef(fit)[1] + coef(fit)[2] * newX
predict(fit, carat = newX)
price_predicted = round(predict(fit, carat = newX), 2)
#price_predicted
price_predicted2 <- diamond %>% 
  mutate(prediction = round(predict(fit, carat = newX), 2))
price_predicted2

library(dplyr)
library(ggplot2)

fit <- lm(price ~ carat, data = diamond)
set.seed(234)
newX <- tibble(runif(48, 200, 1000))
newX <- round(newX, 2)
coef(fit)[1] + coef(fit)[2] * newX
predict(fit, carat = newX)
price_predicted = round(predict(fit, carat = newX), 2)
price_predicted

price_predicted2 <- diamond %>% 
  mutate(predicted_price = round(predict(fit, carat = newX), 2)) %>% 
  rename(actual_price = price)
price_predicted3 <- gather(price_predicted2, variable, value, -carat)
# Fitted values - predictions on the originaldataset
#Showing predictions
foma <- ggplot(price_predicted3, aes(carat, value)) +
  geom_point(aes(color = variable), size = 4, alpha = 1/2) +
  theme_bw(base_family = "Times") +
  geom_smooth(size = 4, linetype = 3, method = "lm", se = FALSE) +
  labs(title = "LR actual versus predicted") + 
  labs(x = "Carat", y = "Prices")
ggplotly(foma)


# RESIDUALS
# Model Yi=β0+β1Xi+ϵi
# where ϵi∼N(0,σ2)
# Observed outcome i
# is Yi at predictor value Xi
# Predicted outcome i is Y^i at predictor valuve Xi is: Y^i=β^0+β^1Xi
# 
# Residual, is the gap between the observed and the predicted outcome ei=Yi−Y^i
# i.e., it is the vertical distance between the observed data point and the 
# regression line
# Least squares minimizes ∑ni=1e2i
# The ei can be thought of as estimates of the ϵi
# Residuals function in LR
# Residuals: actual dependent variable values minus predicted dependent values
price_predicted = round(predict(fit, carat = newX), 2)
price_predicted
price_predicted2 <- diamond %>% 
  mutate(predicted_price = round(predict(fit, carat = newX), 2)) %>% 
  rename(actual_price = price)
price_predicted3 <- gather(price_predicted2, variable, value, -carat)
round(residuals(fit), 2)
# equivalently:
as.data.frame(price_predicted2$price - price_predicted2$prediction)

# Properties of the residuals
# E[ei]=0
# When an intercept is included, ∑ni=1ei=0
# When a regressor variable, Xi , is included in the model ∑ni=1eiXi=0
# Residuals are useful for investigating model fit.
# Positive residuals are above the line, negative residuals are below.
# Residuals can be thought of as the outcome (Y) with the linear association of 
# the predictor (X) removed.
# Residual plots can be used to infer model fit.
# Residuals are normally distributed
# The mean of the residuals is zero

# Residuals are the gaps to the red lines
library(ggplot2)
data(diamond)
y <- diamond$price; x <- diamond$carat; n <- length(y)
fit <- lm(y ~ x)
e <- resid(fit)
yhat <- predict(fit)
ggplot(data = diamond, aes(x = carat, y = price)) +
  geom_point(shape = 21, color = "blue", size = 1.4) +
  geom_abline(lwd = 2) +
  geom_line(aes(x = carat, y = yhat), color = "red", lwd = 2) +
  xlab("Mass (carats)") +
  ylab("Price (SIN $)") 

# summary function
fit <- lm(price ~ carat, data = diamond)
summary(fit)
# Call
# Residuals
# Coefficients
# Model Metrics

# tidy summary
library(broom)
fit <- lm(price ~ carat, data = diamond)
summary(fit)
# Call
# Residuals
# Coefficients
# Model Metrics
tidy(fit)
augment(fit)
glance(fit)
fit %>%
  tidy()

# R^2
fit <- lm(price ~ carat, data = diamond)
# extract the R^2 value from the regression result
fit %>% 
  glance()
# It's just correlation squared
diamond %>%
  summarise(
    coeff_determination = cor(price, carat) ^ 2
  )

# Some facts about R2
# R2
# is the percentage of variation in the dependent variable that is explained by
# variations in explanatory variable.
# 0≤R2≤1
# R2
# is the sample correlation squared 1
# means a perfect fit while 0
# means the worst possible fit
# R2
# can be a misleading summary of model fit.
# Deleting data can inflate R2
# Adding terms to a regression model always increases R2

# Residual standard error (RSE)
# Note that the residual is always measured in the same unit as the dependent 
# variable.
fit <- lm(price ~ carat, data = diamond)
# extract the R^2 value from the regression result
fit %>%
  glance()
# Extract the RSE with broom pull ()
fit %>% 
  glance() %>% 
  pull(sigma)
# The difference between predicted price and observed price is typically about
# SIND 32.
fit %>%
  tidy() %>%
  pull(estimate)
# Calculating RSE: residuals squared
diamond %>%
  mutate(
    residuals_sq = residuals(fit) ^ 2
  ) %>%
  summarise(
    resid_sum_of_sq = sum(residuals_sq)
  )

# Calculating RSE: square root of ratio
# Residual Square Error
fit <- lm(price ~ carat, data = diamond)

diamond %>%
  mutate(
    residuals_sq = residuals(fit) ^ 2
  ) %>%
  summarise(
    resid_sum_of_sq = sum(residuals_sq),
    deg_freedom = n() - 2,
    rse = sqrt(resid_sum_of_sq / deg_freedom)
  )

# Residual Square Error
fit <- lm(price ~ carat, data = diamond)

diamond %>%
  mutate(
    residuals_sq = residuals(fit) ^ 2
  ) %>%
  summarise(
    resid_sum_of_sq = sum(residuals_sq),
    deg_freedom = n() - 2,
    rse = sqrt(resid_sum_of_sq / deg_freedom)
  )

# Non-linear data
abi <- runif(100, -3, 3); sola <- abi + sin(abi) + rnorm(100, sd = .2)
library(ggplot2)
ggplot(data = data.frame(abi, sola), aes(x = abi, y = sola)) + 
  geom_point() + 
  geom_smooth(method = "lm")

abi <- runif(100, -3, 3); sola <- abi + sin(abi) + rnorm(100, sd = .2)
ggplot(data = lm(sola ~ abi), aes(x = abi, y = resid(lm(sola ~ abi)))) +
  geom_point() +
  geom_abline(intercept = 0)

# Heteroskedasticity
x <- runif(100, 0, 6); y <- x + rnorm(100,  mean = 0, sd = .001 * x); 
library(ggplot2)
ggplot(data = data.frame(x, y), aes(x = x, y = y)) +
  geom_point() +
  geom_smooth(method = "lm")

x <- runif(100, 0, 6); y <- x + rnorm(100,  mean = 0, sd = .001 * x); 
ggplot(data = lm(y ~ x)) + 
  geom_point(aes(x = x, y = resid(lm(y ~ x)))) + 
  geom_hline(aes(yintercept = 0))

# Estimating residual variation
# Model Yi=β0+β1Xi+ϵi
# where ϵi∼N(0,σ2)
# The ML estimate of σ2
# is 1n∑ni=1e2i, the average squared residual.
# Most people use
# σ^2=1n−2∑i=1ne2i.
# The n−2
# instead of n
# is so that E[σ^2]=σ2

# Diamond example
y <- diamond$price; x <- diamond$carat; n <- length(y)
fit <- lm(y ~ x)
# R in-built computation
summary(fit)$sigma
# Self-calculated
sqrt(sum(resid(fit)^2) / (n - 2))

# Outliers, leverage & influence
# Extreme explanatory values
# Response values away from the regression line
# Leverage: Measure of how extreme the explanatory variable values are
# Influence: Measures how much the model would change if we removean observation
# from the dataset when modeling.
# Cook’s distance is the most common measure of influence
library(ggfortify)
library(tidyverse)
library(broom)
fit <- lm(price ~ carat, data = diamond)
autoplot(fit,
         which = 1:4,
         nrow = 4,
         ncol = 1
)
# Highly leveraged 
fit %>%
  augment() %>%
  select(price, carat, leverage = .hat) %>%
  arrange(desc(leverage)) %>%
  head()
# Cook's distance
cooks.distance(fit)


#######   Regression Analysis II - TOPIC 14 ########

# About this session
# In this session, we will learn about multivariable regression, logistic regression and count regressions and how to use R to perform these types of analyses. We will cover the following areas:
# What each concept means
# How to set them up the models in R
# How to interpret their results
# How to assess the fit of the models
# Necessary to have understood
# Regression Analysis I
# Session will be useful
# Machine Learning

# Required Libraries
library(tidyverse)
library(usingR)
library(manipulate)
library(broom)
library(BSDA)
library(broom)
library(ggfortify)

# What is Multivariable Regression?
# Multivariable regression is a type of regression analysis that involves more than
# one independent variable. It is used to predict the value of a dependent
# variable based on the values of two or more independent variables.The goal of 
# multivariable regression is to determine the relationship between the independent
# variables and the dependent variable, and to use this information to make
# predictions about future values of the dependent variable.
# For example, if we are interested in predicting the price of a house based on its
# size, location, and age. We could use multivariable regression to analyse the 
# relationship between these three independent variables (size, location, and age)
# and the dependent variable (price).If we were to present evidence of a relationship
# between education level (Highest Qualification, X) and wages (measured in 
# Naira/Month)? It is likely, we will consider, age, location, gender, job type,
# experience etc.Important to note for interpretation that, to consider our
# results, we would have to demonstrate that we are holding other variables constant.
 
# Extending the SLR
# The general multivariate linear model extends simple linear regression (SLR) by
# adding terms linearly into the model.
# Yi=β1X1i+β2X2i+…+βpXpi+ϵi=∑k=1pXikβj+ϵi
# Recall the least squares (also, the ML estimates under iid Gaussianity of the
# errors) minimises
# ∑i=1n(Yi−∑k=1pXkiβj)2
# Note, that the principle of linearity is linearity in the coefficients. 
# Therefore, an equation as shown below is still a linear model. (We have only 
# squared the elements of the predictors) Yi=β1X21i+β2X22i+…+βpX2pi+ϵi

# General case
# The equations
# ∑i=1n(Yi−X1iβ^1−…−Xipβ^p)Xk=0 for k=1,…,p
# yields p equations with p unknowns.
# Solving the unknown will yield the least squares estimates. (I have saved us the
# headache of the linear algebra - considering the composition of the cohort.)
# The least squares estimate for the coefficient of a multivariate regression model
# is the same as regression through the origin with the other regressors removed 
# from both the regressor and outcome by taking residuals.By implication,
# multivariate regression “adjusts” a coefficient for the linear impact of the 
# other variables.


# Set Up a Multivariable Regression Model in R
# Similar to our SLR, we can use the lm() function to set up our multivariable 
# regression model.
# The syntax for the lm() function is as follows:
# lm(dependent_variable ~ independent_variable1 + independent_variable2 + ...,
# data = data_frame)
# Example of Multivariable Regression in R
# For example, if we wanted to predict the mpg of a car based on its weight and 
# number of cylinders.We are quite familiar with the mtcars dataset (by now). The
# dataset contains information about the different cars in the Motor Trend magazine.
# The variables in the dataset include:
# mpg: Miles/(US) gallon
# cyl: Number of cylinders
# disp: Displacement (cu.in.)
# hp: Gross horsepower
# drat: Rear axle ratio
# wt: Weight (1000 lbs)
# qsec: 1/4 mile time
# vs: Engine (0 = V-shaped, 1 = straight)
# am: Transmission (0 = automatic, 1 = manual)
# gear: Number of forward gears
# carb: Number of carburetors
# R Code
model <- lm(mpg ~ wt + cyl, data = mtcars)
model$coefficients[1]
#we can use -1 to remove the intercept

# Obtaining results
# Similar to the SLR, once the model has been created, we can use the summary() 
# function to view the results of the regression analysis.This will provide us with
# information about the coefficients of the model, as well as other useful 
# information such as the R-squared value and the F-statistic.
model <- lm(mpg ~ wt + cyl, data = mtcars)
summary(model)
#we can use -1 to remove the intercept

# Interpreting the Results of a Multivariable Regression Model
# 
# The output of the summary() function will provide us with a variety of information
# about our model, including the coefficients for each independent variable, the
# R-squared value, and the F-statistic.The coefficient of each independent variable
# tells us how much the dependent variable is expected to change when that 
# independent variable is changed by one unit. For example, from our model, the
# coefficient for wt is −3.1910, then we can expect that the mpg of the car to 
# reduce by about 3.19miles when the weight of the car is increased by one unit
# (holding other variables constant).i.e., the interpretation of a multivariate
# regression coefficient is the expected change in the response per unit change in
# the regressor, holding all of the other regressors fixed.

# How to Assess the Fit of a Multivariable Regression Model
# 
# Once we have interpreted the results of our multivariable regression model, we
# can use a variety of techniques to assess the fit of our model.The R-squared value
# tells us how well our model fits the data. The higher the R-squared value, the
# better our model fits the data (caveat on this).The F-statistic tells us whether
# our model is statistically significant. If the F-statistic is greater than the 
# critical value, then our model is statistically significant.One other technique 
# is to plot the residuals of our model. The residuals are the differences between 
# the observed values and the predicted values of our model. If our model is a good
# fit, then the residuals should be randomly distributed around zero. We can plot
# the residuals by running the following code:
library(ggplot2)
model <- lm(mpg ~ wt + cyl, data = mtcars)
# Create a ggplot object
ggplot(data.frame(model$residuals), aes(x = model$fitted.values, y =model$residuals)) +
  geom_point() +
  geom_hline(yintercept = 0) +
  labs(title = "Residual Plot", x = "Fitted Values", y = "Residuals")

# Genralisation
# We can apply almost all principles learnt under SLR to multivariable linear 
# regression models
# predict(model, new_data)
# Fitted values & residuals
# All of our SLR characteristics can be extended to mutivariate linear models
# Model Yi=∑pk=1Xikβk+ϵi
# where ϵi∼N(0,σ2)
# Fitted responses Y^i=∑pk=1Xikβ^k
# Residuals ei=Yi−Y^i
# Variance estimate σ^2=1n−p∑ni=1e2i
# To get predicted responses at new values, x1,…,xp, simply plug them into the
# linear model ∑pk=1xkβ^k
# Coefficients have standard errors, σ^β^k , and β^k−βkσ^β^k follows a T
# distribution with n−p degrees of freedom.
# Predicted responses have standard errors and we can calculate predicted and 
# expected response intervals.

# Linear models
# Linear models are considered the single most important applied statistical and 
# machine learning techniqe.Some amazing things that you can accomplish with linear
# models
# It can flexibly fit complicated functions.
# It can fit factor variables as predictors.
# It can uncover complex multivariate relationships with the dependent variable.
# It can build accurate prediction models.

# Logistic Regression
# Humans generally care about outcomes that have two values (great economic values
# or implications)
# Employee/Client quitting/retained | Success/Failure | Win/loss | Alive/dead etc
# Recall from our probability distribution, binary, Bernoulli or 0/1 outcomes

# glm function
# Logistic regression can be:
# Simple logistic regression
# glm(response ~ explanatory, data = dataset, family = binomial)
# 
# Multiple logistic regression
# glm(response ~ explanatory1 + explanatory2, data = dataset, family = binomial)
# Multiple logistic regression with interaction(s)
# glm(response ~ explanatory1 * explanatory2, data = dataset, family = binomial)

# Example churning
library(dplyr)
# Churn tenure MonthlyCharges
head(churning)
churning %>% 
  dplyr::select(Churn, tenure, MonthlyCharges)
####
churning$churn <- ifelse(churning$Churn == "No", 0, 1)
model2 <- glm(churn ~ tenure + MonthlyCharges, data = churning, family = binomial)
summary(model2)

# Linear regression
# churni=b0+b1tenurei+ei
# churni - 1 if a client leaves, 0 if not 
# tenurei - How long the client has been with the telco 
# b0 - probability of a client churning if their tenure is 0 
# b1 - increase in probability of a client churning for each additional tenure 
# ei - residual variation due

# Linear Probability Model
churning$churn <- ifelse(churning$Churn == "No", 0, 1)
lmChurn <- lm(churning$churn ~ churning$tenure)
summary(lmChurn)$coef

# Odds
# Binary Outcome 0/1 -churni
# Probability (0,1)- Pr(churni|tenurei,b0,b1)
# Odds (0,∞) -Pr(churni|tenurei,b0,b1)1−Pr(churni|tenurei,b0,b1)
# Log odds (−∞,∞) -log(Pr(churni|tenurei,b0,b1)1−Pr(churni|tenurei,b0,b1))

# Linear vs. logistic regression
# Linear
# churni=b0+b1tenurei+ei
# or
# E[churni|tenurei,b0,b1]=b0+b1tenurei
# Logistic
# Pr(churni|tenurei,b0,b1)=exp(b0+b1tenurei)1+exp(b0+b1tenurei)
# or
# log(Pr(churni|tenurei,b0,b1)1−Pr(churni|tenurei,b0,b1))=b0+b1tenurei

# Interpreting Logistic Regression
# log(Pr(churni|tenurei,b0,b1)1−Pr(churni|tenurei,b0,b1))=b0+b1tenurei
# b0- Log odds of a client churning if their tenure is zero
# b1- Log odds ratio of a client’s churning probability for every increase in 
# tenure (compared to zero tenure)
# exp(b1)- Odds ratio of a client’s churning probability for every increase in 
# tenure (compared to zero tenure)

# Interpreting Logistic Regression
# log(Pr(churni|tenurei,b0,b1)1−Pr(churni|tenurei,b0,b1))=b0+b1tenurei
# b0- Log odds of a client churning if their tenure is zero
# b1- Log odds ratio of a client’s churning probability for every increase in 
# tenure (compared to zero tenure)
# exp(b1)- Odds ratio of a client’s churning probability for every increase in 
# tenure (compared to zero tenure)

# Explaining odds
# If you gamble, where outcome is like flipping a coin with success probability p
# You win X (if it comes up heads) but you lose Y (If it comes up tails).
# What should we set X
# and Y for the game to be fair?
# E[earnings]=Xp−Y(1−p)=0
# Implies:YX=p1−p
# The odds can be said as “How much should you be willing to pay for a p
# probability of winning a Naira?”
# (If p>0.5
#  you will have to pay more if you lose than you will get if you win.)
# (If p<0.5 you will have to pay less if you lose than you will get if you win.)

# Helping interpretaion
# Intercept: The log-odds of churning when tenure=0 is 0.027
# Tenure: For every unit increase in tenure the log-odds of churning decrease by
# −0.0387 i.e. the chances of leaving decrease as clients’ tenure increases.
# Given p<0.5, we can reject the null hypothesis b1=0
# that one unit increase in tenure does not affect chances of churning.

# Churning logistic regression
churning$churn <- ifelse(churning$Churn == "No", 0, 1)
logRegChurn <- glm(churning$churn ~ churning$tenure,family="binomial")
summary(logRegChurn)

# Churning fitted values
churning$churn <- ifelse(churning$Churn == "No", 0, 1)
logRegChurn <- glm(churning$churn ~ churning$tenure,family="binomial")
plot(churning$tenure,logRegChurn$fitted,pch=19,col="blue",xlab="Tenure",ylab="Prob of churning")

# Odds ratios and confidence intervals
churning$churn <- ifelse(churning$Churn == "No", 0, 1)
logRegChurn <- glm(churning$churn ~ churning$tenure,family="binomial")
exp(logRegChurn$coeff)
# 
# The odds ratio for the value of the intercept is the odds of “churning” when 
# tenure = 0. The odds ratio for the coefficient of tenure is the increase in odds
# above this value of the intercept when tenure increases by 1.
churning$churn <- ifelse(churning$Churn == "No", 0, 1)
logRegChurn <- glm(churning$churn ~ churning$tenure,family="binomial")
exp(confint(logRegChurn))

# ANOVA for logistic regression
churning$churn <- ifelse(churning$Churn == "No", 0, 1)
logRegChurn <- glm(churning$churn ~ churning$tenure,family="binomial")
anova(logRegChurn,test="Chisq")

# Interpreting Odds Ratios
# Odd ratios are not probabilities
# Odds ratio of 1 implies there is no difference in odds
# Log odds ratio of 0 implies there is no difference in odds
# Odds ratio < 0.5 or > 2 commonly a “moderate effect”
# Relative risk Pr(churni|tenurei=0)Pr(churni|tenurei=0)
# often easier to interpret, harder to estimate
# For small probabilities RR ≈
# but they are not the same!

# Conclusion
# In this lesson, we have learned about multivariable regression, logistic 
# regression and how to use R to perform these types of analyses.
# Read more on odds ratio
# Note: Support materials from Cousera & DataCamp
# Feedback Please, do not hesitate to give your feedback or seek clarification
# regarding this section. Scan the barcode.
# Link to Feedback Padlet.


  
  






