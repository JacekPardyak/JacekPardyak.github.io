# Way to convert svg files to pdf and png
# requires Inkscape installed

files <- list.files("./F/", pattern = ".svg", full.names = T)

for (file in files) {
   command <- paste('inkscape  --export-type=png --export-width=30', file, sep = " ")
   system(command)
}
