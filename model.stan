data {
  int<lower=0> num_teams;
  int<lower=0> num_games;
  int<lower=0> home_team_idx[num_games];
  int<lower=0> away_team_idx[num_games];
  int<lower=0> home_team_score[num_games];
  int<lower=0> away_team_score[num_games];
}

parameters {
  real home_adv;
  vector[num_teams] attack_ability;
  vector[num_teams] defense_ability;
  
  // hyper parameters
  real mu_attack;
  real<lower=0> tau_attack;
  real mu_defense;
  real<lower=0> tau_defense;
}

transformed parameters {
  vector[num_games] theta1;
  vector[num_games] theta2;
  
  theta1 = exp(home_adv + attack_ability[home_team_idx] - defense_ability[away_team_idx]);
  theta2 = exp(attack_ability[away_team_idx] - defense_ability[home_team_idx]);
}

model {
  // hyper priors
  mu_attack ~ normal(0, 0.1);
  tau_attack ~ normal(0, 1);
  mu_defense ~ normal(0, 0.1);
  tau_defense ~ normal(0, 1);
  
  // priors
  attack_ability ~ normal(mu_attack, tau_attack);
  defense_ability ~ normal(mu_defense, tau_defense);
  home_adv ~ normal(0, 0.001);
  
  // likelihood
  home_team_score ~ poisson(theta1);
  away_team_score ~ poisson(theta2);
}
