## GRAPHS

library(tidyverse)

#main character lines throughout the seasons
maincharacters |> 
  group_by(season) |> 
  count(speaker) |> 
  ggplot(aes(x = season, y = n, color = speaker))+
  geom_point(size = 3, show.legend = FALSE)+
  geom_line(show.legend = FALSE)+
  scale_x_continuous(breaks = seq(0, 10, 1))+
  facet_wrap(~speaker)

#views and ratings
ggplot(data = info, aes(us_views_millions, imdb_rating))+
  geom_jitter(alpha = 0.75)