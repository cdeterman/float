% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/colSums.r
\docType{methods}
\name{colsums}
\alias{colMeans,float32-method}
\alias{colSums,float32-method}
\alias{colsums}
\alias{rowMeans,float32-method}
\alias{rowSums,float32-method}
\title{colSums}
\usage{
\S4method{colSums}{float32}(x, na.rm = FALSE, dims = 1)

\S4method{rowSums}{float32}(x, na.rm = FALSE, dims = 1)

\S4method{colMeans}{float32}(x, na.rm = FALSE, dims = 1)

\S4method{rowMeans}{float32}(x, na.rm = FALSE, dims = 1)
}
\arguments{
\item{x}{A float vector/matrix.}

\item{na.rm}{Should missing values be removed?}

\item{dims}{Ignored. Be honest, you've never even used this argument before, have you?}
}
\value{
A matrix of the same type as the highest precision input.
}
\description{
Row and columns sums/means.
}
\examples{
library(float)

s = flrunif(5, 3)

rowSums(s)
colSums(s)

}

