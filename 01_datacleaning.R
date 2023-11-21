## DATA SUBSETS

library(tidyverse)

lines_raw <- read_csv("data/raw/friends.csv")
info <- read_csv("data/raw/friends_info.csv")
emotions <- read_csv("data/raw/friends_emotions.csv")

#opening scene -----

openingscene <- lines |> 
  filter(season == "1", episode == "1", scene == "1")


#lines clean:
lines <- lines_raw |> 
  filter(!is.na(speaker))

write_csv(lines, file = "data/lines.csv")

#joining lines and emotions -----
lines_emotions <- lines |> 
  filter(speaker != "Scene Directions") |> 
  left_join(emotions) |> 
  filter(!is.na(emotion)) |> 
  relocate(speaker, emotion, season, episode, scene, utterance, text)

lines_emotions

write_csv(lines_emotions, file = "data/lines_emotions.csv")






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

write_csv(maincharacters, file = "data/maincharacters.csv")





#everyone but the main characters--------
guestcharacters <- lines |> 
  filter(!speaker %in% c("Monica Geller", 
                         "Ross Geller", 
                         "Rachel Green", 
                         "Phoebe Buffay", 
                         "Joey Tribbiani", 
                         "Chandler Bing", 
                         "Scene Directions", 
                         "#ALL#")) 

write_csv(guestcharacters, file = "data/guestcharacters.csv")





#top guest characters-------
topguestcharacters <- guestcharacters |> 
  group_by(speaker) |> 
  count(speaker) |> 
  filter(n > 10) |> 
  arrange(desc(n)) |> 
  rename(num_lines = n)

top10 <- head(topguestcharacters, n=10)

top10

topguestlines <- lines |> 
  filter(speaker %in% top10$speaker) |> 
  mutate(speaker = factor(speaker, 
                          #order of levels
                          levels = top10$speaker)) |> 
  relocate(speaker, season, episode, scene, utterance, text)

write_csv(topguestlines, file = "data/topguestlines.csv")



topguestlines |>
  slice_head(n = 10)

#join lines and info--------
lines_info <- 
  lines |> 
  full_join(info)

lines_info

write_csv(lines_info, file = "data/lines_info.csv")




#ALL DATA-------
lines_info_emotions <- lines_info |> 
  full_join(emotions) |> 
  filter(!is.na(emotion)) 

lines_info_emotions

write_csv(lines_info, file = "data/lines_info_emotions.csv")




#how many episodes did each write
writers <- info |> 
  count(written_by) |>
  filter(n > 1) |> 
  arrange(desc(n)) |> 
  rename(episodes_written = n) |> 
  slice_max(episodes_written, n = 10)

writers


#guest lines distribution -----
topguestlines <- lines |> 
  filter(speaker %in% top10$speaker) |> 
  mutate(speaker = factor(speaker, 
                          #order of levels
                          levels = top10$speaker))

topguestlines


#top writers ------
topwriters <- info |> 
  filter(written_by %in% writers$written_by) |> 
  mutate(written_by = factor(written_by, 
                          #order of levels
                          levels = writers$written_by))

topwriters



