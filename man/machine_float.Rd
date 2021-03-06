% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/machine.r
\docType{data}
\name{.Machine_float}
\alias{.Machine_float}
\title{Numerical characteristics of the machine for floats.}
\usage{
.Machine
}
\description{
A global variable containing the float (single precision) analogues of much
of the double precision details of \code{.Machine}.
}
\details{
.Machine_float


Values are taken directly from \code{float.h}.
}
\section{Value}{

A list containing:
\itemize{
  \item \code{float.eps} epsilon
  \item \code{float.xmin} smallest non-zero float
  \item \code{float.xmax} largest non-inf float
  \item \code{float.base} radix
  \item \code{float.digits} the number of bits for the sign+significand
  \item \code{float.exponent} number of bits for the exponent
  \item \code{float.min.exp} "largest negative" (smallest) integer for the
      exponent that generates a normalized floating-point number
  \item \code{float.max.exp} largest integer for the
      exponent that generates a normalized floating-point number
}
}

