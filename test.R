

modupe <- as.integer(100.9999)

modupe

comp <- 12 + 31

comp
class(comp)
idris <- 2000

modupe <- idris + 1000
modupe
 kemi <- modupe + modupe
kemi
#glimpse(covid_data)


#question 1
for (n in 1:10)
  print(n)
 
#question 2
fact <- function(num) {
  if (num < 0) {
    return("Fact is undefined for negative numbers")
  }
  else if (num ==0){
    return (1)
  }
  facto <- 1
  for (i in 1:num) {
    facto <-facto * i
  }
  return(facto)
}
print(fact(5))                                                                                                                                                                        
                                               

#question 3
odd <- function(a, b) {
  print(c(a,b))
  summ <- c()
  for (n in c(a:b)) {
    if ( n %% 2 == 1) {
      summ <- c(summ, n)
    }
  }
  print(sum(summ))
}
odd(2,9)










