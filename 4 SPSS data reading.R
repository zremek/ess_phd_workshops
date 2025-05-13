#####SPSS####

library(openxlsx)
library(tidyverse)

# ls()
# rm(list = ls())

#Problem: Load the dataset from the latest edition of the ESS survey into R environment.

library(haven)

?read_sav

ESS11.miss <- read_sav("ESS11.sav", user_na = T)
ESS11 <- read_sav("ESS11.sav")

#Problem: let's conduct an inspection of the dataset.

#type of the object
class(ESS11)

#"tbl_df"     "tbl"        "data.frame"
#to jest data.frame w formie tibble.


ESS11 #we can run the command, which is the name of the tibble object
#types of variables in tibble: https://tibble.tidyverse.org/articles/types.html



View(ESS11) #We can also look at the data.



names(ESS11) # names of variables in the set


summary(ESS11) # summary function, a general glance at the collection, too large a collection to be informative


#Task: create a statement in which the first column is consecutive numbers,
#second is the names of the variables, and the
#third is the labels of the variables

library(sjPlot)
library(sjmisc)
library(sjlabelled)

var.lab <- get_label(ESS11)
var.lab
str(var.lab)

var.lab <- unname(var.lab)
var.lab
str(var.lab)

names(ESS11)

vars <- names(ESS11)
vars

lp <- c(1:640)
lp

vars <- data.frame(lp = lp,
                   zmienna = vars,
                   etykieta = var.lab)
vars



? write.xlsx
write.xlsx(vars, 'ESS11_vars.xlsx')







#### Inspection of variables####

#To view a variable: name.data$name.variable or name.set[[column number]]


ESS11$netusoft # etykieta zmiennej, numeryczne kody i ich etykiety

ESS11[[14]] #czternasta zmienna w ESS11

#możemy porównać  to widzimy w R z kwestionariuszem  "PAN_ESS11 Paper Questionnaire FINAL_20210928"



#użyjmy funkcji table
table(ESS11$netusoft) #

#Zadanie: przygotuj rozkład procentowy zmiennej netusoft


table(ESS11$netusoft) #rozkład częstości, ale nie o to nam chodziło

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


#what we did above can be done in one line using the so-called pipe %>%:

ESS.PL2 <- ESS11 %>%
  select(idno, cntry, nwspol, polintr, netusoft, netustm, gndr, eduyrs)  %>%
  filter(cntry == 'PL')

names(ESS.PL2)
table(ESS.PL2$cntry)

# Let's inspect the next variables.
# Make transformations:
# - convert quantitative variables into numeric type variables
# - transform qualitative variables into factor variables


###################
#nwspol
###################
names(ESS.PL)
ESS.PL

ESS.PL$nwspol
table(ESS.PL$nwspol)
summary(ESS.PL$nwspol)
frq(ESS.PL$nwspol, out = 'v')

#convert data missing in NA

ESS.PL$nwspol <- drop_labels(ESS.PL$nwspol)
frq(ESS.PL$nwspol, out = 'v')



ESS.PL$nwspol <- set_na(ESS.PL$nwspol, na = c(9999))
# dla samej polski nie widać różnicy, bo tych wartości
# specjalnych nie ma 

# trzeba wziąć inny kraj

ESS_IT_PL <- ESS11 %>%
  select(idno, cntry, nwspol, polintr,
         netusoft, netustm, gndr, eduyrs)  %>%
  filter(cntry == 'PL' | cntry == 'IT')

frq(ESS_IT_PL$nwspol)

ESS.PL$nwspol <- drop_labels(ESS.PL$nwspol)
frq(ESS.PL$nwspol, out = 'v')

summary(ESS.PL$nwspol)


##################
# polintr
##################

ESS.PL$polintr #values and labels
summary(ESS.PL$polintr)
frq(ESS.PL$polintr)

#quality variable - we would like to convert it to factor

frq(ESS.PL, polintr)
ESS.PL$polintr <- drop_labels(ESS.PL$polintr)
frq(ESS.PL, polintr)
ESS.PL$polintr <- set_na(ESS.PL$polintr, na = 9)
frq(ESS.PL, polintr)

ESS.PL$polintr <- as_label(ESS.PL$polintr)
frq(ESS.PL, polintr)
summary(ESS.PL$polintr)

#what are the value levels of our factor:
levels(ESS.PL$polintr)

###################
#netusoft
###################


ESS.PL$netusoft #this variable is also converted to factor

frq(ESS.PL$netusoft)

ESS.PL$netusoft <- drop_labels(ESS.PL$netusoft)
frq(ESS.PL$netusoft)

ESS.PL$netusoft <- set_na(ESS.PL$netusoft, na = 9)
frq(ESS.PL$netusoft)

ESS.PL$netusoft <- as_label(ESS.PL$netusoft)
frq(ESS.PL$netusoft)

summary(ESS.PL$netusoft)

###################
#variable netustm
###################

ESS.PL$netustm
frq(ESS.PL$netustm) #
# let's discard special values (6666,8888) from the analyses



ESS.PL$netustm <- set_na(ESS.PL$netustm, na = c(6666, 9999))
ESS.PL$netustm <- drop_labels(ESS.PL$netustm)

frq(ESS.PL$netustm)
summary(ESS.PL$netustm) #it is numeric as it should be

###################
#gndr
###################

ESS.PL$gndr #let's change into factor

frq(ESS.PL$gndr)
ESS.PL$gndr <- drop_labels(ESS.PL$gndr)
frq(ESS.PL$gndr)
ESS.PL$gndr <- as_label(ESS.PL$gndr)
frq(ESS.PL$gndr)




###################
#variable eduyrs
###################

ESS.PL$eduyrs
frq(ESS.PL$eduyrs)

#chenge 99 na NA

ESS.PL$eduyrs <- set_na(ESS.PL$eduyrs, na = 99)
ESS.PL$eduyrs <- drop_labels(ESS.PL$eduyrs)

frq(ESS.PL$eduyrs)
summary(ESS.PL$eduyrs)





#################
#Ready

ESS.PL
summary(ESS.PL)

str(ESS.PL)

#Let's see  frequencies

frq(ESS11$cntry)
table(ESS11$cntry)

ggplot(ESS11, aes(cntry)) + geom_bar() + coord_flip()

names(ESS.PL)
frq(ESS.PL,
    cntry, # co tu robi Albania? 
    nwspol,
    polintr,
    netusoft,
    netustm,
    gndr,
    eduyrs,
    out = 'v')

frq(ESS11, cntry, # co tu robi Albania? 
    nwspol,
    polintr,
    netusoft,
    netustm,
    gndr,
    eduyrs,
    out = 'v')

sjPlot::view_df(ESS.PL, show.frq = T, show.prc = T, max.len = 50)


summary(ESS.PL$nwspol)

ESS_IT_PL <- drop_labels(ESS_IT_PL)

view_df(ESS_IT_PL, show.frq = T, show.prc = T, max.len = 100, show.na = T)

#####
#export into  SPSS

# save(ESS.PL, file = 'Data.RData')
# write_sav(ESS.PL, 'Data.sav')
# write.csv(ESS.PL, 'Data.csv')
