#title: Shot Data Charts
#description: created scatterplots to analyze shot data for each player
#input(s): Data sets for each player
#output(s): PDF and PNG files of each shot data scatterplot


install.packages("jpeg")
install.packages("grid")
library(jpeg)
library(grid)
library(ggplot2)
court_file <- "../images/nba-court.jpg"
court_image <- rasterGrob(readJPEG(court_file), width = unit(1,"npc"), height = unit(1,"npc"))

curry_shot_chart <- ggplot(data=curry) + annotation_custom(court_image, -250, 250, -50, 420) + 
  geom_point(aes(x=x, y=y, color = shot_made_flag)) + ylim(-50, 420) + 
  ggtitle('Shot Chart: Stephen Curry (2016 season)') + theme_minimal()

iguodala_shot_chart <-  ggplot(data=iguodala) + annotation_custom(court_image, -250, 250, -50, 420) + 
  geom_point(aes(x=x, y=y, color = shot_made_flag)) + ylim(-50, 420) + 
  ggtitle('Shot Chart: Andre Iguodala (2016 season)') + theme_minimal()

green_shot_chart <- ggplot(data=green) + annotation_custom(court_image, -250, 250, -50, 420) + 
  geom_point(aes(x=x, y=y, color = shot_made_flag)) + ylim(-50, 420) + 
  ggtitle('Shot Chart: Draymond Green (2016 season)') + theme_minimal()

durant_shot_chart <- ggplot(data=durant) + annotation_custom(court_image, -250, 250, -50, 420) + 
  geom_point(aes(x=x, y=y, color = shot_made_flag)) + ylim(-50, 420) + 
  ggtitle('Shot Chart: Kevind Durant (2016 season)') + theme_minimal()
  
klay_shot_chart <- ggplot(data=thompson) + annotation_custom(court_image, -250, 250, -50, 420) + 
                  geom_point(aes(x=x, y=y, color = shot_made_flag)) + ylim(-50, 420) + 
                  ggtitle('Shot Chart: Klay Thompson (2016 season)') + theme_minimal()


pdf("../images/stephen-curry-shot-chart.pdf", width = 6.5, height = 5)
curry_shot_chart
dev.off()

pdf("../images/andre-iguodala-shot-chart.pdf", width = 6.5, height = 5)
iguodala_shot_chart
dev.off()

pdf("../images/draymond-green-shot-chart.pdf", width = 6.5, height = 5)
green_shot_chart 
dev.off()

pdf("../images/kevin-durant-shot-chart.pdf", width = 6.5, height = 5)
durant_shot_chart
dev.off()

pdf("../images/klay-thompson-shot-chart.pdf", width = 6.5, height = 5)
klay_shot_chart
dev.off()

shots_data <- read.csv("../data/shots_data.csv", stringsAsFactors = FALSE)
gsw_shot_chart <- ggplot(data = shots_data)+
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Charts: GSW (2016 season)') +
  theme_minimal() + facet_wrap(~ name, ncol=3)

pdf("../images/gsw-shot-charts.pdf", width = 8, height = 7)
gsw_shot_chart
dev.off()

png("../images/gsw-shot-charts.png", width = 8, height = 7, units='in', res = 150)
gsw_shot_chart
dev.off()
