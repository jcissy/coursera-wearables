library(dplyr)
library(lubridate)
library(stringr)

## SECTION 1
## SET THE FILE PATH BASED ON CURRENT WORKING DIRECTORY
workpath <- getwd()

## SECTION 2
## GET THE FEATURE LABELS
featurelabels <- read.csv(paste0(workpath,"/features.txt"), header=FALSE) %>%
  pull(V1) %>%
  str_trim

## SECTION 3
## READ AND PREP THE TRAINING DATA SETS
trainfeaturesraw <- read.csv(paste0(workpath,"/train/X_train.txt"), header=FALSE)
trainfeaturessplit <- strsplit(trainfeaturesraw$V1," ")
trainactivityraw <- read.csv(paste0(workpath,"/train/y_train.txt"), header=FALSE)
trainsubjectraw <- read.csv(paste0(workpath,"/train/subject_id_train.txt"), header=FALSE)
## CREATE DATAFRAME
traindf <- as.data.frame(do.call(rbind,trainfeaturessplit))
colnames(traindf) <- featurelabels
traindf$subjectid <- trainsubjectraw$V1
traindf$activityid <- trainactivityraw$V1
traindf$dataset <- "train"

## SECTION 4
## READ AND PREP THE TEST DATA SETS
testfeaturesraw <- read.csv(paste0(workpath,"/test/X_test.txt"), header=FALSE)
testfeaturessplit <- strsplit(testfeaturesraw$V1," ")
testactivityraw <- read.csv(paste0(workpath,"/test/y_test.txt"), header=FALSE)
testsubjectraw <- read.csv(paste0(workpath,"/test/subject_id_test.txt"), header=FALSE)
## VERIFY THAT ALL VECTORS CONTAIN SAME AMOUNT OF POINTS - 561
length(testfeaturessplit)
table(sapply(testfeaturessplit, length))
## CREATE DATAFRAME
testdf <- as.data.frame(do.call(rbind,testfeaturessplit))
colnames(testdf) <- featurelabels
testdf$subjectid <- testsubjectraw$V1
testdf$activityid <- testactivityraw$V1
testdf$dataset <- "test"

## SECTION 5
## MERGE THE TRAIN AND TEST DATASETS INTO ONE DATAFRAME
## AND VERIFY THE TOTAL NUMBER OF COLS AND ROWS IS CORRECT
maindf <- rbind(traindf, testdf)

## SECTION 6
## SET AND SELECT ONLY COLUMNS THAT MEASURE MEAN AND STANDARD DEVIATION
## AS WELL AS THE SUBJECTID AND ACTIVITYID
tomatch <- c("Mean-","STD-","subjectid","activityid")
colindexes <- grep(paste(tomatch,collapse="|"),names(maindf))
maindf <- maindf[,c(colindexes)]
## CONVERT COLUMNS TO APPROPRIATE CLASSES
maindf[,1:66] <- maindf[,1:66] %>% mutate_all(as.numeric)

## SECTION 7
## CREATE A COLUMN WITH DESCRIPTIVE LABELS FOR THE ACTIVITY TYPES
activitylabels <- read.csv(paste0(datapath,"/activity_labels.txt"), sep=" ", header=FALSE)
activitylabels <- activitylabels[,1:2]
names(activitylabels) <- c("activityid","activityname")
activitylabels$activityname <- tolower(gsub("_","",activitylabels$activityname))
maindf <- merge(x = maindf, y = activitylabels, by = "activityid", all.x=TRUE)

## SECTION 8
## CREATE A TIDY DATA SET WITH THE AVERAGE OF EACH VARIABLE FOR EACH
## ACTIVITY AND EACH SUBJECT
averagesdf <- group_by(maindf, subjectid, activityname) %>%
  summarise(across(everything(),mean), .groups = 'drop') %>%
  as.data.frame() %>%
  select(-activityid)

## SECTION 9
## CREATE A FILE WITH THE TIDY DATASET
write.table(averagesdf, file="tidydataset.txt", row.name=FALSE)
