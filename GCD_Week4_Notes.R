    "WEEK 4: EDITING TEXT VARIABLES"

'if(!file.exists("./data")){dir.create("./data")}
    fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
    download.file(fileUrl, destfile = "./data/cameras.csv", method = "curl")
    cameraData <- read.csv("./data/cameras.csv")'

    
names(cameraData) #it can be noticed that there are some Upper case letters, which could cause user error
tolower(names(cameraData)) #this will change all letter to lower case
splitNames <- strsplit(names(cameraData), "\\.") #will append all names that have a period
firstElement <- function(x) {x[1]}
  sapply(splitNames, firstElement) #this uses sapply to take the first elelment and make it simpler
  

  
  #find, download, and load datasets
'if (!file.exists("./data")) {
  dir.create("./data")  
  }
  fileUrl1 = "https://raw.githubusercontent.com/jtleek/dataanalysis/master/week2/007summarizingData/data/reviews.csv"
  fileUrl2 = "https://raw.githubusercontent.com/jtleek/dataanalysis/master/week2/007summarizingData/data/solutions.csv"
  download.file(fileUrl1, destfile = "./data/reviews.csv", method = "curl")
  download.file(fileUrl2, destfile = "./data/solutions.csv", method = "curl")
  reviews <- read.csv("./data/reviews.csv")
  solutions <- read.csv("./data/solutions.csv")'
  
sub("_", "", names(reviews)) #use sub when there is ONE str element that you want to remove 
                                  #AND only removes the first
gsub("_", "", names(reviews)) #will remove all occurances of the unwanted element

require(stringr)
grep("Alameda", cameraData$intersection) #finds all index instances where an element occur
table(grepl("Alameda", cameraData$intersection)) #Returs a TRUE FALSE table of that elelment occurances
grep("Alameda", cameraData$intersection, value = TRUE) #Returns the idex values

paste0("Jeffrey", "Leek") #paste together with no spaces
str_trim("Jeff     ") #This will trim off excess spaces


    "WEEK 4: REGULAR EXPRESSIONS"
#These are combinations of literals and metacharacters
#literals: these are exact matches (ie. they are literally a match)
#metacharacters: Looking for more general or specific character matches (see below)
  '[Ii]' #looks at both capital and lowercase
  '^[0-9][a-zA-Z]' #Starts at the beginning of a line (^), then looks for a number, than an upper or lower letter
  '9.11' #searches for a 9, then ANY character ("."), then an 11 (i.e. 9-11, or 9:11)
  'flood|fire' #searches for either flood or fire in every line (there can be unlimited alternatives)
  '^[Gg]ood|[Bb]ad' #starts at the beginning and looks for good or Good or Bad or bad wherever b/c no "^"
      '^([Gg]ood|[Bb]ad)' #now it looks at the beginning for both
  '[0-9]+(.*)[0-9]' #at least one number, then any amount of characters, then at least one number
  

  
    "WEEK 4: WORKING WITH DATES"

d1 <- date() #the class(d1) is just a character
d2 <- Sys.Date() #the class of this is a "Date" variable
  format.Date(d2,"a% %b %d") #there are many different formats to choose which is most appealing
weekdays(d2) ; months(d2) 
julian(d2) # number of days since the origin date ("1970-01-01")

x <- c("1jan1960", "2jan1960")
  z <- as.Date(x, "%d%b%Y") #this will change into dates, and it's easier to comapre and analyze

library(lubridate)
ymd(20140108) #lubridate will convert a number to a date
mdy("08/04/2013") #month day year... it'll find format and convert
dmy("03-04-2013") #day month year
dmy_hms("03-04-2013 10:15:03") #can apply time to it as well (hours minutes seconds)
dmy_hms("03-04-2013 10:15:03", tz = "Pacific/Auckland") #Change the timezone
?Sys.timezone #more info on the differnt timezone codes
#look at the LUBRIDATE TUTORIAL


  


