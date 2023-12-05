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
  scale_color_manual(name = NULL,
                     values = c("#FFBC00", "#00B4EA", "#FF181E", "#FFBC00", "#00B4EA", "#FF181E")) +
  facet_wrap(~speaker)+
  labs(title = "Line Count - Main Characters", 
       subtitle = "Total Number of Lines in Every Season for the Six Main Characters", 
       x = "Season", y = NULL) +
  theme_linedraw()+
  theme(plot.title = element_text(hjust = 0.5, size = 15, face = "bold"), 
        plot.subtitle = element_text(hjust = 0.5, size = 10), 
        axis.title.x = element_text(hjust = 0.5, size = 10, face = "bold"))

ggsave("plots/line_by_season_maincharacters.png") 



## Emotions Analyses ------

##boxplots ----
boxplot1 <- ggplot(lines_info_emotions, aes(x = emotion, y = imdb_rating, fill = emotion)) +
  geom_boxplot(alpha = 0.5, show.legend = FALSE)+
  labs(title = "Ratings by Emotions", 
       subtitle = "Distribution of IMDB Ratings that episodes with lines of different emotions got.", 
       x = "Emotion", y = "IMDB Rating") +
  scale_fill_manual(name = NULL,
                    values = c("#FFBC00", "#00B4EA", "#FF181E", "#FFBC00", "#00B4EA", "#FF181E", "#FFBC00")) +
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5, size = 15, face = "bold"), 
        plot.subtitle = element_text(hjust = 0.5, size = 10), 
        axis.title.x = element_text(hjust = 0.5, size = 10, face = "bold"), 
        axis.title.y = element_text(hjust = 0.5, size = 10, face = "bold"))


boxplot2 <- ggplot(lines_info_emotions, aes(x = emotion, y = us_views_millions, fill = emotion)) +
  geom_boxplot(alpha = 0.5, show.legend = FALSE)+
  labs(title = "Views by Emotions", 
       subtitle = "Distribution of US Views that episodes with lines of different emotions got.", 
       x = "Emotion", y = "Views (Millions)") +
  scale_fill_manual(name = NULL,
                    values = c("#FFBC00", "#00B4EA", "#FF181E", "#FFBC00", "#00B4EA", "#FF181E", "#FFBC00")) +
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5, size = 15, face = "bold"), 
        plot.subtitle = element_text(hjust = 0.5, size = 10), 
        axis.title.x = element_text(hjust = 0.5, size = 10, face = "bold"), 
        axis.title.y = element_text(hjust = 0.5, size = 10, face = "bold"))

library(cowplot)
boxplots <- plot_grid(boxplot2/boxplot1)

ggsave("plots/views_ratings_by_emotion.png")



 


##faceted bar graph-----

maincharacter_emotions <- lines_emotions |> 
  filter(speaker %in% maincharacters$speaker) |> 
  group_by(speaker) |> 
  count(emotion) |> 
  filter(!is.na(emotion))

maincharacter_emotions |> 
  ggplot(aes(x = emotion, y = n, fill = emotion))+
  facet_wrap(~speaker)+
  coord_flip()+
  geom_col(show.legend = FALSE)+
  geom_text(data = maincharacter_emotions, 
            aes(y = n, label = n), 
            color = "black",
            size = 3, 
            hjust = 1.2)+
  scale_fill_manual(name = NULL, 
                    values = c("mediumturquoise", "darkturquoise", "turquoise", "mediumturquoise", "darkturquoise", "turquoise", "mediumturquoise"))+
  labs(title = "Count of Lines by Emotion - Main Characters", 
       subtitle = "Number of Lines in the first 4 seasons delivered with 7 different emotions per character.", 
       x = "Emotion", y = NULL) +
  theme_linedraw()+
  theme(plot.title = element_text(hjust = 0.5, size = 15, face = "bold"), 
        plot.subtitle = element_text(hjust = 0.5, size = 10), 
        axis.title.y = element_text(hjust = 0.5, size = 10, face = "bold"))

ggsave("plots/emotions_count_maincharacters.png") 


## Info Analyses ------

