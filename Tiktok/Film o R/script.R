# library(datasauRus)
# Free music https://freemusicarchive.org/music/The_Polish_Ambassador
library(ggplot2)
library(gganimate)
library(av)
library(plotly)

ax <- list(
  title = "",
  zeroline = FALSE,
  showline = FALSE,
  showticklabels = FALSE,
  showgrid = FALSE,
  scaleanchor  = "x"
)

prepare <- function(file, dataset){
  tmp <- read.delim(file = file, header = F, sep = " ", skip = 15, comment.char = "(")
  tmp <- tmp[, c("V2", "V3")]
  names(tmp) <- c("x", "y")
  tmp$x <- as.numeric(gsub("X", "", tmp$x))
  tmp$y <- as.numeric(gsub("Y", "", tmp$y))
  tmp <- tmp[!is.na(tmp$x),]
  tmp <- tmp[tmp$x != 0,]
  tmp$x <- round(tmp$x, digits = 1)
  tmp$y <- round(tmp$y, digits = 1)
  tmp <- unique(tmp)
  tmp$dataset <- dataset
  tmp
}


# initiate empty data
data <- data.frame()


# Folium of Descartes

# circle with error
n = 1649
a = 45

dataset <- "layer1"
u <- runif(n = n, min = 0, max = 2)
noise <- runif(n = n, min = -1, max = 1)

tmp <- data.frame(x = 80 + noise + a*cospi(u),
                  y = 45 + noise + a*sinpi(u),
                  dataset = dataset)

for (i in c(1:nrow(tmp))) {
  rand = runif(n = 1, min = 0, max = 1)
  tmp$x[i] <- tmp$x[i] * rand
  tmp$y[i] <- tmp$y[i] * rand
}

data <- rbind(data, tmp)

# circle
n = 1649
a = 45

dataset <- "layer2"
u <- runif(n = n, min = 0, max = 2)
noise <- runif(n = n, min = -1, max = 1)

tmp <- data.frame(x = 80 + noise + a*cospi(u),
                  y = 45 + noise + a*sinpi(u),
                  dataset = dataset)

plot_ly(data = tmp, x = ~x, y = ~y, type="scatter", mode = "markers") %>% layout(xaxis = ax, yaxis = ax)
data <- rbind(data, tmp)

# involute of circle
n = 1649
a = 5
dataset <- "layer3"
u <- runif(n = n, min = 0, max = 7)
noise <- runif(n = n, min = -1, max = 1)

tmp <- data.frame(x = 80 + noise + a * (cospi(u) + u * sinpi(u)),
                  y = 45 + noise + a * (sinpi(u) - u * cospi(u)),
                  dataset = dataset)
summary(tmp)
#plot_ly(data = tmp, x = ~x, y = ~y, type="scatter", mode = "markers") %>% layout(xaxis = ax, yaxis = ax)


data <- rbind(data, tmp)

# Lissajous Curves
n = 1649
a = 80
b = 45
c = 1.1
m = 2
dataset <- "layer4"
u <- runif(n = n, min = 0, max = 7)
noise <- runif(n = n, min = -1, max = 1)

tmp <- data.frame(x = 80 + noise + a * sinpi(m * u + c),
                  y = 45 + noise + b * sinpi(u),
                  dataset = dataset)
summary(tmp)
# plot_ly(data = tmp, x = ~x, y = ~y, type="scatter", mode = "markers") %>% layout(xaxis = ax, yaxis = ax)

data <- rbind(data, tmp)


# Hypocycloid

n = 1649
a = 25
b = 20
dataset <- "layer5"
u <- runif(n = n, min = 0, max = 9)
noise <- runif(n = n, min = -1, max = 1)

tmp <- data.frame(x = 80 + noise + (a - b) * cospi(u) + b*cospi((a/b - 1) * u),
                  y = 45 + noise + (a - b) * sinpi(u) - b*sinpi((a/b - 1) * u),
                  dataset = dataset)
summary(tmp)
#plot_ly(data = tmp, x = ~x, y = ~y, type="scatter", mode = "markers") %>% layout(xaxis = ax, yaxis = ax)


data <- rbind(data, tmp)

# Epicloid
n = 1649
a = 10
b = 20
dataset <- "layer6"
u <- runif(n = n, min = 0, max = 4)
noise <- runif(n = n, min = -1, max = 1)

tmp <- data.frame(x = 80 + noise + (a + b) * cospi(u) - b*cospi((a/b + 1) * u),
                  y = 45 + noise + (a + b) * sinpi(u) - b*sinpi((a/b + 1) * u),
                  dataset = dataset)
