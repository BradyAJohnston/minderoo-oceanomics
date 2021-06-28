library(tidyverse)

df <- read.csv("~/Downloads/4e2c_data_20210625_121022.csv") %>%
  as_tibble() %>%
  rename(
    time = 1,
    temp = 2,
    depth = 3
  ) %>%
  mutate(
    time = lubridate::as_datetime(time),
    depth = 0 - depth,
    group = 1
  ) %>%
  filter(!is.na(depth))

# df %>%
#   as.data.frame()


start = df$time[1]

# df %>%
#   mutate(
#     droptime = (time - start) / 60
#   ) %>%
#   ggplot(aes(droptime, depth)) +
#   geom_line() +
#   scale_x_continuous(breaks = scales::breaks_width(30)) +
#   labs(x = "Time Since Drop (min)")

# df %>%
# pull(depth) %>%
# max()


# sdf <- SharedData$new(df)
# sdf <- df

# temp_plot <- sdf %>%
#   ggplot(aes(depth, temp)) +
#   geom_path(aes(group = group)) +
#   geom_point(aes(colour = time)) +
#   scale_colour_viridis_c(breaks = scales::breaks_width(2000)) +
#   theme_linedraw() +
#   ylim(c(0,NA)) +
#   scale_x_reverse() +
#   # scale_y_reverse()
#   NULL
#
# temp_plot
#
#
# plt <- sdf  %>%
#   ggplot(
#     aes(time,
#         depth,
#         group = group)
#   ) +
#   labs(x = "Time",
#        y = "Depth (m)") +
#   geom_line() +
#   geom_point() +
#   # theme_classic() +
#   theme_linedraw() +
#   # scale_colour_viridis_c() +
#   scale_y_continuous(breaks = c(0:7*-100))
#
# plt



# plotly::ggplotly(plt)


# # tplt <- sdf %>%
#   ggplot(
#     aes(time, temp, group = group)
#   ) +
#   geom_line() +
#   geom_point() +
#   theme_linedraw()
# # plt
# tplt

# plotly::ggplotly(patchwork::wrap_plots(plt, tplt, ncol = 1))

# library(plotly)

# plotly::subplot(plt, ggplotly(temp_plot, ), nrows = 2)



# subplot(subplot(ggplotly(plt),
#                 ggplotly(tplt),
#                 nrows = 2,
#                 shareX = TRUE), temp_plot, nrows = 1)


library(echarts4r)
height = 300

c1 <- df %>%
  e_charts(time,
           height = height,
           elementId = "chart1") %>%
  e_line(depth, legend = FALSE, name = "Depth (m)") %>%
  e_axis_labels(y = "Depth (m)",
                x = "Time") %>%
  e_datazoom(show = FALSE) %>%
  e_tooltip(trigger = "axis") %>%
  e_mark_point("Depth (m)", min)


c2 <- df %>%
  e_charts(time,
           height = height,
           elementId = ) %>%
  e_line(temp,legend = FALSE, name = "Temp") %>%
  # e_visual_map(temp, color = "blue") %>%
  e_mark_point("Temp", min) %>%
  e_axis_labels(y = "Temperature (ºC)",
                x = "Time") %>%
  e_datazoom() %>%
  e_connect(c("chart1")) %>%
  e_tooltip(trigger = "axis")
c2
# c3 <- df %>%
#   e_charts(depth, elementId = "chart2") %>%
#   e_line(temp)
# c3

e_arrange(c1, c2, rows = 2)
# c2

df %>%
  mutate(depth = -depth) %>%
  e_charts(depth) %>%
  e_scatter(temp)
