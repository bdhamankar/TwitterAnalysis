#Load Packages
library(tm)
library(stringr)

#Concatenate letter to tweet ID
twitterRaw$id <- paste0("A", twitterRaw$id)
twitterRaw$replyToSID <- ifelse(twitterRaw$replyToSID == "NA", NA, paste0("A", twitterRaw$replyToSID))
twitterRaw$replyToUID <- ifelse(twitterRaw$replyToUID == "NA", NA, paste0("A", twitterRaw$replyToUID))

#Clean Tweets
tweets.df <- twitterRaw

tweets.df$clean <- tweets.df$text
tweets.df$clean <- gsub("<.*>", "", tweets.df$clean)
tweets.df$clean <- gsub("http.*", "", tweets.df$clean)
tweets.df$clean <- gsub("\n", "", tweets.df$clean)
tweets.df$clean <- gsub("\\\\", "", tweets.df$clean)
tweets.df$clean <- gsub("?", "", tweets.df$clean)
tweets.df$clean <- gsub("@", "", tweets.df$clean)
tweets.df$clean <- gsub("[^[:alnum:][:space:]+\"]", "", tweets.df$clean)
tweets.df$clean <- tolower(tweets.df$clean)

#Remove Stopwords
tweets.df$uncommon <- tweets.df$clean
myStopwords <- c(stopwords("english"))

'%nin%' <- Negate('%in%')
tweets.df$uncommon <- lapply(tweets.df$uncommon, function(x) {
  t <- unlist(strsplit(x, " "))
  t[t %nin% myStopwords]
})

l <- nrow(tweets.df)
for(i in 1:l){
  tweets.df$uncommon[[i]] <- paste(tweets.df$uncommon[[i]], collapse=" ")
}

tweets.df$uncommon <- unlist(tweets.df$uncommon)
head(tweets.df$uncommon)

#create date/time dimensions

# tweets.df$dtsplit <- str_split(tweets.df$created, " ")
# m <- nrow(tweets.df)
# for(i in 1:m){
#   tweets.df$time[[i]] <- tweets.df$dtsplit[[i]][[2]]
# }
# 
# for (i in 1:m){
#   tweets.df$date[[i]] <- tweets.df$dtsplit[[i]][[1]]
# }

# Remove duplicated tweets
tweets.df <- tweets.df[!duplicated(tweets.df$id),]