summary(tmp)
#plot_ly(data = tmp, x = ~x, y = ~y, type="scatter", mode = "markers") %>% layout(xaxis = ax, yaxis = ax)
data <- rbind(data, tmp)

# add astroid 
# n = 1649
# a = 30
# dataset <- "layer7"
# u <- runif(n = n, min = 0, max = 2)
# noise <- runif(n = n, min = -1, max = 1)
# 
# tmp <- data.frame(x = 80 + noise + a * (cospi(u))^3,
#                   y = 45 + noise + a * (sinpi(u))^3,
#                   dataset = dataset)
# data <- rbind(data, tmp)

# add rose 
n = 1649
a = 45
k = 4

dataset <- "layer7"
u <- runif(n = n, min = 0, max = 2)
noise <- runif(n = n, min = -1, max = 1)

tmp <- data.frame(x = 80 + noise + a * sinpi(k*u) * cospi(u),
                  y = 45 + noise + a * sinpi(k*u) * sinpi(u),
                  dataset = dataset)
summary(tmp)
#plot_ly(data = tmp, x = ~x, y = ~y, type="scatter", mode = "markers") %>% layout(xaxis = ax, yaxis = ax)


data <- rbind(data, tmp)

# add cycloid 
n = 1649
a = 60
h = 45
dataset <- "layer8"
u <- runif(n = n, min = 1, max = 3)
noise <- runif(n = n, min = -1, max = 1)

tmp <- data.frame(x = -40 + noise  + a*u - h*sinpi(u),
                  y = -15 + noise + a   - h*cospi(u),
                  dataset = dataset)
summary(tmp)
#plot_ly(data = tmp, x = ~x, y = ~y, type="scatter", mode = "markers") %>% layout(xaxis = ax, yaxis = ax)


data <- rbind(data, tmp)


# initiate R with oryginal
# oryginal <- prepare("./rebus/Film o R/output_0002.ngc", "layer5")
# data <- rbind(data, oryginal)

# add point for elipse
# dataset = "layer6"
# oryginal <- prepare("./rebus/Film o R/output_0002.ngc", dataset)
# n = 2000 - 1649
# tmp <- data.frame(x = rep(min(oryginal$x), n),
#                   y = rep(max(oryginal$y), n),
#                   dataset = dataset)
# oryginal <- rbind(oryginal, tmp)
# data <- rbind(data, oryginal)

# add cloud for elipse
dataset = "layer9"
oryginal <- prepare("./rebus/Film o R/output_0002.ngc", dataset)
plot_ly(data = oryginal, x = ~x, y = ~y, type="scatter", mode = "markers") %>% layout(xaxis = ax, yaxis = ax)

n = 2000 - 1649
tmp <- data.frame(x = runif(n = n, min = 0, max = 160), 
                  y = runif(n = n, min = 0, max = 90),
                  dataset = dataset)
oryginal <- rbind(oryginal, tmp)

oryginal <- oryginal[sample(c(1:2000), 2000),]

data <- rbind(data, oryginal)


# initiate elipse + R with oryginal
oryginal <- prepare("./rebus/Film o R/output_0001.ngc", "layer91")
plot_ly(data = oryginal, x = ~x, y = ~y, type="scatter", mode = "markers") %>% layout(xaxis = ax, yaxis = ax)

data <- rbind(data, oryginal)




plot <- ggplot(data, aes(x=x, y=y)) +
  geom_point() +
  coord_fixed() +
  theme_minimal() +
  transition_states(dataset, transition_length = 3, state_length = 0.1, wrap = F) + 
  ease_aes('cubic-in-out') +
  theme_void()

#plot

movie <- animate(plot, duration = 60, fps = 30, 
                 options(gganimate.dev_args = 
                           list(width = 848, height = 477)),
                 renderer = av_renderer(audio = "./rebus/Film o R/Crowander - Open Windows II..mp3"))
anim_save("./rebus/Film o R/output.mp4", movie)


df <- data.frame()
write.csv(df, "./rebus/Film o R/data.csv", row.names = F)









# For Kaggle

# initiate elipse + R with oryginal
oryginal <- read.csv("./rebus/Film o R/R-Logo.csv")

plot_ly(data = oryginal, x = ~x, y = ~y, type="scatter", mode = "markers") %>% layout(xaxis = ax, yaxis = ax)

write.csv(oryginal, "./rebus/Film o R/R-Logo.csv", row.names = F)
