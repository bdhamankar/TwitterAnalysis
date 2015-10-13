#Create Dist Matrix
test <- dist(tweets_all_DTM)

#Hclust
set.seed(42)
test2 <- hclust(test, method = "ward.D")

#Select K based on scree plot
clusters = 10:40											#create cluster vector
w.SS = rep(0, 31)											#create blank wSS vector
for(i in 1:length(w.SS)){									#use forloop to calculate SS for each cluster
  w.SS[i] = kmeans(cars, i)$tot.withinss}					

plot(cluster, w.SS, type = "l", xlab = "Number of Clusters", ylab = "Within SS")

# Calculate Within SS
test3 <- data.frame(h3 = as.factor(cutree(test2, k=3)), as.matrix(tweets_all_DTM))
centroids <- aggregate(test3[,-1], by = list(test3$h3), function(x) mean(x), simplify = TRUE)
str(centroid)
x <- dim(as.matrix(test3[,-1])) - dim(as.matrix(centroid[1,-1]))

#Order Clusters by within SS (low to high) and eliminate dispersed clusters (presumed to be garbage clusters)


