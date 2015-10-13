# Load Packages
require(RWeka)
require(tm)

# Define Text Processing Function
textProcess <- function(textVector, Dict = NULL, minToken = 1, maxToken = 1, sparse = .98){
  
  # Correct encoding
  tempText <- iconv(enc2utf8(as.character(textVector)), sub = "bytes")
  
  # Generate Corpus
  txtCorpus <- VCorpus(VectorSource(tempText))
  txtCorpus <- tm_map(txtCorpus, content_transformer(tolower))
  txtCorpus <- tm_map(txtCorpus, removePunctuation)
  txtCorpus <- tm_map(txtCorpus, removeNumbers)
  txtCorpus <- tm_map(txtCorpus, removeWords, stopwords("english"))
  txtCorpus <- tm_map(txtCorpus, stemDocument)
  
  # Create tokenizer
  Tokenizer <- function(x) NGramTokenizer(x, Weka_control(min = minToken, max = maxToken))
  
  # Generate DTM
  dtm.control <- list(
    wordLengths = c(3, Inf),
    #weighting = function(x) weightTfIdf(x, normalize = FALSE),
    tokenize = Tokenizer,
    dictionary = Dict)
  
  tempDTM <- DocumentTermMatrix(txtCorpus, control = dtm.control)
  
  if(is.null(Dict)) {
    tempDTM <- removeSparseTerms(tempDTM, sparse)
  }
  
  # Drop hyperlink terms
  tempDTM <- tempDTM[,!grepl("http", dimnames(tempDTM)$Terms)]
  
  # Drop responses with no text
  tempDTM <- tempDTM[rowSums(as.matrix(tempDTM)) > 0,]
  
  return(tempDTM)
}
