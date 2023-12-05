## Friends: An EDA

This repository is for an analysis of data collected on the popular 90s TV show: Friends.


## What is in the Data Folder

This is what can be found in the data folder:

- `raw/`: This folder contains the raw data used in this analysis in the form of csv files. They were downloaded from Kaggle, via this link: 

::: {.callout-tip icon="false"}
## Data Source

Kapadnis, Sujay. (2023, Oct. 23). *Friends Sitcom Dataset*. Kaggle. [www.kaggle.com/datasets/sujaykapadnis/friends/.](www.kaggle.com/datasets/sujaykapadnis/friends/.)
:::

The datasets in the main section of the data folder are derived from this raw data and have been cleaned and stored as new datasets in the form of csv files. 

### New Data Sets

The datasets are listed in the folder in alphabetical order. 

- `lines.csv`: This is a cleaned version of the `friends.csv` dataset with observations for missing values of `speaker` filtered out, since those lines are not relevant to this analysis.

- `lines_emotions.csv`: This is a combination of the `lines.csv` and `friends_emotions.csv` datasets. Observations that have a missing value for `emotion` have been filtered out and observations that correspond to Scene Directions have been filtered out. 

- `lines_info.csv`: This is a combination of the `lines.csv` and `friends_info.csv` datasets. There are no missing values in this dataset.

- `lines_info_emotions.csv`: This is a combination of the `lines.csv`, `friends_info.csv` and `friends_emotions.csv` datasets. Observations that have a missing value for `emotion` have been filtered out.

- `maincharacters.csv`: This is a subset of the `lines.csv` dataset containing only observations of speakers who are the six main characters of the show.  

- `guestcharacters.csv`: This is a subset of the `lines.csv` dataset containing only observations of speakers who are not the six main characters of the show.  

- `topguestlines.csv`: This is a subset of the `lines.csv` dataset containing only observations of the 10 speakers who are not the six main characters of the show who had the most lines.  

- `full_codebook.csv`: This contains the name of each variable in the `lines_info_emotions.csv` dataset and an description of each. Since this dataset contains all variables used, it is a comprehensive overview of all the variables. 


