% Please edit documentation in R/utils-conversion.R
\name{knit_watch}
\alias{knit_watch}
\title{Watch an input file continuously and knit it when it is updated}
\usage{
knit_watch(input, compile = knit, interval = 1, ...)
}
\arguments{
\item{input}{an input file path (or a character vector of mutiple paths of
input files)}

\item{compile}{a function to compile the \code{input} file, e.g. it can be
\code{\link{knit}} or \code{\link{knit2pdf}} depending on the input file
and the output you want}

\item{interval}{a time interval to pause in each cycle of the infinite loop}

\item{...}{other arguments to be passed to the \code{compile} function}
}
\description{
Check the modification time of an input file continously in an infinite loop.
Whenever the time indicates the file has been modified, call a function to
recompile the input file.
}
\details{
This is actually a general function not necessarily restricted to
applications in \pkg{knitr}. You may specify any \code{compile} function to
process the \code{input} file. To stop the infinite loop, press the
\samp{Escape} key or \samp{Ctrl + C} (depending on your editing environment
and operating system).
}
\examples{
# knit_watch('foo.Rnw', knit2pdf)

# knit_watch('foo.Rmd', rmarkdown::render)
}
