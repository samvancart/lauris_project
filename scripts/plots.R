source("scripts/settings.R")



# Show plots in browser
plot_files <- list.files(list.dirs(paste0(config$plot_path)), pattern = ".pdf", full.names = T)
files <- paste0(getwd(), "/", plot_files)
shell("start chrome")
invisible(lapply(files, function(x) shell(paste0("start chrome ", x))))