#views and ratings --------
ggplot(data = info, aes(us_views_millions, imdb_rating))+
  geom_jitter(alpha = 0.75) + 
  geom_smooth() +
  coord_cartesian(ylim = c(7, 10)) +
  labs(title = "IMDB Rating By Millions of Views", 
       subtitle = "Relationship between the IMDB rating and views in the United States for each episode.", 
       x = "Views (Millions)", y = "IMDB Rating") +
  theme_minimal() + 
  theme(plot.title = element_text(hjust = 0.5, size = 15, face = "bold"), 
        plot.subtitle = element_text(hjust = 0.5, size = 10), 
        axis.title.x = element_text(hjust = 0.5, size = 10, face = "bold"), 
        axis.title.y = element_text(hjust = 0.5, size = 10, face = "bold"))
  
ggsave("plots/imdb_by_views.png") 



#views for directors-------
director_plot <- topdirectors |> 
  filter(directed_by %in% c("Gary Halvorson", "Kevin S. Bright", "Michael Lembeck")) |> 
  ggplot(mapping = aes(x = season, y = us_views_millions, color = directed_by))+
  geom_point(show.legend = FALSE)+
  facet_wrap(~directed_by, nrow = 1)+
  scale_x_continuous(breaks = seq(1, 10, 1))+
  scale_color_manual(name = NULL,
                     values = c("#FFBC00", "#00B4EA", "#FF181E")) +
  labs(title = "Episode Views by Season for the Top 3 Directors", 
     subtitle = "Views in the United States throughout all 10 Seasons for the Top 3 Directors", 
     x = "Season", y = "Views (Millions)") +
  theme_linedraw()+
  theme(plot.title = element_text(hjust = 0.5, size = 15, face = "bold"), 
        plot.subtitle = element_text(hjust = 0.5, size = 10), 
        axis.title.x = element_text(hjust = 0.5, size = 10, face = "bold"), 
        axis.title.y = element_text(hjust = 0.5, size = 10, face = "bold"))



#views for writers -----
writer_plot <- topwriters |> 
  filter(written_by %in% c("Alexa Junge", "Andrew Reich & Ted Cohen", "David Crane & Marta Kauffman")) |> 
  ggplot(mapping = aes(x = season, y = us_views_millions, color = written_by))+
  geom_point(show.legend = FALSE)+
  facet_wrap(~written_by)+
  scale_x_continuous(breaks = seq(1, 10, 1))+
  scale_color_manual(name = NULL,
                     values = c("#FFBC00", "#00B4EA", "#FF181E")) +
  labs(title = "Episode Views by Season for the Top 3 Writers", 
       subtitle = "Views in the United States throughout all 10 Seasons for the Top 3 Writers", 
       x = "Season", y = "Views (Millions)") +
  theme_linedraw()+
  theme(plot.title = element_text(hjust = 0.5, size = 15, face = "bold"), 
        plot.subtitle = element_text(hjust = 0.5, size = 10), 
        axis.title.x = element_text(hjust = 0.5, size = 10, face = "bold"), 
        axis.title.y = element_text(hjust = 0.5, size = 10, face = "bold"))


library(patchwork)
directors_writers <- director_plot / writer_plot

ggsave("plots/directors_writers_plot.png") 


writer_box <- topwriters |> 
  filter(written_by %in% c("Alexa Junge", "Andrew Reich & Ted Cohen", "David Crane & Marta Kauffman")) |> 
  ggplot(mapping = aes(x = factor(season), y = us_views_millions, color = written_by))+ 
  geom_boxplot(show.legend = FALSE)+
  facet_wrap(~written_by)+
  scale_color_manual(name = NULL,
                     values = c("#FFBC00", "#00B4EA", "#FF181E")) +
  labs(title = "Episode Views by Season for the Top 3 Writers", 
       subtitle = "Views in the United States throughout all 10 Seasons for the Top 3 Writers", 
       x = "Season", y = "Views (Millions)") +
  theme_linedraw()+
  theme(plot.title = element_text(hjust = 0.5, size = 15, face = "bold"), 
        plot.subtitle = element_text(hjust = 0.5, size = 10), 
        axis.title.x = element_text(hjust = 0.5, size = 10, face = "bold"), 
        axis.title.y = element_text(hjust = 0.5, size = 10, face = "bold"))


