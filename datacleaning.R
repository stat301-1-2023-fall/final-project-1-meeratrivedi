## DATA SUBSETS


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

ggplot(maincharacters, aes(x = speaker)) +
  geom_bar()


monica |> 
  group_by(season) |> 
  count(speaker) |> 
  ggplot(aes(x = season, y = n)) + 
  geom_point(size = 3)+
  geom_line()+
  scale_x_continuous(breaks = seq(0, 10, 1))

