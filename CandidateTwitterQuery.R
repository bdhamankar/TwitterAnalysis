#Load Packages
library(httr)
library(twitteR)


# Link to Twitter
apiKey <- "PKytAGZUnFfhDDnwT7EJhNIke"
apiSecret <- "TqO5ZAhbAZySa6MRSU9cHXLLrlSBPzb4u9ziFFj7TC6lw6h4bm"
access_token <-"2784254364-HSvFd9nWNUBMZa1ZJgkend6NpxTUNnfCCzgHYiL"
access_secret <- "ZTkQ1VcWmaCnFzxdo9edhdxqfDpaj4Iq0ACqQbIT4XwAw"
setup_twitter_oauth(apiKey, apiSecret, access_token, access_secret)

#Declare output(change name each day)
twitterRaw <- data.frame()

#Define search term vector
stv <- c("Gov Christie", "chris christie", "ben carson", "dr carson" ,"Carson -city -palmer",
         "Bush -george -airport -lite -IAH -stadium -reggie", "Jeb Bush", "Jeb", "Clinton", "Hillary",
         "Trump", "Sanders", "Biden", "Fiorina", "Presidential debate", "Candidate debate",
         "Jindal", "Rubio", "Cruz -santa -Azul -Soccer -roja", "Republican", "Democrat", "Democratic")

for(i in 1:length(stv)){

    searchTerm <- stv[i]
    cnt <- 1000
    
    print(paste0("Searching for ", searchTerm, "..."))
    flush.console()
    
    if(searchTerm %in% c("Bush -george -airport -lite -IAH -stadium -reggie", "Trump", "Clinton", "Hillary", "Cruz -santa -Azul -Soccer -roja")){
      cnt <- 3000
    }
    
    twitterRawTemp <- searchTwitter(searchTerm,
                          geocode = "39.80,-95.58,2500km",
                          since = as.character(Sys.Date() - 1),
                          until = as.character(Sys.Date()),
                          n=cnt)
    
    if(length(twitterRawTemp) == 0){
      print(paste0("No tweets found for ", searchTerm, "."))
      flush.console()
      next
    }
    
    twitterRawTemp <- twListToDF(twitterRawTemp) 
    
    #twitterRawTemp <- cbind(searchTerm = searchTerm, twitterRawTemp)
    twitterRaw <- rbind(twitterRaw, twitterRawTemp)
    
    print(paste0(searchTerm, " complete! ", nrow(twitterRawTemp), " tweets found."))
    flush.console()
    
    rm(twitterRawTemp)

}
