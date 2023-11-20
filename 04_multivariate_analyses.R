## MULTIVARIATE ANALYSES

library(tidyverse)

## Lines Analyses ------

#main character lines throughout the seasons
maincharacters |> 
  group_by(season) |> 
  count(speaker) |> 
  ggplot(aes(x = season, y = n, color = speaker))+
  geom_point(size = 3, show.legend = FALSE)+
  geom_line(show.legend = FALSE)+
  scale_x_continuous(breaks = seq(0, 10, 1))+
  facet_wrap(~speaker)+
  labs(title = "Line Count - Main Characters", 
       subtitle = "Total Number of Lines in Every Season for the Six Main Characters", 
       x = "Season", y = NULL) +
  theme_linedraw()+
  theme(plot.title = element_text(hjust = 0.5, size = 15, face = "bold"), 
        plot.subtitle = element_text(hjust = 0.5, size = 10), 
        axis.title.x = element_text(hjust = 0.5, size = 10, face = "bold"))

ggsave("plots/line_by_season_maincharacters.png") 

## Info Analyses ------
#views and ratings
ggplot(data = info, aes(us_views_millions, imdb_rating))+
  geom_jitter(alpha = 0.75)