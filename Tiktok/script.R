if(!require(remotes)) {
  install.packages("remotes"); require(remotes)}
remotes::install_github("gadenbuie/tiktokrmd")
library(tiktokrmd)
library(tidyverse)

tt_url <- "https://www.tiktok.com/@dunglishtodutch/video/6949236919330966790"

tt <- tiktok_embed(tt_url)
tt

# Or write a plain markdown version
tiktok_md(tt) %>% write(file = "./Tiktok/readme.md")
#> [1] "![[#cake #cakes #dontmixit #cakelover #cakelovers #dumpcake #food #tiktokfood #foodtiktok #easyrecipe #easyrecipes #peach #peaches #cinnamon #fyp](https://www.tiktok.com/@aquickspoonful/video/6890681375431691526) by [Sophia Wasu](https://www.tiktok.com/@aquickspoonful)](https://p16-sign-va.tiktokcdn.com/obj/tos-maliva-p-0068/00189a8b703343bd817a3ccaec240f71?x-expires=1610654400&x-signature=ExJZaEMAgxhyXydfgsqgZqU%2B8y8%3D)"

# Or as HTML without the full TikTok embedded player shenanigans
tiktok_html(tt, include_player = FALSE) %>% write(file = "./Tiktok/index.html")
