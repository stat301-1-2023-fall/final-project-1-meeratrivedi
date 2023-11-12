## GRAPHS

library(tidyverse)

#main characters line count
labels <- maincharacters |> 
  count(speaker)

ggplot(maincharacters, aes(x = speaker, fill = speaker)) +
  geom_bar(show.legend = FALSE) + 
  geom_text(data = labels, 
            aes(y = n, label = n), 
            nudge_y = -25, vjust = "top") + 
  scale_fill_manual(name = NULL, 
                    values = c("#FFBC00", "#00B4EA", "#FF181E", "#FFBC00", "#00B4EA", "#FF181E"))+ 
  theme_minimal()

#monica lines throughout the seasons
monica |> 
  group_by(season) |> 
  count(speaker) |> 
  ggplot(aes(x = season, y = n)) + 
  geom_point(size = 3)+
  geom_line()+
  scale_x_continuous(breaks = seq(0, 10, 1))

#main character lines throughout the seasons
maincharacters |> 
  group_by(season) |> 
  count(speaker) |> 
  ggplot(aes(x = season, y = n, color = speaker))+
  geom_point(size = 3, show.legend = FALSE)+
  geom_line(show.legend = FALSE)+
  scale_x_continuous(breaks = seq(0, 10, 1))+
  facet_wrap(~speaker)


#guest lines distribution
topguestlines <- lines |> 
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
  mutate(speaker = factor(speaker, 
                  #order of levels
                  levels = c("Mike Hannigan", 
                             "Richard Burke", 
                             "Janice Litman Goralnik", 
                             "Carol Willick", 
                             "Charlie Wheeler", 
                             "Judy Geller", 
                             "Frank Buffay Jr.", 
                             "Emily Waltham", 
                             "Jack Geller", 
                             "Tag Jones")))

topguestlines |> 
  ggplot(aes(x = speaker, fill = speaker))+
  geom_bar(show.legend = FALSE)+
  scale_x_discrete(name = NULL, 
                   labels = c("Mike \n Hannigan", 
                              "Richard \n Burke", 
                              "Janice \n Litman \n Goralnik", 
                              "Carol \n Willick", 
                              "Charlie \n Wheeler", 
                              "Judy \n Geller", 
                              "Frank \n Buffay \n Jr.", 
                              "Emily \n Waltham", 
                              "Jack \n Geller", 
                              "Tag \n Jones")) +
  theme_minimal()


#emotion distribution
label_numbers <- lines_emotions |> 
  count(emotion) |> 
  filter(!is.na(emotion))

lines_emotions |> 
  count(emotion) |> 
  filter(!is.na(emotion)) |> 
  ggplot(aes(x = emotion, y = n, fill = emotion)) +
  geom_col(show.legend = FALSE)+
  geom_text(data = label_numbers, 
            aes(y = n, label = n), 
            color = "white",
            size = 5,
            nudge_y = -15, vjust = "top")+
  scale_fill_manual(name = NULL, 
                    values = c("mediumturquoise", "darkturquoise", "turquoise", "mediumturquoise", "darkturquoise", "turquoise", "mediumturquoise"))+
  theme_minimal()


