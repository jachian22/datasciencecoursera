PA1 Template
=============

Here we're going to load the data.


```r
amd <- read.csv('activity.csv')
amd$date <- as.Date(amd$date)
summary(tapply(amd$steps, amd$date, sum))
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##      41    8840   10800   10800   13300   21200       8
```

Now that the data is loaded let's see the distribution of the data.

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2.png) 

Now let's see the average activity over time.

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3.png) 

Now let's see which 5-minute interval had the most steps on average.


```r
intervals <- tapply(amd$steps, amd$interval, mean)
amd$interval[max(intervals)]
```

```
## [1] 1450
```

After poking through the data, you will noticed there are quite a few missing values.


```r
mydf <- read.csv('activity.csv')
mydf$date <- as.Date(mydf$date)
missingvalues <- mydf[is.na(mydf$steps),]
nrow(missingvalues) #2304 NA values
```

```
## [1] 2304
```

To replace the missing values let's set them equal to the average number of steps
up to that interval for that day.


```r
missingvalues <- is.na(mydf$steps)

mydf$steps[is.na(mydf$steps)] <- 0
for (i in 1:nrow(mydf)) {
  if (mydf$interval[i] == 0) {
    counter = 1
    sum = mydf$steps[i]
    mydf$avgsteps[counter] = sum
  }
  else {
    counter = counter + 1
    sum = sum + mydf$steps[i]
    mydf$avgsteps[i] = sum / counter
  }
}

mydf$steps[missingvalues] <- mydf$avgsteps[missingvalues]

summary(tapply(mydf$steps, mydf$date, sum))
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##       0    6780   10400    9350   12800   21200
```

Here's the distribution of the processed data.

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-7.png) 

Let's see how it compares to the original data.


```r
summary(tapply(amd$steps, amd$date, sum))
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##       0    6780   10400    9350   12800   21200
```

![plot of chunk unnamed-chunk-9](figure/unnamed-chunk-9.png) 

Seems like the method to replace the missing data didn't skew the distribution much
if at all.

Lastly let's see the differences in activity between weekdays and weekends

![plot of chunk unnamed-chunk-10](figure/unnamed-chunk-10.png) 
