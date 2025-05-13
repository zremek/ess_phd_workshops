#####SPSS####

library(openxlsx)
library(tidyverse)
library(sjmisc)
library(sjlabelled)

# ls()
# rm(list=ls())

#Problem: Load the dataset from the latest edition of the ESS survey into R environment.

library(haven)
? read_sav
ESS11 <- read_sav("ESS11.sav")

#Problem: let's conduct an inspection of the dataset.

#type of the object
class(ESS11)

#"tbl_df"     "tbl"        "data.frame"
#to jest data.frame w formie tibble.


ESS11 #we can run the command, which is the name of the tibble object
#types of variables in tibble: https://tibble.tidyverse.org/articles/types.html





table(ESS11$netusoft) #frequency

frq(ESS11$netusoft)
frq(ESS11$netusoft, out = 'view')


table(ESS11$cntry)

##Task: We are interested in the variables idno nwspol polintr netusoft netustm gndr eduyrs and
#Poland-only observations.
##Prepare a dataset that contains only these variables and only observations from Poland.

ESS.PL <- select(ESS11,
                 idno,
                 cntry,
                 nwspol,
                 polintr,
                 netusoft,
                 netustm,
                 gndr,
                 eduyrs) #wybór zmiennych

names(ESS.PL)

ESS.PL <- filter(ESS.PL, cntry == 'PL') #selection of observations

table(ESS.PL$cntry)

summary(ESS.PL)
names(ESS.PL)


library(sjPlot)
tab_xtab(ESS.PL$polintr, ESS.PL$gndr, show.col.prc = T)
? tab_xtab

#what we did above can be done in one line using the so-called pipe %>%:

ESS.PL2 <- ESS11 %>%
  select(idno, cntry, nwspol, polintr, netusoft, netustm, gndr, eduyrs)  %>%
  filter(cntry == 'PL')

names(ESS.PL2)
table(ESS.PL2$cntry)



####Histogram####
#R Graphics Cookbook pp. 117

ggplot(ESS11, aes(x = nwspol)) + geom_histogram()

ggplot(ESS11, aes(x = nwspol))  +  geom_histogram(bins = 10,
                                                  fill = "white",
                                                  colour = "black")
ggplot(ESS11, aes(x = nwspol))  +  geom_histogram(bins = 20,
                                                  fill = "red",
                                                  colour = "black")
ggplot(ESS11, aes(x = nwspol))  +  geom_histogram(bins = 30,
                                                  fill = "white",
                                                  colour = "black")
ggplot(ESS11, aes(x = nwspol))  +  geom_histogram(bins = 40,
                                                  fill = "white",
                                                  colour = "black")
ggplot(ESS11, aes(x = nwspol))  +  geom_histogram(bins = 50,
                                                  fill = "white",
                                                  colour = "black")


library(cowplot)

p1 <- ggplot(ESS11, aes(x = nwspol))  +  geom_histogram(bins = 10,
                                                        fill = "white",
                                                        colour = "black")
p2 <- ggplot(ESS11, aes(x = nwspol))  +  geom_histogram(bins = 20,
                                                        fill = "white",
                                                        colour = "black")
p3 <- ggplot(ESS11, aes(x = nwspol))  +  geom_histogram(bins = 30,
                                                        fill = "white",
                                                        colour = "black")
#p5<-ggplot(ESS11, aes(x=nwspol))  +  geom_histogram(bins = 50, fill="white", colour="black")



plot_grid(p1,
          p2,
          p3,
          labels = c('bins=10', 'bins=20', 'bins=30', 'bins=40', 'bins=50'))

#bins - indicate how many bins (or bars) should be created from the whole range of a variable

colors() #names of colors

ggplot(ESS11, aes(x = nwspol)) +  geom_histogram(bins = 40,
                                                 fill = "chocolate",
                                                 colour = "black")

#using themes
ggplot(ESS11, aes(x = nwspol))  +  geom_histogram() + theme_bw()
ggplot(ESS11, aes(x = nwspol))   +  geom_histogram() + theme_classic()

