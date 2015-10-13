#Clear environment
rm(list = ls())
gc()

#SetWD
setwd("C:/Users/dhenebery/Desktop/PCSA")

#Query Twiter
source("CandidateTwitterQuery.R")

#Clean Tweets
source("CleanTweets.R")

#Export Data
write.csv(tweets.df, paste0("Output/PCSA_", Sys.Date(), ".csv"), row.names = FALSE)

#Tabula Rasa
rm(list = ls())
gc()

#Import all
fileList <- dir("Output/", pattern = "\\.csv")
tweets_all <- data.frame()

for(file in fileList){
temp <- read.csv(paste0("Output/",file), stringsAsFactors = FALSE)
print(file)
flush.console()
tweets_all <- rbind(tweets_all, temp)
}

rm(temp, file, fileList)

# Remove duplicated tweets
tweets_all <- tweets_all[!duplicated(tweets_all$id),]

#Define DTM Function
source("CreateDTM.R")

#Create DTM
tweets_all_DTM <- textProcess(tweets_all$clean, maxToken = 2, sparse = .98)



#Topic Modeling
source("TopicModeling.R")

#Sentiment Analysis
source("")



