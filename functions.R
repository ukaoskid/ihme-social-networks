calculate_number_by_cause <- function(national_dataset, disease_id) {
  
  aggregated <- national_dataset %>%
    filter(cause_id == disease_id, metric_id == 1, age_id >= 8, age_id <= 14) %>%
      group_by(year, cause_name, age_name, metric_id, metric_name) %>%
      summarize(sum_val = sum(val))
}

plot_event <- function(tmp_data) {
  
  ggplot(data = tmp_data, aes(x = year, y = sum_val, group = age_name, colour = age_name)) +
    geom_line() +
    geom_point(size = 1, shape = 21, fill = "white") +
    labs(title = tmp_data$cause_name[1], x = "Year", y = "Value")
}