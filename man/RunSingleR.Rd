% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/SCP-cell_annotation.R
\name{RunSingleR}
\alias{RunSingleR}
\title{Annotate single cells using scmap.}
\usage{
RunSingleR(
  srt_query,
  srt_ref,
  query_group = NULL,
  ref_group = NULL,
  genes = "de",
  de.method = "wilcox",
  sd.thresh = 1,
  de.n = NULL,
  aggr.ref = FALSE,
  aggr.args = list(),
  quantile = 0.8,
  fine.tune = TRUE,
  tune.thresh = 0.05,
  prune = TRUE,
  BPPARAM = BiocParallel::bpparam(),
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
pancreas_sub <- RunSingleR(
  srt_query = pancreas_sub, srt_ref = panc8_rename,
  query_group = "Standardclusters", ref_group = "celltype",
)
ClassDimPlot(pancreas_sub, group.by = "singler_annotation")

pancreas_sub <- RunSingleR(
  srt_query = pancreas_sub, srt_ref = panc8_rename,
  query_group = NULL, ref_group = "celltype"
)
ClassDimPlot(pancreas_sub, group.by = "singler_annotation")

}