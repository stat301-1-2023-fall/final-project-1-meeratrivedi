## Friends: An EDA

This repository is for an analysis of data collected on the popular 90s TV show: Friends.


## What is in the Raw Data Folder

This folder contains the raw data used in this analysis in the form of csv files. They were downloaded from Kaggle, via this link: 

### Data Source

Kapadnis, Sujay. (2023, Oct. 23). *Friends Sitcom Dataset*. Kaggle. [www.kaggle.com/datasets/sujaykapadnis/friends/.](www.kaggle.com/datasets/sujaykapadnis/friends/.)


The datasets in the main section of the data folder are derived from this raw data and have been cleaned and stored as new datasets in the form of csv files. 

### New Data Sets

The datasets are listed in the folder in alphabetical order. 

- `friends.csv`: This dataset has 67373 observations for 6 variables: text, speaker, season, episode, scene, and utterance. The other 5 variables correspond to the text variable. 


- `friends_emotions.csv`: This dataset has 12606 observations corresponding to the text variable from scene 4 of the first episode until Season 4 Episode 24. There are 5 variables: 4 that overlap with the first data set: season, episode, scene, and utterance, and then one last categorical variable that is the type of emotion the line is delivered with. There are 7 different categories for this variable: mad, neutral, joyful, scared, playful, powerful, and sad.

- `friends_info.csv`: This dataset has 236 observations corresponding to every episode of the show and there are 8 variables: the season, the episode, the title of the episode, who directed it, who wrote it, the date it aired in the US, the number of views it got in the US in millions, and the IMDB rating. The season and episode variables are the same as the previous datasets. 
