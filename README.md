# spm

* **Version:** 0.1-0
* **Status:** [![Build Status](https://travis-ci.org/wrathematics/spm.png)](https://travis-ci.org/wrathematics/spm)
* **License:** [BSD 2-Clause](http://opensource.org/licenses/BSD-2-Clause)
* **Author:** Drew Schmidt


**spm** is a single precision (aka float) matrix framework for R.  Base R has no single precision type.  Its "numeric" vectors/matrices are double precision.  Floats have half the precision of double precision data, for a performance vs accuracy tradeoff.  A matrix of floats should use about half as much memory as a matrix of doubles, and your favorite matrix routines will generally compute about twice as fast on them as well.  However, the results will not be as accurate, and are much more prone to roundoff error/mass cancellation issues.  Statisticians have a habit of over-hyping the dangers of roundoff error in this author's opinion.  If your data is [well-conditioned](https://en.wikipedia.org/wiki/Condition_number), then using floats is "probably" fine for many applications.  

Type promotion always defaults to the higher precision.  So if a float matrix operates with an integer matrix, the integer matrix will be cast to a float first. Likewise if a float matrix operates with a double matrix, the float will be cast to a double first.  Similarly, any float matrix that is explicitly converted to a "regular" matrix will be stored in double precision.



## Installation

The package requires the single precision BLAS/LAPACK routines which are not included in the default `libRblas` and `libRlapack` shipped from CRAN.  If your BLAS/LAPACK libraries do not have what is needed, then they will be built (note that a fortran compiler is required in this case).  However, these can take a very long time to compile, and will have much worse performance than optimized libraries.  The topic of which BLAS/LAPACK to use and how to use them has been written about many times.  If this is the first you're hearing of it, I would recommend you use [Microsoft R Open](https://mran.microsoft.com/open/).

<!-- To install the R package, run:

```r
install.package("spm")
``` -->

The development version is maintained on GitHub, and can easily be installed by any of the packages that offer installations from GitHub:

```r
### Pick your preference
devtools::install_github("wrathematics/spm")
ghit::install_github("wrathematics/spm")
remotes::install_github("wrathematics/spm")
```



## Methods

The goal of the package is to recreate the matrix algebra facilities of the base package, but with floats.  So we do not include higher statistical methods (like `lm()` and `prcomp()`), or more "basic" methods like sorts and so on.

Is something missing?  Please [let me know](https://github.com/wrathematics/spm/issues).

### Basic utilities

| Method | Status |
|---|---|
| `[` | positive integer indices for `i` and `j` only |
| `diag()` | done |
| `is.spm()` | done |
| `nrow()`, `ncol()`, `dim()` | done |
| `is.na()` | done |
| `na.omit()`, `na.exclude()` | done |

### Casters

| Method | Status |
|---|---|
| `mat2spm()` / `fl()` | done |
| `spm2mat()` / `dbl()` | done |

### Linear algebra

| Method | Status |
|---|---|
| `chol()` | done |
| `crossprod()` and `tcrossprod()` | done | 
| `isSymmetric()` | done |
| `%*%` | done |
| `object.size()` | done |
| `print()` | done |
| `solve()` | done | 
| `t()` | done |
| `La.svd()` and `svd()` | done |

### Math functions

| Method | Status |
|---|---|
| `exp()`, `exp1m()` | done |
| `log()`, `log10()`, `log2()` | done |
| `sin()`, `cos()`, `tan()`, `asin()`, `acos()`, `atan()` | done |
| `sinh()`, `cosh()`, `tanh()`, `asinh()`, `acosh()`, `atanh()` | done |
| `abs()`, `sqrt()` | done |
| `gamma()`, `lgamma()` | done |
| `is.finite()`, `is.infinite()`, `is.nan()` | done |



### In progress and Future Plans

Nearing completion: 

* The QR family of functions (`qr()`, `qr.Q()`, ...)
* `eigen()`

Future roadmap:

* `is.na()`, etc.
* Binary arithmetic (`+`, `-`, ...)
* `cbind()` and `rbind()`
* `chol2inv()`
* Accept more general `i`/`j` in `[`
* `norm()`, `rcond()`, and `kappa()`
* Basic random generation interface.
* A (low-level) reader, like `scan()`.
* An "in-place" API.

Maybe eventually:

* Support single complex.
* `fft()`



## Package Use

The memory consumption is roughly half when using floats:

```r
library(spm)

m = 10000
n = 2500

memuse::howbig(m, n)
## 190.735 MiB

x = matrix(rnorm(m*n), m, n)
object.size(x)
## 200000200 bytes

s = fl(x)
object.size(s)
## 100000024 bytes
```

And the runtime performance is roughly 2x better:

```r
library(rbenchmark)
cols <- cols <- c("test", "replications", "elapsed", "relative")
reps <- 5

benchmark(crossprod(x), crossprod(s), replications=reps, columns=cols)
##           test replications elapsed relative
## 2 crossprod(s)            5   3.185    1.000
## 1 crossprod(x)            5   7.163    2.249
```

However, the accuracy is better in the double precision version:

```r
cpx = crossprod(x)
cps = crossprod(s)
all.equal(cpx, dbl(cps))
## [1] "Mean relative difference: 3.478718e-07"
```

That difference is fairly small, but for some operations/data could be significantly larger.  
