# =======================================================================
# Run a linear regression on the data and-
# check the model's performance and coefficients.
#
# Basic regression syntax is-
# lm([target] ~ [predictor / features], data = [data source])
#
# =======================================================================

# I think that fte_row is the cost ratio

###### Linear Models ######

### Run the first regression with only the remoteness index.
lin_mod_1 = lm(fte_row ~ index_of_remoteness, data = df_for_cost_ratio_model)

### Now we'll run this model with the 19 and under population
lin_mod_2 = lm(fte_row ~ index_of_remoteness + u19_population,
                 data = df_for_cost_ratio_model)

### Run the model with staff ratio as well.
lin_mod_3 = lm(fte_row ~ index_of_remoteness + u19_population + population_ratio,
                 data = df_for_cost_ratio_model)


###### Logged Models (logging cost ratio) ######

### Run the first regression with only the remoteness index.
log_mod_1 = lm(log(fte_row) ~ index_of_remoteness, data = df_for_cost_ratio_model)

### Now we'll run this model with the 19 and under population
log_mod_2 = lm(log(fte_row) ~ index_of_remoteness + u19_population,
                 data = df_for_cost_ratio_model)

### Run the model with staff ratio as well.
log_mod_3 = lm(log(fte_row) ~ index_of_remoteness + u19_population + population_ratio,
                 data = df_for_cost_ratio_model)


###### RESULTS ######
# summary(lin_model_2)

stargazer(list(lin_mod_1, lin_mod_2, lin_mod_3),
          type = 'text',
          title = "Comparison of Cost Ratio models:",
          subtitle = "Linear models",
          digits = 2)

# the results from this regression we see that when our regression is run with
# just the remoteness index, the R squared values are very low. This means that
# remoteness doesn't really explain this data very well on it's own.

# after we add the under 19 population the model fits the data much better. It
# also changes the sign of the coefficient for the remoteness index. (need to
# come back and interpret what this means.)

# adding the staff ratio improves the R squared values but decreases the F stat.
# (need to spend more time thinking about this)

stargazer(list(log_mod_1, log_mod_2, log_mod_3),
          type = 'text',
          title = "Comparison of Cost Ratio models:",
          subtitle = "Logged models",
          digits = 2)


stargazer(list(lin_mod_2, log_mod_2, lin_mod_3, log_mod_3),
          type = 'text',
          title = "Comparison of Cost Ratio models:",
          subtitle = "Linear and Logged models",
          digits = 2)

# linear models fit better than logged models

###### RESIDUAL PLOTS ######
### linear model with remoteness index
lin_model_1_plot = ggplot(lin_model_1,
                          aes(x = .fitted, y = .resid)) +
  geom_point() +
  geom_hline(yintercept = 0) +
  labs(title = "Residual vs. Fitted Values Plot",
       subtitle = "Linear Cost Ratio model with Remoteness Index",
       x = "Fitted Values",
       y = "Residuals")

plot(lin_model_1_plot)

# hard to see a clear pattern in this plot (likely because of a lack of data)


### linear model with remoteness index and the under 19 population
lin_model_2_plot = ggplot(lin_model_2,
                          aes(x = .fitted, y = .resid)) +
  geom_point() +
  geom_hline(yintercept = 0) +
  labs(title = "Residual vs. Fitted Values Plot",
       subtitle = "Linear Cost Ratio model with Remoteness Index and Under 19 Population ",
       x = "Fitted Values",
       y = "Residuals")

plot(lin_model_2_plot)


### linear model with remoteness index, the under 19 population, and staff ratio
lin_model_3_plot = ggplot(lin_model_3,
                          aes(x = .fitted, y = .resid)) +
  geom_point() +
  geom_hline(yintercept = 0) +
  labs(title = "Residual vs. Fitted Values Plot",
       subtitle = "Linear Cost Ratio model with Remoteness Index, Under 19 Population, and Staff Ratio ",
       x = "Fitted Values",
       y = "Residuals")

plot(lin_model_3_plot)
