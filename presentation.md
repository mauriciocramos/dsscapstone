Word Prediction Application
========================================================
author: Mauricio Ramos
date: May 24, 2018
autosize: false

Word prediction aplication
========================================================

This is a prototype [Shiny](http://www.shinyapps.io/) application required by the capstone project of the [Johns Hopkins University's Data Science Specialization](https://www.coursera.org/learn/data-science-project).

The application takes a phrase as input and outputs a prediction of the next word using a Natural Language Processing (NLP) machine learning model trained from a large corpora of English texts from Blogs, News and Twitter available [here](https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip).


The NLP machine learning model
========================================================

It was based on technologies and techniques cited in the last slide.  The overall steps taken are:

1. Build a corpus from 3 English files containing 4M+ lines of 100M+ words, with a size of 552 MB;
2. Segment the 4M+ lines in 8M+ sentences;
3. Generate 116M+ lowercased unigrams removing numbers, non-word characters, URLs, and words longer than 20;
4. Generate n-gram frequency tables for orders 1 to 5;
5. Remove singletons from n-gram tables of order 4 and 5;
6. Compress data using integers rather than floating numbers and factors rather than characters;
7. Keep only the first highest frequent n-gram by each n-1 words.

The prediction algorithm
========================================================

Currently it's a basic prediction algorithm that prioritizes the responsiveness and the low-memory usage.

It limits to the maximum of 4 predictor words.

It seeks the last _k_ predictor words in the _k+1_ n-gram table.

If the last _k_ predictor words weren't found it seeks the last _k-1_ predictor words in the _k+2_ n-gram tables and so on.

How to use the application
========================================================

1. Go to https://mauriciocramos.shinyapps.io/predictWord/

2. Type in one ore more words

3. Press the button

4. See the predicted word just bellow the button.

References
========================================================

- [CRAN Task View: Natural Language Processing](https://cran.r-project.org/web/views/NaturalLanguageProcessing.html)
- [Text Mining Infrastructure in R](https://www.jstatsoft.org/article/view/v025i05)
- Wikipedia: [Natural-language processing](https://en.wikipedia.org/wiki/Natural-language_processing), [n-gram]([Wikpediahttps://en.wikipedia.org/wiki/N-gram), [Language Model](https://en.wikipedia.org/wiki/Language_model)
- [Stanford University professor Dan Jurafsky's slides and videos about NLP](http://web.stanford.edu/~jurafsky/)
- [R language](https://www.r-project.org/) and [RStudio](https://www.rstudio.com/)
- [R's quanteda: Quantitative Analysis of Textual Data](https://cran.r-project.org/web/packages/quanteda/index.html)
- [R's data.table: Extension of 'data.frame'](https://cran.r-project.org/web/packages/data.table/index.html)

