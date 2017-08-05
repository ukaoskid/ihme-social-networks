#
# Social Networks and Mental Diseases evolution.
# Data gathered from IHME (Institute for Health Metrics and Evaluation)
# 
# Website: http://www.healthdata.org
# Dataset: http://ghdx.healthdata.org/gbd-results-tool
#

library(dplyr)
library(lattice)
library(ggplot2)
library(grid)
library(gridExtra)
source("./functions.R", local = TRUE)
#source("./dataset-loading.R", local = TRUE)

#
# Filtering dataset.
#
national_incident <- ihme %>% filter(measure_id == 6, location_id == 109)
diseases_ids <- c(559, 560, 562, 563, 564, 565, 568, 569, 570, 571, 576, 577, 578, 579, 582, 585, 566)
diseases_names <- c(
  "Schizophrenia", "Alcohol use disorders", "Opioid use disorders", "Cocaine use disorders", "Amphetamine use disorders",
  "Cannabis use disorders", "Major depressive disorder", "Dysthymia", "Bipolar disorder", "Anxiety disorders", "Autism",
  "Asperger syndrome and other autistic spectrum disorders", "Attention-deficit/hyperactivity disorder", "Conduct disorder",
  "Idiopathic developmental intellectual disability", "Other mental and substance use disorders", "Other drug use disorders"
)
diseases <- data.frame(diseases_ids, diseases_names, stringsAsFactors = FALSE)
plot_list_incidence = list()
plot_list_rate = list()
plot_list_perc = list()

#
# Plots per disease and metric - Incidence.
#
for(i in 1:nrow(diseases)) {
  
  tmp_data_incidence <- calculate_incidence_by_cause(national_incident, diseases[i,]$diseases_ids)
  tmp_data_rate <- calculate_rate_by_cause(national_incident, diseases[i,]$diseases_ids)
  tmp_data_perc <- calculate_perc_by_cause(national_incident, diseases[i,]$diseases_ids)
  
  if (nrow(tmp_data_incidence) > 0) {
    plot_list_incidence[[i]] = plot_event(tmp_data_incidence)
  }
  
  if (nrow(tmp_data_rate) > 0) {
    plot_list_rate[[i]] = plot_event(tmp_data_rate)
  }

  if (nrow(tmp_data_perc) > 0) {
    plot_list_perc[[i]] = plot_event(tmp_data_perc)
  }  
}

# do.call(grid.arrange, plot_list_perc)
do.call(grid.arrange, plot_list_incidence)
# do.call(grid.arrange, plot_list_rate)