##CODEBOOKS

library(sjlabelled)

get_label(lines_info_emotions)


full_codebook <- tibble(
  variables = c("text", "speaker", "season","episode", "scene", "utterance",
                "title", "directed_by", "written_by", "air-date", "us_views_millions", "imdb_rating", "emotion"),
  descriptions = c("The line delivered or a specific scene direction",
                   "The character who delivered the line, or 'Scene Direction' for a scene direction",
                   "The season of the show the text is from",
                   "The episode of the season of the show the text is from",
                   "The scene of the episode of the season of the show the text is from",
                   "The chronological order in the scene of the text",
                   "The title of the episode the text is from",
                   "The director of the episode the text is from",
                   "The writer(s) of the episode the text is from",
                   "The first date the episode was available to watch in the US", 
                   "The number of views the episode got in the US in millions", 
                   "The IMDB Rating of the episode (1 is worst, 10 is best)", 
                   "The emotion the text was delivered with out of 7 emotions")) |> 
  as_data_frame()

full_codebook

write_csv(full_codebook, file = "data/full_codebook.csv")
