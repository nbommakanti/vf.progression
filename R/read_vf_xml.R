#' Read VF XML
#'
#' @param xml_path
#'
#' @return
#' @export
#' @import xml2
#' @import dplyr
#'
#' @examples
read_vf_xml <- function(xml_path) {

    vf <- xml2::read_xml(xml_path)

    id <- c("PATIENT_ID", "BIRTH_DATE", "VISIT_DATE", "EXAM_TIME",
            "MD", "PSD")
    out <- vector("list", length(id))
    for (i in seq_along(id)) {
        out[[i]] <- vf %>%
            xml_find_first(paste0("//", id[[i]])) %>%
            xml_text()
    }
    names(out) <- id
    id <- data.frame(out, stringsAsFactors = FALSE)
    id$MD <- as.numeric(id$MD)
    id$PSD <- as.numeric(id$PSD)


    vars <- vf %>%
        xml_find_first("//THRESHOLD_XY_LOCATION") %>%
        xml_children() %>%
        xml_name()

    out <- vector("list", length(vars))
    for (i in seq_along(vars)) {
        out[[i]] <- vf %>%
            xml_find_all(paste0("//THRESHOLD_XY_LOCATION/", vars[[i]])) %>%
            xml_text() %>%
            as.numeric()
    }
    names(out) <- vars
    threshold <- data.frame(out, stringsAsFactors = FALSE)

    vars <- vf %>%
        xml_find_first("//TOTAL_DEV_XY_LOCATION") %>%
        xml_children() %>%
        xml_name()

    out <- vector("list", length(vars))
    for (i in seq_along(vars)) {
        out[[i]] <- vf %>%
            xml_find_all(paste0("//TOTAL_DEV_XY_LOCATION/", vars[[i]])) %>%
            xml_text() %>%
            as.numeric()
    }
    names(out) <- vars
    total_dev <- data.frame(out)

    data <- dplyr::full_join(threshold, total_dev, by = c("X", "Y"))
    data <- cbind(id, data)
    names(data) <- tolower(names(data))

    if (nrow(data) == 54) {
        data <- data %>% mutate(test_type = "24-2")
    } else if (nrow(data) == 68) {
        data <- data %>% mutate(test_type = "10-2")
    } else if (nrow(data) == 76) {
        data <- data %>% mutate(test_type = "30-2")
    } else {
        data <- data %>% mutate(test_type = "unknown")
    }
    data
}
