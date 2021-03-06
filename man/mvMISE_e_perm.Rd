% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mvMISE_e_perm.r
\name{mvMISE_e_perm}
\alias{mvMISE_e_perm}
\title{A function to obtain permutation-based p-values for fixed effects estimates in mvMISE_e}
\usage{
mvMISE_e_perm(nperm = 100, nnodes = 2, Y, X, id, Zidx = 1, maxIter = 100, tol = 0.001, 
    lambda = 0.05, cov_miss = NULL, miss_y = TRUE, sigma_diff = FALSE)
}
\arguments{
\item{nperm}{the number of permutations.}

\item{nnodes}{the number of nodes that will be used in parallel for permutations.}

\item{Y}{an outcome matrix. Each row is a sample, and each column is an outcome variable, with potential missing values (NAs).}

\item{X}{a covariate matrix. Each row is a sample, and each column is a covariate. The covariates can be common among all of the outcomes (e.g., age, gender) or outcome-specific.
If a covariate is specific for the k-th outcome, one may set all the values corresponding to the other outcomes to be zero. If X is common across outcomes, the row number of X equals 
the row number of Y. Otherwise if X is outcome-specific, the row number of X equals the number of elements in Y, i.e., outcome-specific X is stacked across outcomes within
each cluster. See the Examples for demonstration.}

\item{id}{a vector for cluster/batch index, matching with the rows of Y, and X if it is not outcome specific.}

\item{Zidx}{the column indices of matrix X used as the design matrix of random effects. The default is 1, i.e., a random intercept is included 
if the first column of X is a vector of 1s. If Zidx=c(1,2), then the model would estimate the random intercept and the random effects of the 2nd column in the covariate matrix X.
The random-effects in this model are assumed to be independent.}

\item{maxIter}{the maximum number of iterations for the EM algorithm.}

\item{tol}{the tolerance level for the relative change in the observed-data log-likelihood function.}

\item{lambda}{the tuning parameter for the graphical lasso penalty of the error precision matrix. It can be selected by AIC (an output).}

\item{cov_miss}{the covariate that can be used in the missing-data model. If it is NULL, 
 the missingness is assumed to be independent of the covariates.
Check the Details for the missing-data model.
If it is specified and the covariate is not outcome specific, its length equals the length of id. If it is outcome specific, the outcome-specific covariate is stacked across outcomes within
each cluster.}

\item{miss_y}{logical. If TRUE, the missingness depends on the outcome Y (see the Details). The default is TRUE.
This outcome-dependent missing data pattern was motivated by and was observed in the mass-spectrometry-based quantitative proteomics data.}

\item{sigma_diff}{logical. If TRUE, the sample error variance of the first sample is different from that for the rest of samples within each cluster.
This option is designed and used when analyzing batch-processed proteomics data with the first sample in each cluster/batch being the common reference sample. The default is FALSE.}
}
\value{
The permutation based p-values for testing if fixed-effects (excluding the intercept) are zeros.
}
\description{
This function calls mvMISE_e multiple times by permuting the row index (observations) of the covariate matrix X.
It may take a long time to permute high-dimensional outcomes, but can be run in parallel using multiple nodes.
}
\examples{
\donttest{

data(sim_dat)

pval_perm = mvMISE_e_perm(nperm = 100, Y = sim_dat$Y, X = sim_dat$X, id = sim_dat$id)
}
}
\references{
Jiebiao Wang, Pei Wang, Donald Hedeker, and Lin S. Chen. Using multivariate mixed-effects selection models for analyzing batch-processed proteomics data with non-ignorable missingness. Biostatistics. doi:10.1093/biostatistics/kxy022
}
