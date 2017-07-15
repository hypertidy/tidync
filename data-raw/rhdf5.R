u <- "https://bitbucket.org/chchrsc/kealib/downloads/utm.kea"
#dir.create("inst/extdata/h5")
download.file(u, file.path("inst/extdata/h5", basename(u)), mode = "wb")


u2 <- "https://oceandata.sci.gsfc.nasa.gov/cgi/getfile/S2008001.L3b_DAY_RRS.nc"
download.file(u2, file.path("inst/extdata/h5", basename(u2)), mode = "wb")
