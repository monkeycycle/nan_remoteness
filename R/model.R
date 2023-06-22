# =======================================================================
# Run a linear regression on the data and-
# check the model's performance and coefficients.
#
# Basic regression syntax is-
# lm([target] ~ [predictor / features], data = [data source])
#
# =======================================================================

# cost ratio

# This is a single variable regression based on available data from sample
model_1 <- lm(cost_ratio ~ cma, data = sample)
# summary(sales_cma)

model_1 = lm(per_student_ISC_cost_perc ~ size + age + fci
             + as.factor(remoteness) + total_enroll_2022
             + as.factor(teacherage), data = data)

# Plot the residuals
# plot(sales_cma$residuals, pch = 16, col = "red")


