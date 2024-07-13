-library(tidyverse)

-library(shiny)

-Rtools

Shiny is made by R Studio (Posit).

Shiny is a platform for creating interactive R programs embedded into a web page.

With Shiny, we can create simple, yet powerful, web-based interactive data products in R (time and initial dependency on designers).

Following our sesssion on ML, let’s say that you created a prediction algorithm. You can very easily create web input form that calls your prediction algorithm in R and displays the results (interactive data solution).

When I was learning R, " ... it lacks the flexibility of full featured (and more complex) solutions".

Shiny prerequisites
Shiny doesn’t really require it, but as with all web programming, a little knowledge of html, css and js is very helpful

html gives a web page structure and sectioning as well as markup instructions

css gives the style

js for interactivity

There are more than sufficient materials online on Shiny R.

Let’s say we create a prediction algorithm to predict risk for developing diabetes.

You’re hoping patients and caregivers will be able to enter their data and, if needed, take preventative measures.

You want to create a web site so that users can input the relevant predictors and obtain their prediction.

diabetesRisk <- function(glucose) glucose / 200
Getting started
Make sure you have the latest release of R installed

If on windows, make sure that you have Rtools installed

install.packages("shiny")

Great tutorial at http://rstudio.github.io/shiny/tutorial/
  
  Basically, this lecture is walking through that tutorial offering some of our insights

Project Directory
A shiny directory containing at least two parts. The two parts can also be combined as a file but we will start off with them as 2 different files.

ui.R : This controls the look i.e., the user’s interface.

server.R : This controls what our app does.

ui.R
library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("Data science SAIL!"),
  
  sidebarPanel(
    h3('Sidebar text')
  ),
  mainPanel(
    h3('Main Panel text')
  )
))
server.r
library(shiny)
shinyServer(
  function(input, output) {
  }
)
To run it
In R, change to the directories with these files and type runApp()

or put the path to the directory as an argument

It should open an browser window with the app running

simplestApp
simplestApp
R functions for HTML markup
ui.R

shinyUI(pageWithSidebar(
  headerPanel("Illustrating markup"),
  sidebarPanel(
    h1('Sidebar panel'),
    h1('H1 text'),
    h2('H2 Text'),
    h3('H3 Text'),
    h4('H4 Text')
    
  ),
  mainPanel(
    h3('Main Panel text'),
    code('some code'),
    p('some ordinary text')
  )
))
markup
markup


Illustrating inputs ui.R
shinyUI(pageWithSidebar(
  headerPanel("Illustrating inputs"),
  sidebarPanel(
    numericInput('id1', 'Numeric input, labeled id1', 0, min = 0, max = 10, step = 1),
    checkboxGroupInput("id2", "Checkbox",
                       c("Value 1" = "1",
                         "Value 2" = "2",
                         "Value 3" = "3")),
    dateInput("date", "Date:")  
  ),
  mainPanel(
    
  )
))
inputs
inputs

mainPanel(
  h3('Illustrating outputs'),
  h4('You entered'),
  verbatimTextOutput("oid1"),
  h4('You entered'),
  verbatimTextOutput("oid2"),
  h4('You entered'),
  verbatimTextOutput("odate")
)

shinyServer(
  function(input, output) {
    output$oid1 <- renderPrint({input$id1})
    output$oid2 <- renderPrint({input$id2})
    output$odate <- renderPrint({input$date})
  }
)

shinyUI(
  pageWithSidebar(
    # Application title
    headerPanel("Diabetes prediction"),
    
    sidebarPanel(
      numericInput('glucose', 'Glucose mg/dl', 90, min = 50, max = 200, step = 5),
      submitButton('Submit')
    ),
    mainPanel(
      h3('Results of prediction'),
      h4('You entered'),
      verbatimTextOutput("inputValue"),
      h4('Which resulted in a prediction of '),
      verbatimTextOutput("prediction")
    )
  )
)

server.R
diabetesRisk <- function(glucose) glucose / 200

shinyServer(
  function(input, output) {
    output$inputValue <- renderPrint({input$glucose})
    output$prediction <- renderPrint({diabetesRisk(input$glucose)})
  }
)

Image example
Let’s build an example with an image

How about we create a histogram of data

Put a slider on so that the user has to guess the mean
ui.R
shinyUI(pageWithSidebar(
  headerPanel("Example plot"),
  sidebarPanel(
    sliderInput('mu', 'Guess at the mean',value = 70, min = 62, max = 74, step = 0.05,)
  ),
  mainPanel(
    plotOutput('newHist')
  )
))
server.R
library(UsingR)
data(galton)

shinyServer(
  function(input, output) {
    output$newHist <- renderPlot({
      hist(galton$child, xlab='child height', col='lightblue',main='Histogram')
      mu <- input$mu
      lines(c(mu, mu), c(0, 200),col="red",lwd=5)
      mse <- mean((galton$child - mu)^2)
      text(63, 150, paste("mu = ", mu))
      text(63, 140, paste("MSE = ", round(mse, 2)))
    })
    
  }
)

Tighter control over style
All of the style elements are handled through ui.R

For students with a lot of experience in html, js, css it would be a breeze and probably easier and more flexible than the R html controls in ui.R

bslib has changed so many things about R Shiny (Read more on this)



install.packages("shiny")
library(shiny)

install.packages("tidyverse")
library(tidyverse)

getwd()

setwd("C:/Users/Open User/Downloads/UI and Server")

runApp("C:/Users/Open User/Downloads/UI and Server")



-All of the style elements are handled through ui.R

-For students with a lot of experience in html, js, css it would be a breeze and probably easier and more flexible than the R html controls in ui.R

-bslib has changed so many things about R Shiny (Read more on this)

-Allow users to upload or download files

-Have tabbed main panels

-Have editable data tables

-Have a dynamic UI

-User defined inputs and outputs

-Put a submit button so that Shiny only executes complex code after user hits submit

-Distributing a Shiny app
-The quickest way is to send (or put on github or gist or dropbox or whatever) someone the app directory and they can then call runApp

-You could create an R package and create a wrapper that calls runApp

-Of course, these solutions only work if the user knows R

-Another option is to run a shiny server

-Requires setting up a (Shiny server)

-Probably easiest if you use one of the virtual machines where they already have Shiny servers running well (for example, on AWS)
-Avoid putting system calls in your code (this is one of the first things many of us do for fun, but it introduces security concerns)



