#rhdf5::h5ls(system.file( "extdata", "h5", "utm.kea", package = "tidync"))
#rhdf5::h5ls(system.file( "extdata", "h5", "S2008001.L3b_DAY_RRS.nc", package = "tidync"))

nc_groups <- function(x, ...) UseMethod("nc_groups")
nc_groups.character <- function(x, ...) {
  rhdf5::h5ls(x, recursive = FALSE, ...)
}

#' Title
#'
#' @param x 
#'
#' @return
#' @export
#'
#' @examples
#' f <- system.file( "extdata", "h5", "S2008001.L3b_DAY_RRS.nc", package = "tidync")
#' nc_groups(f)
#' a <- h5_vars(f)
#' handle <- rhdf5::H5Fopen(f)
#' x <- rhdf5::h5read(handle, sprintf("/%s", a$name[1]))
#' names(x)
#' ## roc only cares about 1:10 here, the rest are guff
#' ## those 10 names are data frames, and BinIndex is common to NROWs (e.g. MODISA)
#' ## and the rest are the same size, BinList in the bin_num and weights etc
#' ## and the Rrs/angstromg/aot etc are the sums and ssq - so really it's only one data frame
#' ## from the hypertidy perspective
#' [1] "BinIndex"     "BinList"      "Rrs_412"      "Rrs_443"      "Rrs_490"      "Rrs_510"     
#' [7] "Rrs_555"      "Rrs_670"      "angstrom"     "aot_865"      "binDataDim"   "binDataType" 
#' [13] "binIndexDim"  "binIndexType" "binListDim"   "binListType" 
h5_vars <- function(x) UseMethod("h5_vars")
#' @name h5_vars
#' @export
h5_vars.character <- function(x) {
  handle <- rhdf5::H5Fopen(x)
  on.exit(rhdf5::H5Fclose(handle), add = TRUE)
  h5_vars(handle)
}
##  to make this a single front-end with ncmeta / tidync (or hypertidy eventually)
## this implies a high-level cascade, where each kind of open is attempted
##  and finally a successful open passes this class file handle to the generic
## (it's not a linear cascade, user will need to be able to dispatchepxlicitly
## to the the different providers - for instance, they want to use rhdf5 for
## a standard mapped L3 image, rather than have it work from ncdf4 or rgdal etc)
## nc_vars.H5IdComponent <- function(x) {}
#' @name h5_vars
#' @export
h5_vars.H5IdComponent <- function(x) {
  rhdf5::h5ls(x)
}