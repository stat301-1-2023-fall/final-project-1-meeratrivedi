
## UNIVARIATE ANALYSES

## Lines Analyses -----

#main characters line count------
labels <- maincharacters |> 
  count(speaker)

ggplot(maincharacters, aes(x = speaker, fill = speaker)) +
  geom_bar(show.legend = FALSE) + 
  geom_text(data = labels, 
            aes(y = n, label = n), 
            nudge_y = -200, vjust = "top") + 
  scale_fill_manual(name = NULL, 
                    values = c("#FFBC00", "#00B4EA", "#FF181E", "#FFBC00", "#00B4EA", "#FF181E"))+ 
  labs(title = "Line Count of the Six Main Characters", 
       subtitle = "Total Number of Lines throughout all 10 Seasons", 
       x = NULL, y = NULL) +
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5, size = 15, face = "bold"), 
        plot.subtitle = element_text(hjust = 0.5, size = 10))

ggsave("plots/line_dist_maincharacters.png") 




#monica lines throughout the seasons------
mon_labels <- monica |>
  group_by(season) |> 
  count(speaker)

monica |> 
  group_by(season) |> 
  count(speaker) |> 
  ggplot(aes(x = season, y = n)) + 
  geom_point(size = 3)+
  geom_line()+
  scale_x_continuous(breaks = seq(0, 10, 1))+
  geom_text(data = mon_labels, 
            aes(y = n, label = n),
            nudge_y = 5, hjust = -0.3,
            size = 3) + 
  labs(title = "Line Count - Monica Geller", 
     subtitle = "Total Number of Lines in Every Season", 
     x = "Season", y = NULL) +
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5, size = 15, face = "bold"), 
        plot.subtitle = element_text(hjust = 0.5, size = 10), 
        axis.title.x = element_text(hjust = 0.5, size = 10, face = "bold"))

ggsave("plots/line_by_season_monica.png") 




#guest lines-------

guest_labels <- topguestlines |> 
  count(speaker)

topguestlines |> 
  ggplot(aes(x = speaker, fill = speaker))+
  geom_bar(show.legend = FALSE)+
  geom_text(data = guest_labels, 
            aes(y = n, label = n), 
            nudge_y = -10, vjust = "top") + 
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
  labs(title = "Line Count of the Guest Characters", 
       subtitle = "Total Number of Lines throughout all 10 Seasons of the most recurring Side Characters", 
       x = "Character", y = NULL) +
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5, size = 15, face = "bold"), 
        plot.subtitle = element_text(hjust = 0.5, size = 10), 
        axis.title.x = element_text(hjust = 0.5, size = 10, face = "bold"))

ggsave("plots/line_dist_guestcharacters.png") 



## Emotions Analyses --------

#emotion distribution----
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
            nudge_y = -25, vjust = "top")+
  scale_fill_manual(name = NULL, 
                    values = c("mediumturquoise", "darkturquoise", "turquoise", "mediumturquoise", "darkturquoise", "turquoise", "mediumturquoise"))+
  labs(title = "Count of Lines by Emotion", 
       subtitle = "Total Number of Lines throughout the first 4 seasons delivered with 7 different emotions", 
       x = "Emotion", y = NULL) +
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5, size = 15, face = "bold"), 
        plot.subtitle = element_text(hjust = 0.5, size = 10), 
        axis.title.x = element_text(hjust = 0.5, size = 10, face = "bold"))

ggsave("plots/emotions_count.png") 








## Info Analyses ------

#top writers----

writer_labels <- topwriters |> 
  count(written_by)



topwriters |> 
  ggplot(aes(x = written_by, fill = written_by)) +
  geom_bar(show.legend = FALSE) + 
  geom_text(data = writer_labels,
            aes(y = n, label = n), 
            nudge_y = -0.25, vjust = "top") + 
  scale_x_discrete(name = NULL, 
                   labels = c("Alexa \n Junge", 
                              "Andrew \n Reich \n & Ted \n Cohen", 
                              "David \n Crane & \n Marta \n Kauffman",
                              "Doty \n Abrams", 
                              "Seth \n Kurland", 
                              "Shana \n Goldberg-\n Meehan", 
                              "Scott \n Silveri", 
                              "Sherry \n Bilsing-\n Graham \n & Ellen \n Plummer", 
                              "Wil \n Calhoun", 
                              "Adam \n Chase", 
                              "Jeffrey \n Astrof \n & Mike \n Sikowitz")) +
  labs(title = "Episode Writers", 
       subtitle = "Total Number of Episodes Written by the 11 Most Recurring Writers", 
       x = "Character", y = NULL) +
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5, size = 15, face = "bold"), 
        plot.subtitle = element_text(hjust = 0.5, size = 10), 
        axis.title.x = element_text(hjust = 0.5, size = 10, face = "bold"))

ggsave("plots/info_dist_topwriters.png") 
