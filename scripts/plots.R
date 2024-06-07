source("scripts/settings.R")



# Show plots in browser
plot_files <- list.files(list.dirs(paste0(config$plot_path)), pattern = ".pdf", full.names = T)
filtered_files <- plot_files[!grepl("public_nas", plot_files)]

files <- paste0(getwd(), "/", filtered_files)
shell("start chrome")
invisible(lapply(files, function(x) shell(paste0("start chrome ", x))))