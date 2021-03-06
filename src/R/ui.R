library(shiny)
library(ggplot2)
library(shinyBS) # Additional Bootstrap Controls
start_year = 2014

ui <- shinyUI(fluidPage(
  
  titlePanel(p("Illinois GARS Pension Model",align="center")),br(),
  
  sidebarPanel(
    tabsetPanel(
    tabPanel("Valuation",br(),
      sliderInput('disc','Discount Rate',0,10,5,step=0.5),
      #sliderInput('ror',"Asset Rate of Return",0,10,5,step=0.5),
      #sliderInput('cof',"Cost of Funds",0,10,5,step=0.5),
      sliderInput('ben',"Benefit Growth Rate", 0, 10, 3,step=0.5),
      sliderInput('inf',"Inflation Rate",0,10,3,step=0.5),
      sliderInput('salary',"Salary Growth Rate", 0, 10, 3.5, step=0.5),
      
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
               #textOutput('pensionAssets'),
               #textOutput('pensionLiabilities'),
               #textOutput('fundingRatio'),
               #textOutput('contributionTarget'),
               br(),hr(),plotOutput('flowsPlot')),
      tabPanel("Amortization",br(),br(),
               h3(textOutput('requiredAnnualContribution'),align='center'),br(),
               plotOutput('amortPlot'),br()),
      tabPanel("Valuation Details",br(),h3("Results of Actuarial Valuation")
               ,br(),tableOutput('details'),align="center"),
      tabPanel("Population",br(),
               uiOutput("timeSlider"),hr(),
               h3("Population Distribution",align="center"),
               br(),plotOutput('count_plot'),br())
      ,tabPanel("Downloads",br(),selectInput('forecastData',"Select Forecast",choices=c("Initial Annuitant Forecast" = 1,"Initial Annuitant Benefits Forecast" = 2, 
                "Initial Survivor Forecast" = 3, "Initial Survivor Benefits Forecast" = 4, "Initial Actives Forecast" = 5, "Beneficiaries from Actives Forecast" = 6, 
                "Actives Benefits Forecast" = 7, "Initial Inactives Forecast" = 8, "Beneficiares from Inactives Forecast" = 9, "Initial Inactives Benefits Forecast" = 10,
                "Amortization of UAAL" = 11),selected=1),br(),
                downloadButton('downloadData','Download'))
    )
  )
))
