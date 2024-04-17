install.packages("choroplethrMaps")
install.packages("choroplethr")
install.packages("dplyr")
install.packages("sf")
install.packages("ggplot2")
library(choroplethrMaps)
library(choroplethr)
library(dplyr)
library(data.table)
library(ggplot2)

#data(country.map, package = "choroplethrMaps")
#head(unique(country.map$region), 200)

colnames2 = c("Surname", "First_name", "Second_name", "email", "country", "prof", "interests")
rawdata2 <- read.csv("Проект по R 2.csv", header = FALSE, sep = ";",
                    colClasses = c(rep("character",7)),
                    col.names = colnames2,
                    strip.white = TRUE,
                    blank.lines.skip = TRUE,
                    stringsAsFactors = FALSE,
                    encoding = "UTF-8")


dt2 <- data.table(rawdata2)[, list(Surname, First_name, Second_name, email, country, prof, interests)]
st2 <- dt2[, list(N = length(email)), by = list(country) ] # Общая таблица

plotdata <- st2 %>%
  rename(region = country,
         value = N)

country_choropleth(plotdata,
                   num_colors=9) +
  scale_fill_brewer(palette="YlOrRd") +
  labs(title = "Количество слушателей по странам",
       fill = "Количество слушателей")

