## GRAPHS

library(tidyverse)

ggplot(maincharacters, aes(x = speaker)) +
  geom_bar()


monica |> 
  group_by(season) |> 
  count(speaker) |> 
  ggplot(aes(x = season, y = n)) + 
  geom_point(size = 3)+
  geom_line()+
  scale_x_continuous(breaks = seq(0, 10, 1))


maincharacters |> 
  group_by(season) |> 
  count(speaker) |> 
  ggplot(aes(x = season, y = n, color = speaker))+
  geom_point(size = 3)+
  geom_line()+
  scale_x_continuous(breaks = seq(0, 10, 1))+
  facet_wrap(~speaker)

lines |> 
  filter(speaker %in% c("Mike Hannigan", 
                        "Richard Burke", 
                        "Janice Litman Goralnik", 
                        "Carol Willick", 
                        "Charlie Wheeler", 
                        "Judy Geller", 
                        "Frank Buffay Jr.", 
                        "Emily Waltham", 
                        "Jack Geller", 
                        "Tag Jones")) |> 
  ggplot(aes(x = speaker, fill = speaker))+
  geom_bar(show.legend = FALSE)+
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 30, hjust = 0.75))
