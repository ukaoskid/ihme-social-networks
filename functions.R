calculate_incidence_by_cause <- function(national_dataset, disease_id) {
  
  aggregated <- national_dataset %>%
    filter(cause_id == disease_id, metric_id == 1) %>%
      group_by(year, cause_name, metric_id, metric_name) %>%
      summarize(sum_val = sum(val))
}

calculate_rate_by_cause <- function(national_dataset, disease_id) {
  
  aggregated <- national_dataset %>%
    filter(cause_id == disease_id, metric_id == 3) %>%
    group_by(year, cause_name, metric_id, metric_name) %>%
    summarize(sum_val = sum(val))
}

calculate_perc_by_cause <- function(national_dataset, disease_id) {
  
  aggregated <- national_dataset %>%
    filter(cause_id == disease_id, metric_id == 2) %>%
    group_by(year, cause_name, metric_id, metric_name) %>%
    summarize(sum_val = sum(val))
}

plot_event <- function(tmp_data) {
  
  ggplot(data = tmp_data, aes(x = year, y = sum_val, group = metric_name, colour = metric_name)) +
    geom_line() +
    geom_point(size = 4, shape = 21, fill = "white") +
    labs(title = tmp_data$cause_name[1], x = "Year", y = "Value") +
    scale_fill_discrete(name = "Metric")
}