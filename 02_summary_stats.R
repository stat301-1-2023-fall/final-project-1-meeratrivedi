## SUMMARY STATS

#guest lines
topguestcharacters <- guestcharacters |> 
  group_by(speaker) |> 
  count(speaker) |> 
  filter(n > 10) |> 
  arrange(desc(n)) |> 
  rename(num_lines = n)

top10 <- head(topguestcharacters, n=10)

top10 |> 
  knitr::kable()


#average imdb rating per season

info |> 
  summarize(mean = mean(imdb_rating), 
            .by = season)

#episodes per season



#average views per season

info |> 
  summarize(mean = mean(us_views_millions), 
            .by = season)

#lines by writer
writers_lines <- lines_info |> 
  count(written_by) |> 
  rename(num_lines = n) |> 
  arrange(desc(num_lines))

writers_lines <- head(writers_lines, n=10)


#lines per episode
writers_episodes <- info |> 
  count(written_by) |> 
  rename(num_episodes = n) |> 
  arrange(desc(num_episodes))

writers_episodes <- head(writers_episodes, n = 10)

