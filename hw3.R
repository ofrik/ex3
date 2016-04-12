#install.packages("igraph")
library(igraph)
setwd("E:/Dropbox/Ofri & Guy/DS_again/hw3")

ga.data <- read.csv('./ga_edgelist.csv', header = T)
head(ga.data)
g <- graph.data.frame(ga.data,directed = F)
g <- simplify(g)

V(g)$name
head(E(g))
g$layout <- layout.fruchterman.reingold(g)
plot(g)

degr.score <- degree(g)
degr.score

V(g)$size <- degree(g) * 3 # multiply by 2 for scale 
plot(g) 

## Closeness centrality.
clo <- closeness(g) 
V(g)$color <- "gray"
V(g)$size <- clo*5000
V(g)$label <- V(g)$name
plot(g)
clo
which.max(clo)
# torres is the most central by Closeness

## Betweeness centrality.
btw <- betweenness(g) 
V(g)$color <- "gray"
V(g)$size <- btw/4
V(g)$label <- V(g)$name
plot(g)
btw
which.max(btw)
# sloan is the most central by Betweeness

## Eigenvector centrality.
eig <- centr_eigen(g)
V(g)$color <- "gray"
V(g)$size <- eig$vector*10
V(g)$label <- V(g)$name
plot(g)
eig$vector
V(g)[which.max(V(g)$size)]
# karev is the most central by Eigenvector

## Community strucure via short random walks
fc <- walktrap.community(g)
memb <- membership(fc)
plot(g, vertex.size=5, vertex.label=V(g)$name,vertex.color=memb+1, asp=FALSE)
describe(memb)
#number of communities and their size
table(memb)
#the modularity
modularity(fc)

## Girvan-Newman community detection algorithm
gnc <- edge.betweenness.community(g, directed=FALSE)
memb2 <- membership(gnc)
plot(g, vertex.size=5, vertex.label=V(g)$name,vertex.color=memb2+1, asp=FALSE)
#number of communities and their size
table(memb2)
#the modularity
modularity(gnc)