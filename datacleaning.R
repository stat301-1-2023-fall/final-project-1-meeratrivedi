## DATA SUBSETS

library(tidyverse)

#joining lines and emotions


openingscene <- lines |> 
  filter(season == "1", episode == "1", scene == "1") |> 
  left_join(emotions |> filter(season == "1", episode == "1", scene == "1"), 
            by = c("season" = "season"))


monica <- lines |> 
  filter(speaker == "Monica Geller") 

maincharacters <- lines |> 
  filter(speaker %in% c("Monica Geller", 
                        "Ross Geller", 
                        "Rachel Green", 
                        "Phoebe Buffay", 
                        "Joey Tribbiani", 
                        "Chandler Bing"))


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
  rename(lines = n) |> 
  filter(lines > 10) |> 
  mutate(lines = as.double(lines)) |> 
  arrange(desc(lines))