library(shiny)
library(ggplot2)
library(shinyBS) # Additional Bootstrap Controls
start_year = 2014

ui <- shinyUI(fluidPage(
  
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
  ),
  
  titlePanel(h1("Public Pensions Modeling", align="left")),
  
  p( tags$small("The graphs below project the state of the Illinois pension fund. By adjusting variables like inflation rate, mortality, and salary growth you can forecast how changes will affect pension liability.")
    
  ), br(),
  
  sidebarPanel(
    tabsetPanel(
    tabPanel("Valuation",br(),
      sliderInput('disc','Discount Rate',0,10,5,step=0.5),
      bsPopover(id = "disc", title = "Change the Discount Rate", 
                content = paste("Placeholder: Discount rate is basically the reverse of the inflation rate between now and some point in the future."),
                placement = "right", trigger = "hover"),
      #sliderInput('ror',"Asset Rate of Return",0,10,5,step=0.5),
      #sliderInput('cof',"Cost of Funds",0,10,5,step=0.5),
      sliderInput('ben',"Benefit Growth Rate", 0, 10, 3,step=0.5),
      bsPopover(id='ben', title = "Change the Growth Rate",
                content = paste("Placeholder: The rate at which benefits are expected to grow"),
                placement = "right", trigger = "hover"),
      sliderInput('inf',"Inflation Rate",0,10,3,step=0.5),
      bsPopover(id='inf', title = "Change the Inflation Rate",
                content = paste("Placeholder: The rate at which currency is expected to depreciate"),
                placement = "right", trigger = "hover"),
      sliderInput('salary',"Salary Growth Rate", 0, 10, 3.5, step=0.5),
      bsPopover(id='salary', title = "Change the Salary Growth Rate",
                content = paste("Placeholder: The rate at which state salaries are expected to grow"),
                placement = "right", trigger = "hover"),
      
      sliderInput('mort',"Mortality Adjustment",0, 10, 0),
      bsPopover(id = "mort", title = "Extend life expectency", 
                content = paste("We used the same mortaility table assumptions from the ",
                                "acturial report. This can shift table to reflect a ",
                                "longer life expectency"),
                placement = "right", trigger = "hover"),
    
      
      sliderInput('retire',"Retirement Delay",0, 10, 0),
      bsPopover(id = "retire", title = "Delay the average retirement age", 
                content = paste("We used average retirement patterns from the actuarial reports, ",
                                "this can shift it later"),
                placement = "right", trigger = "hover")),
    
    tabPanel("Payoff",br(),
             sliderInput('tfr',"Target Funding Ratio",0,120,100,step=5),
             sliderInput('amort',"Amortization Period",0,60,30,step=5),
             bsPopover(id = "amort", title = "How long to pay off the shortfall?", 
                       content = paste("Use this slider to set a period the state will pay",
                                       " off the shortfall. The longer you take the more interest you pay"),
                       placement = "right", trigger = "hover"),
             sliderInput('amortdelay',"Amortization Delay",0,10,0,step=1)
      )),
      #sliderInput('npers',"Years in Forecast",10,100,30,step=5),
      #sliderInput('rr',"Replacement Rate",0, 2, 0, step=0.1),
      #sliderInput('cont',"Contribution Rate", 0, 15, 11, step=1))),
    width = 3
  ),
  
  mainPanel(
    tabsetPanel(
      tabPanel("Funding",br(),br(),
               #hr(),
               plotOutput('assetliabilityPlot'), #, width = "250px", height = "250px"),
               p("The Asset Liability Plot displays the total assets of the pension fund, compared to the projected liabilities, and currently unfunded remainder."),
               #textOutput('pensionAssets'),
               #textOutput('pensionLiabilities'),
               #textOutput('fundingRatio'),
               #textOutput('contributionTarget'),
               br(),hr(),plotOutput('flowsPlot'),
               p("The Flows Plot models projected pension benefits in millions of dollars to various groups of payees.")
               ),
      
      tabPanel("Amortization",br(),br(),
               h3(textOutput('requiredAnnualContribution'),align='center'),br(),
               plotOutput('amortPlot'),br(),
               p("This graph projects the state's pension commitment if new expenses stopped today. The black line reflects the cashflow (in millions of dollars) necessary to honor the state's pension commitment. Asset income and state payment reflect money going into the system, while benefits paid reflect money paid out.")
               
               ),
      tabPanel("Valuation Details",br(),h3("Results of Actuarial Valuation")
               ,br(),tableOutput('details'),align="center"),
      tabPanel("Population",br(),
               uiOutput("timeSlider"),hr(),
               h3("Population Distribution",align="center"),
               br(),plotOutput('count_plot'),br(),
               p("This projects the distribution of pension recipients into the future if new expenses stopped today.")
               
               ),
      tabPanel("Downloads",br(),selectInput('forecastData',"Select Forecast",choices=c("Initial Annuitant Forecast" = 1,"Initial Annuitant Benefits Forecast" = 2, 
                "Initial Survivor Forecast" = 3, "Initial Survivor Benefits Forecast" = 4, "Initial Actives Forecast" = 5, "Beneficiaries from Actives Forecast" = 6, 
                "Actives Benefits Forecast" = 7, "Initial Inactives Forecast" = 8, "Beneficiares from Inactives Forecast" = 9, "Initial Inactives Benefits Forecast" = 10,
                "Amortization of UAAL" = 11),selected=1),br(),
                downloadButton('downloadData','Download'))
    )
  )
))
