library(tidyverse)
library(cmdstanr)


df <- read_csv(
  "https://raw.githubusercontent.com/MaggieLieu/STAN_tutorials/master/Hierarchical/premiereleague.csv",
  col_names = c("home_team", "home_score", "away_score", "away_team")
)
df


mod <- cmdstan_model("model.stan")

