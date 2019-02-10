library(httr)
library(httpuv)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
'
oauth_endpoints("github")
'
# 2. To make your own application, register at
#    https://github.com/settings/developers. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
'
myapp <- oauth_app("github",
                   key = "66e0a010aafeb7342f72",
                   secret = "353c32604898c63e44b0b12144567bd5e0488456"
)
'
# 3. Get OAuth credentials
'
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
'
# 4. Use API
'
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/rate_limit", gtoken)
stop_for_status(req)
content(req)'

# OR:
'
req <- with_config(gtoken, GET("https://api.github.com/rate_limit"))
stop_for_status(req)
content(req)'


"WEEK 3: SUBSETTING AND SORTING"

set.seed(13425)
x <- data.frame("var1" = sample(1:5), "var2" = sample(6:10), "Var3" = sample(11:15))
x <- x[sample(1:5),]; x$var2[c(1,3)] = NA

x[,1] #brief recap of subsetting
x[, "var1"] #looking @ one column
x[1:2, "var2"] #OR looking @ one column and certain rows

x[(x$var1 <= 3 & x$Var3 > 11), ] #show rows in var1 where x<= 3 and var3 > 11
x[(x$var1 <= 3 | x$Var3 > 15),] #can also use the OR operator

x[which(x$var2 > 8), ] #use which when dealing with NA

sort(x$var1, decreasing = TRUE) #use the sort f(x), and in this case use the decreasing parameter
sort(x$var2, na.last = TRUE) #in this case, the NA is listed last

x[order(x$var1),] #order a data frame, essentially sort the data frame by the increasing order of Var1
x[order(x$var1, x$Var3), ] #add multiple parameters

library(plyr)
arrange(x, var1) #can also use the plyr package and the arrange f(x)
arrange(x, desc(var1))

"x$var4 <- rnorm(5)" #add column to x
Y <- cbind(x, rnorm(5)) #use cbind or rbind and cand change position of x & rnorm to 
                            #change position of row/column


"WEEK 3: SUMMARIZING DATA"

restData <- read.csv("Restaurants.csv") #https://data.baltimorecity.gov/Community/Restaurants/k5ry-ef3g

    "QUICK LOOK @ DATA"
head(restData, n = 3)
tail(restData, n = 3) #shows the bottom 3 rows of the data prame

    "SUMMARIES"
summary(restData) #for every variable itll give you info. gives count of all text var
'str(restData)' #gives you some info on the classes of the data

    "CHECK FOR NA"
sum(is.na(restData$councilDistrict)) #give you the # of NA in certain variable
any(is.na(restData$councilDistrict)) #checks if any are NA
all(restData$zipCode > 0) #in this case it's false b/c one zip is negative
colSums(is.na(restData)) #easier than doing the sum f(x)
all(colSums(is.na(restData)) == 0) # apply the all f(x) tp colSums
    
    "QUANTITATIVE DATA"
quantile(restData$councilDistrict, na.rm = TRUE) #shows the variability of qaunt variables
quantile(restData$councilDistrict, probs = c(0.5, 0.75, 0.9)) #look @ diff percentiles
table(restData$zipCode, useNA = "ifany") #look at the # of entries in each zip code
                "useNA = 'ifany'" #this will add another column and say how many NAs
table(restData$councilDistrict, restData$zipCode) #makes a 2-D table

    "VALUES WITH SPECIFIC CHARACTERISTICS"
table(restData$zipCode %in% c("21212")) #Returns T/F table with corresponding values
table(restData$zipCode %in% c("21212", "21213")) #Works with multiple parameters
restData[restData$zipCode %in% c("21212", "21213"), ] #add to the row operater to view all rows

    "CHECK SIZE OF DATA"
object.size(restData) #output given in bytes
'print(object.size(restData), units = "Mb")' #uotput in specified measurement



"WEEK 3: CREATING NEW VARIABLES"
#When the data doesnt have the value you need, so you transform and add to the data frame

    "CREATE SEQUENCES"
