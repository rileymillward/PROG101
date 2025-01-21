##########################################################################
## Driver: (Riley Millward) (rileymillward)                                       ##
## Navigator: (Riley Millward) (rileymillward)                                    ##
## Date: (2025-14-1)                                                   ##
##########################################################################

library(marinecs100b)

# installed these packages in order to isolate data from date/time/zone
install.packages("tidyverse")
install.packages("lubridate")
library(lubridate)

# Guiding questions -------------------------------------------------------

# What does KEFJ stand for?

#  Kenai Fjords

# How was temperature monitored?

# HOBO V2 temperature loggers

# What's the difference between absolute temperature and temperature anomaly?

#absolute temperatures measurable temperatures; temperature anomaly is a one off extreme temperature variance

# Begin exploring ---------------------------------------------------------

# How many kefj_* vectors are there?

?kefj

# there are six

# How long are they?

# 2187966

# What do they represent?

# Temperature readings from five sites in Kenai Fjords 2007-2024.

# Link to sketch

aialik_datetime <- kefj_datetime[kefj_site == "Aialik"]
aialik_interval <- kefj_datetime[2:length(kefj_datetime)] - kefj_datetime[1:length(kefj_datetime)-1]
table(aialik_interval)
#most common sampling interval: 30 minutes


# Problem decomposition ---------------------------------------------------

# When and where did the hottest and coldest air temperature readings happen?

which.max(kefj_temperature)

# Link to sketch

# Plot the hottest day

hottest_idx <- which.max(kefj_temperature)
hottest_time <- kefj_datetime[hottest_idx]
hottest_site <- kefj_site[hottest_idx]
hotday_start <- as.POSIXct(format(hottest_time, "%Y-%m-%d 00:00:00"), tz = "Etc/GMT+8")
hotday_end <- as.POSIXct(format(hottest_time, "%Y-%m-%d 23:59:59"), tz = "Etc/GMT+8")
hotday_idx <- kefj_site == hottest_site &
  kefj_datetime >= hotday_start &
  kefj_datetime <= hotday_end
hotday_datetime <- kefj_datetime[hotday_idx]
hotday_temperature <- kefj_temperature[hotday_idx]
  hotday_exposure <- kefj_exposure[hotday_idx]
  plot_kefj(kefj_datetime, kefj_temperature, kefj_exposure)

  table(plot_kefj)

# Repeat for the coldest day

  coldest_idx <- which.min(kefj_temperature)
  coldest_time <- kefj_datetime[coldest_idx]
  coldest_site <- kefj_site[coldest_idx]
  coldday_start <- as.POSIXct(format(coldest_time, "%Y-%m-%d 00:00:00"), tz = "Etc/GMT+8")
  coldday_end <- as.POSIXct(format(coldest_time, "%Y-%m-%d 23:59:59"), tz = "Etc/GMT+8")
  coldday_idx <- kefj_site == coldest_site &
    kefj_datetime >= coldday_start &
    kefj_datetime <= coldday_end
  coldday_datetime <- kefj_datetime[coldday_idx]
  coldday_temperature <- kefj_temperature[coldday_idx]
  coldday_exposure <- kefj_exposure[coldday_idx]
  plot_kefj(coldday_datetime, coldday_temperature, coldday_exposure)



# What patterns do you notice in time, temperature, and exposure? Do those
# patterns match your intuition, or do they differ?
#temp spikes when exposure is air
# How did Traiger et al. define extreme temperature exposure?
#>25 C
# <-4C
# Translate their written description to code and calculate the extreme heat
# exposure for the hottest day.

# Compare your answer to the visualization you made. Does it look right to you?

# Repeat this process for extreme cold exposure on the coldest day.


# Putting it together -----------------------------------------------------

# Link to sketch

# Pick one site and one season. What were the extreme heat and cold exposure at
# that site in that season?

# Repeat for a different site and a different season.

# Optional extension: Traiger et al. (2022) also calculated water temperature
# anomalies. Consider how you could do that. Make a sketch showing which vectors
# you would need and how you would use them. Write code to get the temperature
# anomalies for one site in one season in one year.
