library(sf)
library(ggplot2)
library(gganimate)
library(ggpomological)
library(magick)
library(dplyr)
# load the shp
chrono_map = st_read("data/spatial/bart_chrono_1919.shp")

#period colors
period_colors = c("#851613","#C83B42","#DE7B80","#F0AEB1",
                  "#135D89","#4D95BA","#96D1EA","#52442F","#BEB3A1","#F0E7D9")
#period labels
period_labels = c("pre 1450","1450 - 1515","1515 - 1622","1622 - 1750",
                  "1750 - 1800 ","1800 - 1825","1825 - 1850","1850 - 1875",
                  "1875 - 1900","since 1900")

#plot map for animation
map = ggplot() + 
  geom_sf(
    data = chrono_map,
    aes(fill= as.factor(End_Date)),
    alpha = 0.75, 
    colour = NA) +
  scale_fill_manual(name = "End of {current_frame}", values = period_colors, labels = period_labels) +
  theme_pomological() +
  labs(
    title = "Chronological Map of Edinburgh",
    subtitle = "Showing expansion of the City from earliest days to the present \nby J.G. Bartholomew - Cartographer to the King",
    caption = "https://geo.nls.uk/urbhist/"
  ) +
  transition_manual(End_Date, cumulative = T)

# plot static map
map = ggplot() + 
  geom_sf(
    data = chrono_map,
    aes(fill= as.factor(End_Date)),
    alpha = 0.75, 
    colour = NA) +
  scale_fill_manual(name = "timeline ", values = period_colors, labels = period_labels,
                    guide = guide_legend(
                      direction = 'horizontal',
                      title.position = 'top',
                      title.hjust = .5,
                      label.position = 'bottom',
                      label.hjust = .5,
                      keywidth = .5,
                      keyheight = .5,
                      nrow = 1
                    ))+
  labs(
    title = "Chronological Map of Edinburgh",
    subtitle = "Showing expansion of the City from earliest days to the present \nby J.G. Bartholomew - Cartographer to the King",
    caption = "Source: https://geo.nls.uk/urbhist/"
  ) +
  theme_pomological() +
  theme(
    legend.position = "bottom"
  ) +
  transition_manual(End_Date, cumulative = T)

#create animation
animate(map, width = 800, height = 600)

#save gif
anim_save("map_anim.gif", map, width = 800,
          height = 600)

# plot static map
map_static = ggplot() + 
  geom_sf(
    data = chrono_map,
    aes(fill= as.factor(End_Date)),
    alpha = 0.75, 
    colour = NA) +
  scale_fill_manual(name = "timeline ", values = period_colors, labels = period_labels,
                    guide = guide_legend(
                      direction = 'horizontal',
                      title.position = 'top',
                      title.hjust = .5,
                      label.position = 'bottom',
                      label.hjust = .5,
                      keywidth = .5,
                      keyheight = .5,
                      nrow = 1
                    ))+
  labs(
    title = "Chronological Map of Edinburgh",
    subtitle = "Showing expansion of the City from earliest days to the present \nby J.G. Bartholomew - Cartographer to the King",
    caption = "Source: https://geo.nls.uk/urbhist/"
  ) +
  theme_pomological() +
  theme(
    legend.position = "bottom"
  )

?guide_legend()

# save map
paint_pomological(map_static, width = 800, height = 600) %>% 
  magick::image_write("map_static.png")

