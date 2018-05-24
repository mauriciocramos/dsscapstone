library(shiny)

library(data.table); library(quanteda)
for (n in 1:5) load(paste0("dt", n, ".rda"))

predict.nextword <- function(x, maxwords=4) {
    require(data.table); require(quanteda)
    sentences <- unlist(tokens(x, what="sentence"))
    lastSentence <- sentences[length(sentences)]
    xs <- tokens(lastSentence, remove_numbers=T, remove_punct=T, remove_symbols=T,
                 remove_separators=T, remove_twitter=FALSE, remove_hyphens=T, remove_url=T)
    xs <- tokens_remove(xs, max_nchar = 20L)
    xs <- unlist(tokens_tolower(xs, keep_acronyms = FALSE), use.names = FALSE)
    xs <- xs[(max(length(xs), maxwords)-(maxwords-1)):length(xs)]
    xs <- sapply(xs, function(x) ifelse(is.na(dt1[x]$frequency), "#u#", x))
    while(length(xs) > 0) {
        dt <- paste0("dt", length(xs)+1)
        names(xs) <- paste0("x",1:length(xs))
        partialMatch <- data.table(t(xs))
        partialAnswer <- get(dt)[partialMatch, as.character(y), on=paste0("x",1:length(xs))]
        if(!is.na(partialAnswer)) return(partialAnswer)
        if(length(xs)>1) {
            beginningMatch <- data.table(t(c(x1="#s#",xs[-1])))
            beginningAnswer <- get(dt)[beginningMatch, as.character(y), on=paste0("x",1:length(xs))]
            if(!is.na(beginningAnswer)) return(beginningAnswer)
        }
        xs <- xs[-1]
    }
    dt1[order(-frequency)][1]$x1
}

ui <- fluidPage(
    titlePanel("Predict next word"),
    mainPanel(
        textAreaInput("text1", "Please input one or more words:", rows=5),
        submitButton("Predict"),
        br(),
        strong(textOutput("text2"))
    )
)

server <- function(input, output) {
    output$text2 <- renderText({
        if(trimws(gsub("\\s+", " ", input$text1))=="") ""
        else {
            # predicted <- predict.nextword(input$text1)(input$text1)
            # if(length(predicted)==0) "Can't predict the next word. Please try another last word"
            # else paste("Predicted next word:", predicted)
            paste("Predicted next word:", predict.nextword(input$text1))
        }
    })
}

# Run the application 
shinyApp(ui = ui, server = server)

