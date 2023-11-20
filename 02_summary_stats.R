## SUMMARY STATS


#average imdb rating per season

info |> 
  summarize(mean = mean(imdb_rating), 
            .by = season)

#episodes per season


#average views per season

info |> 
  summarize(mean = mean(us_views_millions), 
            .by = season)
