% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/SCP-cell_annotation.R
\name{RunScmap}
\alias{RunScmap}
\title{Annotate single cells using scmap.}
\usage{
RunScmap(
  srt_query,
  srt_ref,
  ref_group = NULL,
  method = "scmapCluster",
  n_features = 500,
  threshold = 0.5,
  k = 10,
  query_assay = "RNA",
  ref_assay = "RNA",
  force = FALSE
)
}
\arguments{
\item{force}{}
}
\description{
Annotate single cells using scmap.
}
\examples{
data("panc8_sub")
# Simply convert genes from human to mouse and preprocess the data
genenames <- make.unique(stringr::str_to_title(rownames(panc8_sub)))
panc8_rename <- RenameFeatures(panc8_sub, newnames = genenames)
panc8_rename <- check_srtMerge(panc8_rename, batch = "tech")[["srtMerge"]]

# Annotation
data("pancreas_sub")
pancreas_sub <- Standard_SCP(pancreas_sub)
pancreas_sub <- RunScmap(
  srt_query = pancreas_sub, srt_ref = panc8_rename,
  ref_group = "celltype", method = "scmapCluster"
)
ClassDimPlot(pancreas_sub, group.by = "scmap_annotation")

pancreas_sub <- RunScmap(
  srt_query = pancreas_sub, srt_ref = panc8_rename,
  ref_group = "celltype", method = "scmapCell"
)
ClassDimPlot(pancreas_sub, group.by = "scmap_annotation")

}