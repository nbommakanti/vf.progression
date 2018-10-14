#' VF Progression
#'
#' @param xml_paths
#'
#' @return
#' @export
#' @importFrom lubridate as_date interval years
#' @import ggplot2
#'
#' @examples
vf_progression <- function(xml_paths) {

    # Read XML files and aggregate into one data table
    data <- gather_series_from_xmls(xml_paths)

    # Get time in years
    data <- data %>%
        as_tibble() %>%
        mutate(visit_date = lubridate::as_date(visit_date),
               time = lubridate::interval(visit_date[1], visit_date) / lubridate::years(1))

    # Run OSLR for MD vs. Time
    fit <- lm(md ~ time, data = data)
    slope <- fit$coefficients[["time"]]
    intercept <- fit$coefficients[["(Intercept)"]]
    equation <- paste("MD = ", round(intercept, 1),
                      "+", round(slope, 1), "*", "Time")

    ptid <- unique(data$patient_id)

    # Plot result
    data %>%
        ggplot(aes(time, md)) +
        geom_point() +
        geom_smooth(method = "lm", color = "black") +
        labs(title = paste0("MD vs Time for patient: ", ptid),
             subtitle = equation,
             x = "Time (years)", y = "MD (dB)") +
        theme_bw(base_size = 14) +
        theme(plot.title = element_text(face = "bold"))

    # To do: pointwise

    # To do: write data

}
