# Loading IHME dataset.

dataset_files <- list.files("./original-dataset", full.names = TRUE)
if (!exists("ihme")) {
  ihme <<- data.frame()
}

for (sub_dataset in dataset_files) {
  
  print(paste("Loading", sub_dataset, sep = " "))
  
  sub_ihme <- read.csv(sub_dataset)
  ihme <- rbind(ihme, sub_ihme)
}

remove(sub_ihme)
remove(sub_dataset)