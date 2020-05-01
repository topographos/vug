library(sf)
library(ggplot2)
library(gganimate)
library(cartography)
library(ggpomological)

carto.pal(pal1 = "taupe.pal" ,n1 = 3)
  
chrono_map = st_read("data/spatial/bart_chrono_1919.shp")

period_colors = c("#851613","#C83B42","#DE7B80","#F0AEB1",
                  "#135D89","#4D95BA","#96D1EA","#52442F","#BEB3A1","#F0E7D9")

period_labels = c("pre 1450","1450 - 1515","1515 - 1622","1622 - 1750",
                  "1750 - 1800 ","1800 - 1825","1825 - 1850","1850 - 1875","1875 - 1900","since 1900")

ggplot() + 
  geom_sf(
    data = chrono_map,
    aes(fill= as.factor(End_Date)),
    alpha = 0.75, 
    colour = NA) +
  scale_fill_manual(name = "End of {current_frame}", values = period_colors, labels = period_labels) +
  theme_pomological() +
  labs(
    title = "Chronological Map of Edinburgh",
    subtitle = "Showing expansion of the City from earliest days to the present \n by J.G. Bartholomew - Cartographer to the King",
    caption = "https://geo.nls.uk/urbhist/"
  ) +
  transition_manual(End_Date, cumulative = T)

# Base plot
basic_iris_plot <- ggplot(iris) +
  aes(x = Sepal.Length, y = Sepal.Width, color = Species) +
  geom_point(size = 2)

# Just your standard Iris plot
basic_iris_plot 
pomological_irisno <- basic_iris_plot + theme_pomological_fancy()
dev.off()
