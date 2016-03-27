library(dataRetrieval)
library(scales)
library(dplyr)
library(ggplot2)
library(viridis)
library(lubridate)

gage<-readNWISuv("04157005",parameterCd = "00060",startDate = "2015-01-01",endDate = "2015-12-31",tz="America/Jamaica")

gagedv<- gage %>% group_by(as.Date(gage$dateTime,tz="America/Jamaica")) %>%
        summarise(Max_Q=max(X_00060_00011),Min_Q=min(X_00060_00011),Mean_Q=mean(X_00060_00011))
colnames(gagedv)[1]<-"date"

########ggplot attempt


ggplot(gagedv, aes(date,
               ymin = Min_Q,
               ymax = Max_Q,
               color = Mean_Q)) + 
        geom_linerange(size = 1.3, alpha = 0.75) +
        scale_color_viridis(NULL, option = "A") +
        scale_x_date(labels = date_format("%b"), breaks = date_breaks("month")) + 
        labs(title = "Discharge plot for Saginaw River, MI Station 04157005",
             x = NULL, y = NULL) +
        coord_polar() + 
        theme_minimal() 


