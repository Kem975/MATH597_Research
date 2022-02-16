library(pls)

#Get the data
df.x = read.csv("../data/X.csv")
df.y = read.csv("../data/Y.csv")

df.x$date <- c()

df.data <- cbind(df.x, df.y)


# Create an array with the unique dates
dates <- unique(as.Date(df.data$date))
dates <- na.omit(dates)

for (i in 1:(length(dates)-1)){
  
  #### Get the Data
  train = subset(df.data, date==dates[i])
  test = subset(df.data, date==dates[i+1])
  
  train$date <- c()
  test$date <- c()
  
  for (k in 1:49){
    var.col <- var(train[,k])
    mean.col <- mean(train[,k])
    
    if (var.col != 0){
      train[,k] <- (train[,k]-mean.col) / sqrt(var.col)
      test[,k] <- (test[,k]-mean.col) / sqrt(var.col) 
    }

  }
  
  #### Calculate the number of components
  plsr_fit <- plsr(xs_return~., data=train, rescale = F, validation="CV")
  var.explained = 0
  comp.num = 0
  
  while( var.explained<0.8 ){
    comp.num <- comp.num + 1
    var.explained <- as.numeric((sum(plsr_fit$Xvar[1:comp.num]))/plsr_fit$Xtotvar)
  }
  print(comp.num)
  
  #### Perform the PLS on train and test
  plsr.input <- plsr(formula = xs_return~., ncomp = comp.num, data=train, rescale = F)
  PLS_Score.input <- scores(plsr.input)
  
  plsr.test <- plsr(formula = xs_return~., ncomp = comp.num, data=test, rescale = F)
  PLS_Score.test <- scores(plsr.test)
  
  #### Adjust the data
  x_train <- as.matrix(PLS_Score.input) # Had a rescale
  y_train <- train$xs_return
  
  x_test <- as.matrix(PLS_Score.test) # Had a rescale
  y_test <- test$xs_return

  write.csv( x_train, sprintf("%s_x_train.csv",dates[i]) )
  write.csv( x_test, sprintf("%s_x_test.csv",dates[i]) )
  write.csv( y_train, sprintf("%s_y_train.csv",dates[i]) )
  write.csv( y_test, sprintf("%s_y_test.csv",dates[i]) )
  
  if(i==20){
    break
  }
}