#Used to index diff operations
s1 <- seq(1, 10, by = 2) #Define the start, end, and value to increase by
s2 <- seq(1, 10, length = 3) #this one will create only three values

restData$nearMe = restData$neighborhood %in% c("Roland Park", "Homeland")
          #Append nearMe onto the data frame
table(restData$nearMe) #then apply the table operator

restData$zipWrong = ifelse(restData$zipCode < 0, TRUE, FALSE) #use if else to apply TRUE if
          #condition is met... in this case, if the zip < 0
table(restData$zipWrong, restData$zipCode < 0) #put data into a table

    "CREATE FACTOR VARIABLES"
yesno <- sample(c("yes", "no"), size = 10, replace = TRUE)
yesnofac = factor(yesno, levels = c("yes", "no"))
relevel(yesnofac, ref = "yes")
as.numeric(yesnofac)
library(Hmisc)
restData$zipGroups = cut2(restData$zipCode, g = 4) #finds and breaks into quantiles
table(restData$zipGroups) #will display the four quantiles


"WEEK 3: RESHAPING DATA"
#The Goal is TIDY DATA
  '1. Each variable forms a column2 
   2. Each Observation forms a row'

library(reshape2)
head(mtcars)

    "MELTING DATA FRAMES"
mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars, id = c("carname", "gear", "cyl"), measure.vars = c("mpg", "hp"))
head(carMelt, n = 3)
tail(carMelt, n = 3)
  'when using melt, you define your id variables, as well as the quatitative/measurable
    data. This then re-shapes the data to be taller; mpg is @ the top and hp down below'

    "CASTING/REFORMING DATA FRAMES"
cylData <- dcast(carMelt, cyl ~ variable)
cylData2 <- dcast(carMelt, cyl ~ variable, mean)
  'This is done after the data is melted, as it is then changed into different shapes.
    dcast is passed the melted data set and variable, by which it will create a data frame.
    Without inputting a way to measure (mean), it will only output the count'

    "SUMMING DATA"
head(InsectSprays)
tapply(InsectSprays$count, InsectSprays$spray, sum)  #This will sum the count along the index spray
library(plyr)


"WEEK 3: MANAGING DATA FRAMES WITH DPLYR"

#library(dplyr)
ddply(InsectSprays, .(spray), summarise, sum=sum(count)) #summarize by using the sum of count...split, combine, apply

    "SELECT FUNCTION"
chicago <- readRDS("chicago.rds")
dim(chicago) #take a quick look at the data
'str(chicago)' #another way to take a quick look at the dimentions
names(chicago) #easy way to look at the variable names
head(select(chicago, city:dptp))#easier to access columns or set of columns with the names, not the indecies
head(select(chicago, -(city:dptp))) #can use (-) to show all rows except the selection

    "FILTER FUNCTION"
chic.f <- filter(chicago, pm25tmean2 > 30) #simple > operator to filter data
head(chic.f, 10)
chic.f <- filter(chicago, pm25tmean2 > 30 & tmpd > 80) #another more complex use to filter
head(chic.f)

    "ARRANGE FUNCTION"
#Use of this function is to reorder the rows of the data frame based on the value of the column
chicago <- arrange(chicago, date) #arranged in order of the data variable in increasing order
chicago <- arrange(chicago, desc(date)) #use desc to change direction and list in decreasing order
head(chicago, 5)
tail(chicago, 5)

    "RENAME FUNCTION"
#Used to rename a variable in R, and simplies the process vs the non dplyr method
chicago <- rename(chicago, pm25 = pm25tmean2, dewpoint = dptp)
head(chicago, 5)

    "MUTATE FUNCTION"
#Used to transform existing or create new variables
chicago <- mutate(chicago, pm25detrend = pm25 - mean(pm25, na.rm = TRUE)) #in this case it's the newly renamed
#                  pm25 variable with the mean subtracted off. it 'centers' variable and shows deviation
head(select(chicago, pm25, pm25detrend))

