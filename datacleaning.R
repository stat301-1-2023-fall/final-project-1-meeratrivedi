## DATA SUBSETS

library(tidyverse)

lines <- read_csv("data/friends.csv")
info <- read_csv("data/friends_info.csv")
emotions <- read_csv("data/friends_emotions.csv")

#joining lines and emotions

openingscene <- lines |> 
  filter(season == "1", episode == "1", scene == "1")


lines_emotions <- lines |> 
  filter(speaker != "Scene Directions") |> 
  left_join(emotions)

lines_emotions |> 
  count(emotion)

#just monica
monica <- lines |> 
  filter(speaker == "Monica Geller") 

#just the 6 main characters
maincharacters <- lines |> 
  filter(speaker %in% c("Monica Geller", 
                        "Ross Geller", 
                        "Rachel Green", 
                        "Phoebe Buffay", 
                        "Joey Tribbiani", 
                        "Chandler Bing"))

#everyone but the main characters
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

read_csv(file = "data/friends.csv", 
         col_types = cols(grade = col_integer(), 
                          student = col_character()))


topguestcharacters <- guestcharacters |> 
  group_by(speaker) |> 
  count(speaker) |> 
  filter(n > 10) |> 
  arrange(desc(n)) |> 
  rename(num_lines = n) |> 
  slice_max(num_lines, n = 10)

topguestcharacters

#join lines and info
linesinfo <- 
lines |> 
  full_join(info)

#how many episodes did each write
info |> 
  count(written_by) |>
  filter(n > 1) |> 
  arrange(desc(n)) |> 
  rename(episodes_written = n) |> 
  slice_max(episodes_written, n = 10)