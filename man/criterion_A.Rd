% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/criterion_A.R
\name{criterion_A}
\alias{criterion_A}
\title{Tests against KBA criteria for A:Threatened Biodiversity}
\usage{
criterion_A(x)
}
\arguments{
\item{x}{Object of class sf and data frame with all relevant information to
apply KBA criterion A.}
}
\value{
x with a new column Criterion_A1.
}
\description{
Tests against KBA criteria for A:Threatened Biodiversity
}
\examples{

df<- data.frame(SCI_NAME= "A",GlobalRedListCategory="", AssessAgainstA1c_A1d="",
          proportion="") \%>\% dplyr::left_join(KBAscope::species)

criterion_A(df)


}
