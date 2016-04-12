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
plot(g)
clo
which.max(clo)
# torres is the most central by Closeness

## Betweeness centrality.
btw <- betweenness(g) 
V(g)$color <- "gray"
V(g)$size <- btw/4
plot(g)
btw
which.max(btw)
# sloan is the most central by Betweeness

## Eigenvector centrality.
eig <- centr_eigen(g)
V(g)$color <- "gray"
V(g)$size <- eig$vector*10
plot(g)
eig$vector
V(g)[which.max(V(g)$size)]
# karev is the most central by Eigenvector

gnc <- edge.betweenness.community(g, directed=FALSE)
V(g)$color <- gnc$membership
V(g)$size <- 5 # Set same size to all nodes
plot(g)

g$layout <- layout.kamada.kawai(g)
plot(g)


no.clusters(g)
## [1] 3
cl <- clusters(g)
which.max(cl$csize)
## [1] 1
cl$membership == which.max(cl$csize)
to.keep <- which(cl$membership == which.max(cl$csize))
g_gc <- induced.subgraph(g, to.keep)
summary(g_gc)
## IGRAPH UN-- 24 28 -- 
## attr: name (v/c), gender (v/c), size (v/n), color (v/c)
g_gc$layout <- layout.sphere(g_gc)
plot(g_gc)
