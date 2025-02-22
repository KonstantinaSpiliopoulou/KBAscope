% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{species}
\alias{species}
\title{Species range maps}
\format{
An object of class \code{sf} (inherits from \code{data.frame}) with 6 rows and 8 columns.
}
\usage{
species
}
\description{
A data set containing imaginary range maps for three example species A, B and C.
Data structure is set out in such way, to simulate the data standards of the IUCN
Red List of Threatened Species. Any similarity to real data from the IUCN Red List
of Threatened Species is a mere coincidence.
}
\details{
The variables (find more details for the variables in the IUCN Red List of Threatened
Species website https://www.iucnredlist.org/) are as follows:

@format  Object of class sf and data frame with 6 rows and 8 variables:\code{ASSESSMENT},
\code{ID_NO}, \code{SCI_NAME}, \code{PRESENCE}, \code{ORIGIN}, \code{SEASONAL},
\code{LEGEND}, \code{geom}
\describe{
\item{ASSESSMENT}{unique id of the assessment of a species}
\item{ID_NO}{unique id of a species}
\item{SCI_NAME}{scientific name of a species}
\item{PRESENCE}{species presence, from 1 (extant) to 6 (presence uncertain)}
\item{ORIGIN}{species origin, from 1 (native) to 6 (assisted colonisation)}
\item{SEASONAL}{species seasonality, from 1 (resident) to 5 (seasonal occurrence uncertain)}
\item{LEGEND}{combinations of the presence, origin and seasonal codes}
\item{geom}{geometry of the polygons}
}
source Generated in QGIS 3.28.2
}
\keyword{datasets}
