#import packages
library("tidyverse")
library("raster")
library("dynatopmodel")

#single tile test
dtm1 <- raster("data/NDH Nordhordland 5pkt 2018/data/dtm/DTM_32-1-466-153-62.tif")

#plot elevation
sp::plot(dtm1, main=c("dtm"))

#calculate slope and aspect
slope_aspect <- terrain(dtm, opt=c("slope", "aspect"), unit = "degrees")

sp::plot(slope_aspect, main = c("Slope", "Aspect"))

#upslope area and topographic wetness index
a.atb1 <- upslope.area(dtm1, atb = TRUE)
par(tcl = -0.2, mgp = c(2.5, .5, 0))
sp::plot(a.atb1, main=c("Upslope area (log(m^2/m))", "TWI log(m^2/m)"))




#import dem
dtm <- list.files(path = "data", 
                  pattern = "DTM.*tif$", 
                  recursive = TRUE, 
                  full.names = TRUE) %>% 
  map(raster) %>% 
  do.call(what = merge)

#plot elevation
sp::plot(dtm, main=c("dtm"))

#calculate slope and aspect
slope_aspect <- terrain(dtm, opt=c("slope", "aspect"), unit = "degrees")

sp::plot(slope_aspect, main = c("Slope", "Aspect"))

#upslope area and topographic wetness index
a.atb <- upslope.area(dtm, atb = TRUE)
par(tcl = -0.2, mgp = c(2.5, .5, 0))
sp::plot(a.atb, main=c("Upslope area (log(m^2/m))", "TWI log(m^2/m)"))


#test
data(brompton)

tst <- upslope.area(brompton$dem, atb=TRUE)
sp::plot(tst, main=c("Upslope area (log(m^2/m))", "TWI log(m^2/m)"))


#dom
dom <- list.files(path = "data", 
                  pattern = "DOM.+\\.tif$", 
                  recursive = TRUE, 
                  full.names = TRUE) %>% 
  map(raster) %>% 
  do.call(what = merge)

#veg height
delta <- dom-dtm
delta
sp::plot(delta, main = "delta")