#Used to split a data frame according to categorical 
#Creating a temperature category variable if it's hot or cold
chicago <- mutate(chicago, tempcat = factor(1 * (tmpd > 80), labels = c("cold", "hot")))
hotcold <- group_by(chicago, tempcat)
summarise(hotcold, pm25 = mean(pm25, na.rm = TRUE), o3 = max(o3tmean2), no2 = mean(no2tmean2))
#       What's the mean pm25 for hot vs cold days, the max ozone, and mean nitrogen dioxide

#Categorize for each year in the dataset
chicago <- mutate(chicago, year = as.POSIXlt(date)$year + 1900)
#       extract the year info using as.POSIXlt
years <- group_by(chicago, year)
summarise(years, pm25 = mean(pm25, na.rm = TRUE), o3 = max(o3tmean2), no2 = median(no2tmean2))

#special thing (pipeline operator) within dplyr which makes it easier to understand and code operations
#take a data frame, feed through pipeline of operations, to get a new data frame
#in this case - Use chicago, mutate to create month variable, group by month, and summarize parameters
chicago %>% mutate(month = as.POSIXlt(date)$mon + 1) %>% group_by(month) %>% 
  summarise(pm25 = mean(pm25, na.rm = TRUE), o3 = max(o3tmean2), no2 = median(no2tmean2))


    "WEEK 3: MERGING DATA"
#sometimes you want to merge different datasets

#find, download, and load datasets
if (!file.exists("./data")) {
dir.create("./data")  
}
fileUrl1 = "https://raw.githubusercontent.com/jtleek/dataanalysis/master/week2/007summarizingData/data/reviews.csv"
fileUrl2 = "https://raw.githubusercontent.com/jtleek/dataanalysis/master/week2/007summarizingData/data/solutions.csv"
download.file(fileUrl1, destfile = "./data/reviews.csv", method = "curl")
download.file(fileUrl2, destfile = "./data/solutions.csv", method = "curl")
reviews <- read.csv("./data/reviews.csv")
solutions <- read.csv("./data/solutions.csv")
head(reviews, 5); head(solutions, 5)
names(reviews); names(solutions)
#   look at the names of parameters to determine how to merge your datasets

#Using Merge -- Imporant parameters: x, y, by, by.x, by.y, all (to tell which columns to merge by)
#            -- By default it tries to merge using common names
mergedData <- merge(reviews, solutions, by.x = "solution_id", by.y = "id", all = TRUE)
head(mergedData)

#Use join with the plyr package
df1 = data.frame(id = sample(1:10), x = rnorm(10))
df2 = data.frame(id = sample(1:10), y = rnorm(10))
arrange(join(df1, df2), id)


    "WEEK 3: SWIRL NOTES"

'When working with a dataset, you should recreate the file with tbl_df
    newData <- tbl_df(data)
  In this case, it makes the data much easier to understand, compact'
'select() -> selecting subset of columns
 filter() -> selecting a subset of rows
      OR = x|y, AND = x,y, EQUALS = x==y, etc. (?Comparison) 
 arrange() -> order rows according to values of a specific variable
    -Defaults to ascending order, but use desc(x) to reverse to descending
    -arrange(data, x, y, z) will first arrange by x, then y, then z
 mutate() -> create a new variable based on other variable values
 summarize() -> collapse data info into single row
 group_by() -> break dataset into groups of rows based on values
    -change the dataset so that changes and analysis are based on a spec. variable'
    by_package <- group_by(cran, package)
    pack_sum <- summarize(by_package,
                          count = n()
                          unique = n_distinct(ip_id),
                          countries = n_distinct(country),
                          avg_bytes = mean(size))
    
    # Here's the new bit, but using the same approach we've
    # been using this whole time.
    
    top_countries <- filter(pack_sum, countries > 60)
    result1 <- arrange(top_countries, desc(countries), avg_bytes)
    
    # Print the results to the console.
    print(result1)
'View() -> to open a new file and view a dataframe
 quantile(data$variable, probs = 0.xy) -> find the specific percentile of data
 gather -> look at the help file
 
    '