director_box <- topdirectors |> 
  filter(directed_by %in% c("Gary Halvorson", "Kevin S. Bright", "Michael Lembeck")) |> 
  ggplot(mapping = aes(x = factor(season), y = us_views_millions, color = directed_by))+
  geom_boxplot(show.legend = FALSE)+
  facet_wrap(~directed_by)+
  scale_color_manual(name = NULL,
                     values = c("#FFBC00", "#00B4EA", "#FF181E")) +
  labs(title = "Episode Views by Season for the Top 3 Directors", 
       subtitle = "Views in the United States throughout all 10 Seasons for the Top 3 Directors", 
       x = "Season", y = "Views (Millions)") +
  theme_linedraw()+
  theme(plot.title = element_text(hjust = 0.5, size = 15, face = "bold"), 
        plot.subtitle = element_text(hjust = 0.5, size = 10), 
        axis.title.x = element_text(hjust = 0.5, size = 10, face = "bold"), 
        axis.title.y = element_text(hjust = 0.5, size = 10, face = "bold"))

directors_writers_box <- director_box / writer_box

ggsave("plots/directors_writers_box.png") 

#views distribution over time ------
year_labels <- info |> 
  mutate(release_year = year(air_date)) |> 
  summarize(mean = mean(us_views_millions), .by = release_year) |> 
  mutate(mean = round(mean, digits = 1))
  
info |> 
  mutate(release_year = year(air_date)) |> 
  summarize(mean = mean(us_views_millions), .by = release_year) |> 
  ggplot(mapping = aes(x = release_year, y = mean))+
  geom_point(size = 3)+
  geom_line()+
  scale_x_continuous(breaks = seq(1994, 2004, 1), expand = c(0.1,0))+
  scale_y_continuous(breaks = seq(20, 31, 1)) +
  geom_text(data = year_labels, 
            aes(y = mean, label = mean),
            nudge_y = 0, hjust = 1.5,
            size = 3) + 
  labs(title = "Episode Views over Time", 
       subtitle = "Average Number of Episode Views per Year throughout the show.", 
       x = "Release Year", y = "Average Views per Episode (Millions)") +
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5, size = 15, face = "bold"), 
        plot.subtitle = element_text(hjust = 0.5, size = 10), 
        axis.title.x = element_text(hjust = 0.5, size = 10, face = "bold"),
        axis.title.y = element_text(hjust = 0.5, size = 10, face = "bold"))

ggsave("plots/views_over_time.png") 



#imdb density per season -----
density1 <- info |> 
  mutate(release_year = year(air_date), 
         season = factor(season)) |> 
  group_by(season) |> 
  filter(season %in% c("1":"5")) |> 
  ggplot(aes(x = imdb_rating, color = season, fill = season))+ 
  geom_density(alpha = 0.1) + 
  scale_x_continuous(breaks = seq(7, 10, 0.5)) +
  labs(title = "Density of IMDB Ratings per Season", 
       subtitle = "Distribution of the Episode IMDB ratings for each of the first 5 seasons.", 
       x = "IMDB Rating (Out of 10)", y = NULL, color = "Season", fill = "Season") +
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5, size = 15, face = "bold"), 
        plot.subtitle = element_text(hjust = 0.5, size = 10), 
        axis.title.x = element_text(hjust = 0.5, size = 10, face = "bold"),
        axis.title.y = element_text(hjust = 0.5, size = 10, face = "bold"), 
        legend.title = element_text(hjust = 0.5, size = 10, face = "bold"))

density2 <- info |> 
  mutate(release_year = year(air_date), 
         season = factor(season)) |> 
  group_by(season) |> 
  filter(season %in% c("6":"10")) |> 
  ggplot(aes(x = imdb_rating, color = season, fill = season))+ 
  geom_density(alpha = 0.1) + 
  scale_x_continuous(breaks = seq(7, 10, 0.5)) +
  labs(title = "Density of IMDB Ratings per Season", 
       subtitle = "Distribution of the Episode IMDB ratings for each of the last 5 seasons.", 
       x = "IMDB Rating (Out of 10)", y = NULL, color = "Season", fill = "Season") +
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5, size = 15, face = "bold"), 
        plot.subtitle = element_text(hjust = 0.5, size = 10), 
        axis.title.x = element_text(hjust = 0.5, size = 10, face = "bold"),
        axis.title.y = element_text(hjust = 0.5, size = 10, face = "bold"), 
        legend.title = element_text(hjust = 0.5, size = 10, face = "bold"))

library(patchwork)
density1 + density2

ggsave("plots/imdb_density.png") 


