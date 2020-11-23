# taken from session 4, Computational Statisitcs Course, Spring 2020, Prof. Marloes Maathuis
# Rcode4.R

# Cross-validation:

# Package for knn classification:
library(class)

# Some new commands we will use:
?order
order(c(3,6,2,8,4,9,1),decreasing=T)
order(c(3,6,2,8,4,9,1),decreasing=F)

?cut
(folds <- cut(c(1:25),breaks=6,labels=FALSE))

?which
which(folds==2)


# Select variables with highest marginal correlations. 
# Inputs: 
#   x: predictors
#   y: dependent variable
#   q: nr of variables to be selected
# Outputs:
#   indices of q columns of x with highest marginal correlation with y
select.x <- function(x,y,q){
  # some simple checks on input values:
  stopifnot(is.matrix(x), nrow(x)==length(y), q>=1, q<=ncol(x))

  # compute cor(x[,i],y) for i=1,..,p:
  cor.vec <- apply(x,2,cor,y=y)
  
  # determine indices of variables, so that the absolute value of 
  #   their correlation with y is sorted in decreasing order: 
  ind <- order(abs(cor.vec), decreasing=TRUE)

  # return indices of q variables with largest absolute correlation
  return(ind[1:q])
}

# Conduct K-fold cross-validation for 1 NN classifier.
# Inputs:
#   x: predictors
#   y: dependent variable 
#   K: nr of folds in cross-validation
#   preselect: boolean indicating whether pre-selection should be 
#              conducted *within* cross validation. Defaults to FALSE.
#   q: nr of variables to be pre-selected. Defaults to 10. 
# Outputs:
#   error rate.
cv.knn1 <- function(x,y,K,preselect=FALSE,q=10){
  # quick checks of input:
  stopifnot(is.matrix(x), nrow(x)==length(y), 1<=K, K<=nrow(x),
            q>=1, q<=ncol(x))

  # randomly shuffle the rows:
  n <- length(y)
  ind.x <- sample(c(1:n), replace=FALSE)
  x <- x[ind.x,]
  y <- y[ind.x]
  
  # create K (roughly) equally sized folds:
  folds <- cut(seq(1,n),breaks=K,labels=FALSE)
  
  # perform K fold cross validation:
  error <- integer(K)
  for(i in 1:K){
    # Segment data by fold using the which() function 
    ind.test <- which(folds==i)
    x.test <- x[ind.test,]
    y.test <- y[ind.test]
    x.train <- x[-ind.test,]
    y.train <- y[-ind.test]
    
    # if preselect==TRUE, conduct selection of x variables inside CV
    if (preselect==TRUE){
      ind.x <- select.x(x.train, y.train, q)
      x.train <- x.train[,ind.x]
      x.test <- x.test[,ind.x]
    }
    
    y.pred <- knn1(x.train, x.test, y.train)  
    error[i] <- sum(y.pred != y.test)
  }
  return(sum(error/n))
}

### 

set.seed(123)

n <- 50       # sample size
p <- 5000     # nr of predictors
q <- 20       # nr of pre-selected predictors
K <- 10       # nr of folds in cross validation
nr.cv <- 50   # nr of K-fold cross validations that are performed
              #   we do this to see how much the results depend 
              #   on the way in which the folds were chosen
nsim <- 50    # nr of data sets that are simulated
              #   we do this to see how much the results vary over 
              #   different data sets

### Conduct cross-validation the wrong way for one data set:

# create high-dimensional data
x <- matrix(rnorm(n*p),nrow=n)
y <- c(rep(0,n/2),rep(1,n/2))
# note that x contains no information about y!

# pre-select q columns of x with strongest marginal correlation with y  
x.new <- x[,select.x(x,y,q)]

# assess performance of 1 NN classifier via K-fold cross validation.
# replicate this nr.cv times (so nr.cv times to determine the folds)
cv.wrong <- replicate(nr.cv, cv.knn1(x.new,y,K=10,preselect=FALSE))
plot(cv.wrong, ylim=c(0,1), ylab="CV error rate", 
     xlab="Iteration of K-fold CV, keeping data fixed",
     main="CV estimate of error rate; feature selection before CV")
abline(h=mean(cv.wrong),lty=2)
abline(h=0.5,col="blue")
legend("topleft",c("truth","mean of estimated error rates"),
       col=c("blue","black"),lty=c(1,2), bty="n")
# note there is small variation between the different iterations
# error rate is way too optimistic. 
# why?

# Now the correct way:
# assess performance of 1 NN classifier, using pre-selection within CV
cv.correct <- replicate(nr.cv, cv.knn1(x,y,K=10,preselect=TRUE,q=20))
plot(cv.correct, ylim=c(0,1), ylab="CV error rate", 
     xlab="Iteration of K-fold CV, keeping data fixed", 
     main="CV estimate of error rate; feature selection within CV")
abline(h=mean(cv.correct),lty=2)
abline(h=0.5,col="blue")
legend("topleft", c("truth","mean of estimated error rates"),
       col=c("blue","black"),lty=c(1,2), bty="n")
# there is more variability between the different iterations
# we are much closer to 50% than before
# but still a bit off

# average over various data sets
nsim <- 50
cv.correct2 <- numeric(nsim)
for(i in 1:nsim){
  x <- matrix(rnorm(n*p),nrow=n)
  y <- c(rep(0,n/2),rep(1,n/2))
  cv.correct2[i] <- cv.knn1(x,y,K=10,preselect=TRUE,q=20)
}
plot(cv.correct2, ylim=c(0,1), ylab="CV error rate", 
     xlab="Iteration of simulation (generating new training data)", 
     main="CV estimate of error rate; feature selection within CV")
abline(h=mean(cv.correct2),lty=2)
abline(h=0.5,col="blue")
legend("topleft",c("truth","mean of estimated error rates"),
       col=c("blue","black"),lty=c(1,2), bty="n")
# note large variability
# but this seems indeed an unbiased estimate of the expected test error rate
