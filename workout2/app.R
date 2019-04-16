#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# Example discussed in lecture April-08-2019


#Q for OH - balance table is different than the one professor shows. How should I change it?
#Q for OH - how can I do the facetted graph part - 
library(shiny)
library(ggplot2)
library(reshape2)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Investing Scenarios: No Contribution, Fixed Contribution, and Growing Contribution"),
  
  # Sidebar with a slider input for number of bins 
  fluidRow(
    column(4, 
           sliderInput("initial",
                       "Initial Amount",
                       min = 0,
                       max = 100000,
                       value = 1000,
                       step = 500)),
    column(4, 
           sliderInput("rate",
                       "Return Rate (in %)",
                       min = 0, 
                       max = 0.20,
                       value = 0.05, 
                       step = 0.01)),
    
    column(4, 
           sliderInput("years", "Years",
                       min = 1, max = 50,
                       value = 20)), 
    
    column( width=4, sliderInput("annual",
                          "Annual Contribution",
                          min = 0, 
                          max = 50000,
                          value = 2000, 
                          step = 500)),
    
    column(width =4, sliderInput("growth",
                          "Growth Rate (in %)",
                          min = 0, 
                          max =0.20,
                          value = 0.02, 
                          step = 0.01)),
    
    column(width=4,selectInput("facet", "Facet?", c("Yes", "No"))
  ), 

  

    
    mainPanel(
      h3("Timelines"),
      plotOutput("Plot"),
      h3("Balances"),
      tableOutput("mytable")
      )
  )
)

#' @title future value 
#' @description calculates the future value of an investment
#' @param amount initial invested amount
#' @param rate annual rate of return 
#' @param years number of years 
#' @return computed future value of an investment 

future_value <- function(amount, rate, years) {
  return(amount*((1+rate)^years))
}

#' @title future value of annuity 
#' @description calculates the future value of annuity 
#' @param contrib contributed amount 
#' @param rate annual rate of return 
#' @param years number of years
#' @return computed future value of annuity 


annuity <- function(contrib, rate, years) {
  return(contrib*(((1+rate)^years -1)/rate))
}

#' @title future value of growing annuity 
#' @description calculates the future value of growing annuity 
#' @param contrib contributed amount 
#' @param rate annual rate of return 
#' @param growth annual growth rate
#' @param years number of years
#' @return computed future value of annuity 

growing_annuity <- function(contrib, rate, growth, years){
  return(contrib*(((1+rate)^years - (1+growth)^years)/(rate-growth)))
}
# Define server logic required to draw a histogram
server <- function(input, output) {
  
  dat <- reactive({
    no_contrib <- rep(0,input$years)
    fixed_contrib <- rep(0,input$years)
    growing_contrib <- rep(0,input$years)
    
    for (i in 1:input$years) {
      fixed_contrib[i] <- future_value(input$initial, input$rate, i) + annuity(input$annual, input$rate, i)
    }
  
    for (i in 1:input$years){
      no_contrib[i] <- future_value(input$initial, input$rate, i) 
    }
    for (i in 1:input$years){
      growing_contrib[i] <- future_value(input$initial,input$rate, i) + growing_annuity(input$annual, input$rate, input$growth, i)
    }

    initial <- rep(1000,3)
    dat <- data.frame(no_contrib, fixed_contrib, growing_contrib)
    dat <- rbind(initial, dat)
    dat$year <- 0:input$years
    dat <- dat[,c('year','no_contrib', 'fixed_contrib', 'growing_contrib')]
   
    return(dat)
  
  })

  output$Plot <- renderPlot({
    melt <- melt(dat(), id.vars = "year")
    if (input$facet == "No"){
         ggplot(data = melt, aes(x=year)) + 
           geom_line(aes(y=value, color=variable)) 
    } else {
      ggplot(data = melt, aes(x=year, fill = variable)) + 
        geom_area(aes(x=year, y =value), alpha=.4) + 
        geom_line(aes(y=value, color = variable)) + 
        facet_grid(~variable) 
      
    }
  })
    
    output$mytable = renderTable({
      (dat())
    })
}
  
  

# Run the application 
shinyApp(ui = ui, server = server)