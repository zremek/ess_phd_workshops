library(tidyverse)
library(haven)
library(sjmisc)
library(sjlabelled)

ESS11 <- read_sav("ESS11.sav")

table(ESS11$cntry)

frq(ESS11$cntry) # Poland 0?

frq(as_label(ESS11$cntry)) # Poland 1442, OK

ESS11 %>% filter(cntry == "PL") %>% 
  select(cntry) %>% # Albania?
  frq()

ESS11 %>% filter(cntry == "PL") %>% 
  select(cntry) %>% # OK
  drop_labels() %>% 
  frq()
