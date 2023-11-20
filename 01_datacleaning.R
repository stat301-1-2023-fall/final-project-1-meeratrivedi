## DATA SUBSETS

library(tidyverse)

lines <- read_csv("data/friends.csv")
info <- read_csv("data/friends_info.csv")
emotions <- read_csv("data/friends_emotions.csv")

#opening scene -----

openingscene <- lines |> 
  filter(season == "1", episode == "1", scene == "1")



#joining lines and emotions -----
lines_emotions <- lines |> 
  filter(speaker != "Scene Directions") |> 
  left_join(emotions) |> 
  filter(!is.na(emotion)) |> 
  relocate(speaker, emotion, season, episode, scene, utterance, text)

lines_emotions

write_rds(lines_emotions, file = "data/new/lines_emotions.rda")





#just monica ------
monica <- lines |> 
  filter(speaker == "Monica Geller") 



#just the 6 main characters-----
maincharacters <- lines |> 
  filter(speaker %in% c("Monica Geller", 
                        "Ross Geller", 
                        "Rachel Green", 
                        "Phoebe Buffay", 
                        "Joey Tribbiani", 
                        "Chandler Bing"))

write_rds(maincharacters, file = "data/new/maincharacters.rda")





#everyone but the main characters--------
guestcharacters <- lines |> 
  filter(!speaker %in% c("Monica Geller", 
                         "Ross Geller", 
                         "Rachel Green", 
                         "Phoebe Buffay", 
                         "Joey Tribbiani", 
                         "Chandler Bing", 
                         "Scene Directions", 
                         "#ALL#")) |> 
  filter(!is.na(speaker))

write_rds(guestcharacters, file = "data/new/guestcharacters.rda")





#top guest characters-------
topguestcharacters <- guestcharacters |> 
  group_by(speaker) |> 
  count(speaker) |> 
  filter(n > 10) |> 
  arrange(desc(n)) |> 
  rename(num_lines = n)

top10 <- head(topguestcharacters, n=10)

top10

#join lines and info--------
lines_info <- 
  lines |> 
  full_join(info) |> 
  select(!text)

lines_info

write_rds(lines_info, file = "data/new/lines_info.rda")




#ALL DATA-------
lines_info_emotions <- lines_info |> 
  full_join(emotions) |> 
  filter(!is.na(emotion)) |> 
  rename(episode_air_date = air_date, 
         episode_us_views_millions = us_views_millions, 
         episode_imdb_rating = imdb_rating, 
         writers = written_by,
         directors = directed_by,
         line_emotion = emotion) |> 
  relocate(title, directors, writers, season, episode, scene, utterance, speaker, line_emotion, episode_air_date, episode_us_views_millions, episode_imdb_rating)

lines_info_emotions

write_rds(lines_info, file = "data/new/lines_info_emotions.rda")




#how many episodes did each write
writers <- info |> 
  count(written_by) |>
  filter(n > 1) |> 
  arrange(desc(n)) |> 
  rename(episodes_written = n) |> 
  slice_max(episodes_written, n = 10)

writers

topwriters <- info |> 
  filter(written_by %in% writers)

#guest lines distribution
topguestlines <- lines |> 
  filter(speaker %in% top10$speaker) |> 
  mutate(speaker = factor(speaker, 
                          #order of levels
                          levels = top10$speaker))

topguestlines



