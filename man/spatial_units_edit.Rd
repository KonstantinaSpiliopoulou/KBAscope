% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/spatial_units_edit.R
\name{spatial_units_edit}
\alias{spatial_units_edit}
\title{Edit spatial units to contain a unique ID column.}
\usage{
spatial_units_edit(x, id = NA)
}
\arguments{
\item{x}{Object of class sf and data frame that represent the spatial
unites data.}

\item{id}{Object of type character indicating the name of the ID column.}
}
\value{
A new ID column, if missing, and removed redundant columns.
}
\description{
Edit spatial units to contain a unique ID column.
}
\examples{

spatial_units_edit(KBAscope::spatial_units,id="id")


}
