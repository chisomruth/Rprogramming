#17/05/2024

vec <-  c(6, 5, 7)
vec

matrix_1 <- matrix(c(5:55), ncol = 15)
matrix_1

rownames <- c("1", "2")
colnames <- c("ID", "name", "size", "weight")
matrix_2 <- matrix(c(1,2,"dog","cat", 7, 4, 6, 9), ncol = 4, dimnames = list(rownames, colnames))
matrix_2

library(pillar)
id <- c(1:10)
name <- c("Olu", "Oke", "Mariam", "Ezekiel", "Abdul", "Rasheed", "Oyinyen", "Amaka", "Ngugi", "Katung")
position <- c("second", "fifth", "second", "fourth", "first", "absent", "eighth", "tenth", "absent", "sixth")
df_data <- data.frame(id , name, position)
df_data
glimpse(df_data)

rownames <- c("row1", "row2", "row3", "row4")
colnames <- c("col1", "col2", "col3", "col4")
matrix_names<- c("olu", "agift", "Ajala")
arr <- array(c(1:48) , dim=c(4,4,3) , dimnames = list(rownames, colnames, matrix_names))
arr

fac <- factor(c("a", "b", "a", "b", "b"))
fac


#18/05/2024

Turayo <- 28
Ade <- 15
if(Turayo>Ade){
  print("turayo is older")
}

city <- "D"

rep <- switch(city,
       "A" = "Zambia",
       "B" = "Kenya",
       "D" = "Mali"
       
)

melo <- c(1:10)

for(i in melo){
  
  print(paste0("This is number ", melo[i], " of 10"))
  
}

i <- 0

while(i < 10){
  
  print(paste("This is attempt number ", i))
  
  i <- i + 1
  
}


X.prob <- dbinom(x=0:13,size=13,prob=3/4)
#barplot(X.prob,names.arg="0:13",space=0,xlab= "Prob", ylab="Pr(X = x)" )
X.prob



mean(X.prob)
sd(X.prob)

###########
X_7.prob <- sum(dbinom(x=0:7,size=13,prob=3/4))

X_11.prob <- sum(dbinom(x=0:11,size=13,prob=3/4))

X.prob <- X_11.prob-X_7.prob
barplot(X.prob,names.arg="8:11",space=0, ylab="Pr(X = x)")
X.prob


Xi.prob <- (pbinom(q=11,size=13,prob=3/4))
Xii.prob <- (pbinom(q=7,size=13,prob=3/4))
X.prob <- Xi.prob-Xii.prob
#barplot(X.prob,names.arg='8:11',space=0, ylab="Pr(X = x)")
X.prob

X.prob <- sum(dbinom(x=0:8,size=13,prob=3/4))

X.prob

x <- 21
i <- 11
repeat{
  if(i == x){
    
    print("I have found it")
    
    break
    
  }
  
  print("I have not found it")
  
  i <- i+1
}


if (cast() > 0.5*nig@data[i() , 5]) {
  "Incumbent Wins the State"
} else if (cast() < 0.4*nig@data[i() , 5]) {
  "Incumbent Looses the State"
} else {
  
  "Too Close to Call"
}
icon = icon("glyphicon-eye-open", lib = "glyphicon")


helloSAIL <- function()
{
  
  # Print message
  print(paste("You are welcome to this cohort of SAIL, Data Science for society"))
        
}
helloSAIL()



mean <- function(SD)
  
  return (sum(num)/length(num))

mean(c(1:15))


num <- c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15)
mean(num)







set.seed(123)
data <- c(rbinom(n = 15, size = 10, prob = 1/6))

STD <- function(data) {
  data_mean <- mean(data)
  diff <- data - data_mean
  diff_squared <- diff^2
  sum_diff_squared <- sum(diff_squared)
  n <- length(data)
  dv <- sqrt(sum_diff_squared / (n - 1))
  return(dv)
}
STD(c(1,3,4,6,7,9))

sd(c(1,3,4,6,7,9))


sequence <- function(num){
  seq <- c()
  while (length(num)>0){
    leasst <- min(num)
    seq <- c(seq, leasst)
    num <- num[num != leasst]
  }
  return (seq)
}

num <- rbinom(n =15, size = 10, prob = 0.5)

sequence(num)

f <- funct



library(dplyr)
my_dat <- as.data.frame(state.x77)
head(state.x77)
dens = mapply(function(x, y) x/y, my_dat$Population, my_dat$Area)
dens


install.packages("skimr")
if(!require(pacman)) 
  install.packages("pacman")
pacman ::p_load(
  tidyverse,
  inspectdf,
  plotly,
  janitor,
  visdat,
  esquisse,
  skimr
)


data <- read.csv("C:/Users/Open User/Downloads/ebola_sierra_leone - ebola_sierra_leone.csv.csv")
# esquisse ::esquisser(data)
view(data)
dim(data)
str(data)
skim(data)
Sys.time()


library(dplyr)
fil <- data %>% filter(status == "confirmed" & sex == "M")
print(dat)

print("Age column from filtered data:")
print(fil)
print(mean(age, na.rm=TRUE))


getwd()
file.exists("data_science")

if (!file.exists("data_science")){
  dir.create("data_science")
}


url = "https://www.ekoanalytics.net/data/covid19_nigeria_states.csv"
data = download.file(url, destfile = "./data_science/covid.csv" )
list.files("./data_science")
library(tidyverse)

covidData <- read.table("./data_science/covid.csv", sep=",", header=TRUE)

head(covidData)
view(covidData)


library(jsonlite)

ajJsonData <- fromJSON("https://api.github.com/users/bunmiaj/repos")

names(ajJsonData )

ajJsonData$name





#source("connecting_to_database.R")


sail_con <- dbConnect(RPostgres::Postgres(),
                      dbname = dsn_database,
                      host = dsn_host,
                      port = 5432,
                      user = "postgres",
                      password = dsn_password)


#list the number of tables 
ls = dbListTables(sail_con) 
ls

#read data 
data = DBI::dbReadTable(sail_con, 'cscc_african_tweets')

#clearing the memory of my R studio
rm(list=ls())

install.packages("skimr")
library(skimr)
data_uber <- read.csv("C:/Users/Open User/Downloads/Uber_Data (1).csv")
view(data_uber)
dim(data_uber)
str(data_uber)
skim(data_uber)    
(summary(data_uber))
names = c(unique(na.omit(data_uber$borough)))


names
grouped = summarise(na.omit(group_by(data_uber, borough)),Freq=n())
grouped


pairs(data_uber[3:6])
pairs(data_uber[3:12])



