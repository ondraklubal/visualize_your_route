library(XML)

setwd("~/Documents/Osobní/R/Mapař")
gpx_parsed <- htmlTreeParse(file = "prechod_krkonos.gpx", useInternalNodes = TRUE)
#gpx_parsed

coords <- xpathSApply(doc = gpx_parsed, path = "//trkpt", fun = xmlAttrs)
elevation <- xpathSApply(doc = gpx_parsed, path = "//trkpt/ele", fun = xmlValue)

df <- data.frame(
  lat = as.numeric(coords["lat", ]),
  lon = as.numeric(coords["lon", ]),
  elevation = as.numeric(elevation)
)

rm(list = c("gpx_parsed", "coords", "elevation"))

head(df, 10)
tail(df, 10)

par(bg=NA)

plot(x = df$lon, y = df$lat, type = "l", col = "black", lwd = 3, xaxt='n', yaxt='n', ann=FALSE, frame.plot=FALSE)


dev.copy(png, "rplot.png")
dev.off()


