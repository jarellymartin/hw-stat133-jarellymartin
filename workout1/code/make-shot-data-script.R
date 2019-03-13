#title: "Data Preperation"
#description: Altered the shot_made_flag column and added new column minute. 
#input(s): Read in data sets: curry, iguodala, green, durant, and thompson.
#output(s): Summary of each table in a text file and shots-data (stacked data set of all players)

library(dplyr)
library(ggplot2)
curry <- read.csv("../data/stephen-curry.csv", stringsAsFactors = FALSE)
iguodala <- read.csv("../data/andre-iguodala.csv", stringsAsFactors = FALSE)
green <- read.csv("../data/draymond-green.csv", stringsAsFactors = FALSE)
durant <- read.csv("../data/kevin-durant.csv", stringsAsFactors = FALSE)
thompson <- read.csv("../data/klay-thompson.csv", stringsAsFactors = FALSE)

curry$shot_made_flag[curry$shot_made_flag == 'y'] <- "shot_yes"
curry$shot_made_flag[curry$shot_made_flag == 'n'] <- "shot_no"

iguodala$shot_made_flag[iguodala$shot_made_flag == 'y'] <- "shot_yes"
iguodala$shot_made_flag[iguodala$shot_made_flag == 'n'] <- "shot_no"

green$shot_made_flag[green$shot_made_flag == 'y'] <- "shot_yes"
green$shot_made_flag[green$shot_made_flag == 'n'] <- "shot_no"

durant$shot_made_flag[durant$shot_made_flag == 'y'] <- "shot_yes"
durant$shot_made_flag[durant$shot_made_flag == 'n'] <- "shot_no"

thompson$shot_made_flag[thompson$shot_made_flag == 'y'] <- "shot_yes"
thompson$shot_made_flag[thompson$shot_made_flag == 'n'] <- "shot_no"

curry <- mutate(curry, name = 'Stephen Curry')
iguodala <- mutate(iguodala, name = 'Andre Iguodala')
green <- mutate(green, name = 'Draymond Green')
durant <- mutate(durant, name = 'Kevin Durant')
thompson <- mutate(thompson, name = 'Klay Thompson')

curry <- mutate(curry, minute = 12*period - minutes_remaining)
iguodala <-mutate(iguodala, minute = 12*period - minutes_remaining)
green <- mutate(green,minute = 12*period - minutes_remaining)
durant <-  mutate(durant,minute = 12*period - minutes_remaining)
thompson <- mutate(thompson, minute = 12*period - minutes_remaining)

sink(file = "../output/stephen-curry-summary.txt")
summary(curry)
sink()

sink(file = "../output/andre-iguodala-summary.txt")
summary(iguodala)
sink()

sink(file = "../output/draymond-green-summary.txt")
summary(green)
sink()

sink(file = "../output/kevin-durant-summary.txt")
summary(durant)
sink()

sink(file = "../output/klay-thompson-summary.txt")
summary(thompson)
sink()

write.csv(
  x = rbind(curry, iguodala, green, durant, thompson),
  file = "../data/shots_data.csv"
)

sink(file = "../output/shots-data-summary.txt")
summary(rbind(curry, iguodala, green, durant, thompson))
sink()

