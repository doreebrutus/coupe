###########################Informatique pour sciences sociales#################

library(rvest)
library(dplyr)
library(ggplot2)

###############################################################################
##Calculons le nombre de tableaux retrouves dans la page web
 
foot = "https://www.skysports.com/world-cup-table"
data_foot= rvest::read_html(foot)
data_foot
table_foot = rvest::html_table(data_foot)
length(table_foot)
table_foot[[1]]
table_foot


################################################################################

##Creeons une fonction permettant de lire la page web........
coupe_du_monde= function(){
  foot = "https://www.skysports.com/world-cup-table"
  data_foot= rvest::read_html(foot)
  table_foot = rvest::html_table(data_foot)
  cdm=do.call(rbind,list(table_foot[[1]],table_foot[[2]],table_foot[[3]],
                         table_foot[[4]],table_foot[[5]],table_foot[[6]],
                         table_foot[[7]],table_foot[[8]]))
                         cdm[1]=NULL
                         cdm[10]=NULL
  return(cdm)
}

df_cdm=coupe_du_monde()

###############################################################################
#Realisons un graphique en baton
str(df_cdm)
df_cdm%>%arrange(desc(Pts))%>%head(10)%>%
  ggplot(aes(y=Pts, x=Team))+
  geom_bar(stat='identity', fill='yellow')+theme_classic()