ESS11.3c <- ESS11 %>% filter(cntry == "PL" |
                               cntry == "DE" | cntry == "IT")

#using facets

ggplot(ESS11.3c, aes(x = nwspol)) + geom_histogram(bins = 40,
                                                   fill = 'red',
                                                   col = 'black') +
  facet_grid(cntry ~ .)



#categories on one graph
ggplot(ESS11.3c, aes(x = nwspol, fill = cntry)) + geom_histogram(bins =
                                                                   40)



####Density - smoothing the histogram####
#R Graphics Cookbook pp. 123

#kernel density curve - providing a curve which summarizes distribution.
#one interpretation: we have a sample and we would like to see the pattern in the population,
#we assume that pattern in the population can be represented as a curve, can have values for each value of a variable.


ggplot(ESS11, aes(x = nwspol)) + geom_density()
ggplot(ESS11, aes(x = nwspol)) + geom_density(adjust = 2)
ggplot(ESS11, aes(x = nwspol)) + geom_density(adjust = 3)
ggplot(ESS11, aes(x = nwspol)) + geom_density(adjust = 5)


#within groups
ggplot(ESS11.3c, aes(x = nwspol, fill = cntry)) + 
  geom_density(alpha = 0.2, adjust = 3)


####Box-plot####
#R Graphics Cookbook pp.130

summary(ESS11$lrscale)
#one variable
ggplot(ESS11, aes(y = lrscale)) + geom_boxplot()

? geom_boxplot
#more fine grained scale
ggplot(ESS11.3c, aes(y = lrscale, x = cntry)) + geom_boxplot()

#add mean indicated as diamond
ggplot(ESS11.3c, aes(y = lrscale, x = cntry)) + geom_boxplot() +
  geom_point(
    stat = "summary",
    fun = "mean",
    shape = 23,
    size = 4,
    fill = 'red'
  )

#Possible shapes: R Graphic cookbook page 71


ggplot(ESS11.3c, aes(y = lrscale, x = cntry)) + geom_violin() + geom_point(
  stat = "summary",
  fun = "mean",
  shape = 23,
  size = 4,
  fill = 'red'
)

ggplot(ESS11.3c, aes(y = lrscale, x = cntry)) + geom_violin() + geom_boxplot(width =
                                                                               .1)



####Scatterplot####
#Bivariate relationships

summary(ESS.PL)
ggplot(ESS11.3c, aes(x = netustm, y = nwspol)) + geom_point()

ggplot(ESS11.3c, aes(x = netustm, y = nwspol)) + geom_point() + facet_grid(cntry ~
                                                                             .)

frq(ESS11.3c$gndr)
ESS11.3c$gndr <- as_label(ESS11.3c$gndr)
frq(ESS11.3c$gndr)

ggplot(ESS11.3c, aes(x = netustm, y = nwspol, colour = gndr)) + geom_point()
ESS11.3c.gndr <- ESS11.3c %>% drop_na(gndr)
ggplot(ESS11.3c.gndr, aes(x = netustm, y = nwspol, colour = gndr)) + geom_point()



#Adding lines summarizing relationship
ggplot(ESS11.3c, aes(x = netustm, y = nwspol)) + geom_point() +
  stat_smooth(method = lm, se = FALSE)

ggplot(ESS11.3c, aes(x = netustm, y = nwspol)) +
  geom_point() + stat_smooth(method = loess, se = FALSE)


sjPlot::view_df(ESS.PL, show.frq = T, show.prc = T, max.len = 50)

ESS.PL %>% select_if(is.numeric) %>% summary()

library(ggstatsplot)

ESS.PL$netusoft <- as_label(ESS.PL$netusoft)

ggstatsplot::ggbarstats(data = ESS.PL, x = netusoft, y = gndr) 

ggbarstats(data = ESS.PL, x = netusoft, y = polintr) 

view_df(ESS.PL)


table1::table1(~ nwspol + polintr + netusoft + netustm + gndr + eduyrs,
               data = ESS.PL)

table1::table1(~ nwspol + polintr + netustm + gndr + eduyrs | netusoft,
               data = ESS.PL)


?table1::table1

