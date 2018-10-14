#' Title
#'
#' @param xml_paths
#'
#' @return
#' @export
#' @import tidyverse
#'
#' @examples
gather_series_from_xmls <- function(xml_paths) {
    out <- vector("list", length(xml_paths))
    for (i in seq_along(xml_paths)) {
        out[[i]] <- read_vf_xml(xml_paths[[i]])
    }
    data <- bind_rows(out)
    data
}
