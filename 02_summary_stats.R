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

info |> 
  summarize(mean = mean(imdb_rating),
            mean1 = mean(us_views_millions),
            .by = season) |> 
  gt() |> 
  tab_header(title = md("**Season Statistics**")) |> 
  cols_label(season = md("Season"), 
             mean = md("Average IMDB Rating"), 
             mean1 = md("Average US Views")) |> 
  tab_source_note(source_note = md("*Views are in millions")) |> 
  fmt_number(
    columns = mean, 
    decimals = 2) |> 
  fmt_number(
    columns = mean1, 
    decimals = 2)

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



writers_episodes |> 
  full_join(writers_lines) |> 
  gt() |> 
  tab_header(title = md("**Total Lines & Episodes Per Writer**")) |> 
  cols_label(written_by = md("Writer(s)"), 
             num_episodes = md("Number of Episodes Written"), 
             num_lines = md("Number of Lines Written"))


##emotions and views and ratings
lines_info_emotions |> 
  group_by(emotion) |> 
  summarize(avg_views = mean(us_views_millions, na.rm = TRUE), 
            avg_imdb = mean(imdb_rating, na.rm = TRUE), 
            n = n())

#top 5 episodes by views
info |> 
  select(season, episode, title, us_views_millions) |> 
  slice_max(us_views_millions, n = 5)

#top 5 episodes by rating
info |> 
  select(season, episode, title, imdb_rating) |> 
  slice_max(imdb_rating, n = 5)


