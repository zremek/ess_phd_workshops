


s <- seq(0, 10, 0.1)
l <- exp(sqnc)

plot(x = s,
     y = l,
     xlab = "time spent with R",
     ylab = "data analysis skill level")


####################
# basic operations
####################


2 + 2 #+

4 - 1 #-

2 * 3 #*

2 / 3 #divide

3^2 # power: 3 to the power 2 or the 2nd power of 3

2^3


sqrt(9) #square root of 9

sqrt(16)



####################
# scalars
####################


a <- 2 + 2  # a scalar
a

b <- 4
b



####################
# vectors
####################

? c

d <- c(1, 2, 3) # a vector
d

x <- c(5, 10, 4, 9 , 1, 8)  # a vector
x


y <- c(2, 4, 5, -1, 7, -3)
y


x
x_1 <- 1 / x
x_1

length(x)
length(d)



#######################
# Missing values
#######################

u <- c(1:3, NA, 5, 6)
u

log.vec1 <- is.na(u)
log.vec1

is.na(u)
! is.na(u)

? is.na



########################
# Character Vectors
########################
varname <- c("X", "Y", "Z", "U", "V", "W")
varname
length(varname)




#########################
# Matrix:
#########################

x
y
z <- c(7, 19, 8, 12, 4, 8)

z
? cbind
cbind(x, y, z)
rbind(x, y, z)

X <- cbind(x, y, z)

m <- c(x, y, z)
m
X
X[2, 3]

X
X[1:3, ]
X[c(1, 4), ]


X1 <- X[(1:3), ] #this one is stored in a working memory
X1

X
X[(1:3), (2:3)] # this one is stored nowhere

X1
diag(X1)

X
t(X)



################
### Data Frame
################
case <- paste("Case00", 1:6, sep = "-")
case

paste("Case00", 1, sep = "-")
paste("Case00", 1:2, sep = "-")

case

y
u
z
is.na(u)

xData <- data.frame(case,
                    first = y,
                    second = u,
                    z,
                    miss.u = is.na(u))
xData

X1

xData

xData$miss.u

################
### List
################
case
x
xData

lst <- list(case, x, p = 0.05, data = xData)
lst

lst$data

lst[[2]]
lst$p
lst[["p"]]




###################################################
### Exploration of the data
###################################################
x #vector
length(x)

X #Matrix, capital letter
length(X)

xData #data.frame
length(xData)

lst #list
length(lst)


dim(x)
dim(X)
dim(xData)
dim(lst)



str(x)
str(X)
str(xData)
str(lst)







# ls()
# rm("a","b")
#
# rm(list=ls())
