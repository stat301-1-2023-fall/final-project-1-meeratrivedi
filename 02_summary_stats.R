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
            n = n()) |> 
  gt() |> 
  tab_header(title = md("**Views and Ratings per Emotion**"), 
             subtitle = md("*Average Views and IMDB Rating for lines with different emotions.*")) |> 
  cols_label(emotion = md("Emotion"), 
             avg_views = md("Average <br> Views"), 
             avg_imdb = md("Average <br> IMDB Rating"), 
             n = md("Number <br> of Lines")) |> 
  tab_source_note(source_note = md("*Views are in millions")) |> 
  fmt_number(
    columns = avg_views, 
    decimals = 2) |> 
  fmt_number(
    columns = avg_imdb, 
    decimals = 2)


#top 5 episodes by views
top5views <- info |> 
  select(season, episode, title, us_views_millions) |> 
  slice_max(us_views_millions, n = 5) |> 
  slice_head(n=5) |> 
  gt() |> 
  tab_header(title = md("**Top 5 Viewed Episodes**"), 
             subtitle = md("*The 5 Episodes with the most US views throughout all 10 seasons.*")) |> 
  cols_label(season = md("Season"), 
             episode = md("Episode"), 
             title = md("Title"), 
             us_views_millions = md("Views")) |> 
  tab_source_note(source_note = md("*Views are in millions")) |> 
  tab_source_note(source_note = md("*Repeated titles refer to two-part episodes")) |> 
  fmt_number(
    columns = us_views_millions, 
    decimals = 1)

#top 5 episodes by rating
top5imdb <- info |> 
  select(season, episode, title, imdb_rating) |> 
  slice_max(imdb_rating, n = 5) |> 
  gt() |> 
  tab_header(title = md("**Top 5 Rated Episodes**"), 
             subtitle = md("*The 5 Episodes with the highest IMDB Ratings throughout all 10 seasons.*")) |> 
  cols_label(season = md("Season"), 
             episode = md("Episode"), 
             title = md("Title"), 
             imdb_rating = md("IMDB Rating")) |> 
  tab_source_note(source_note = md("*Repeated titles refer to two-part episodes"))

listed_tables <- list(top5views, top5imdb)
gt_two_column_layout(listed_tables)
