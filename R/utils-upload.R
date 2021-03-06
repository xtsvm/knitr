#' Upload an image to imgur.com
#'
#' This function uses the \pkg{RCurl} package to upload a image to
#' \url{imgur.com}, and parses the XML response to a list with \pkg{XML} which
#' contains information about the image in the Imgur website.
#'
#' When the output format from \code{\link{knit}()} is HTML or Markdown, this
#' function can be used to upload local image files to Imgur, e.g. set the
#' package option \code{opts_knit$set(upload.fun = imgur_upload)}, so the output
#' document is completely self-contained, i.e. it does not need external image
#' files any more, and it is ready to be published online.
#' @param file the path to the image file to be uploaded
#' @param key the client id for Imgur (by default uses a client id registered by
#'   Yihui Xie)
#' @return A character string of the link to the image; this string carries an
#'   attribute named \code{XML} which is a list converted from the response XML
#'   file; see Imgur API in the references.
#' @author Yihui Xie, adapted from the \pkg{imguR} package by Aaron Statham
#' @note Please register your own Imgur application to get your client id; you
#'   can certainly use mine, but this id is in the public domain so everyone
#'   has access to all images associated to it.
#' @references Imgur API version 3: \url{http://api.imgur.com/}; a demo:
#'   \url{http://yihui.name/knitr/demo/upload/}
#' @export
#' @examples \dontrun{
#' f = tempfile(fileext = '.png')
#' png(f); plot(rnorm(100), main = R.version.string); dev.off()
#'
#' res = imgur_upload(f)
#' res  # link to original URL of the image
#' attr(res, 'XML')  # all information
#' if (interactive()) browseURL(res)
#'
#' # to use your own key
#' opts_knit$set(upload.fun = function(file) imgur_upload(file, key = 'your imgur key'))
#' }
imgur_upload = function(file, key = '9f3460e67f308f6') {
  if (!is.character(key)) stop('The Imgur API Key must be a character string!')
  res = RCurl::postForm(
    'https://api.imgur.com/3/image.xml', image = RCurl::fileUpload(file),
    .opts = RCurl::curlOptions(httpheader = c(Authorization = paste('Client-ID', key)),
                               cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"))
  )
  res = XML::xmlToList(res)
  if (is.null(res$link)) stop('failed to upload ', file)
  structure(res$link, XML = res)
}
