context("GMT")

test_that("GMT does not work", {
  skip_if_not(we_are_raady())
  f <- file.path(getOption("default.datadir"), "data/www.ngdc.noaa.gov/mgg/global/relief/ETOPO1/data/ice_surface/grid_registered/netcdf/ETOPO1_Ice_g_gdal.grd")
  expect_error(tidync(f), "not yet supported")
})
