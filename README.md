# woRdle

{woRdle}: Enjoying Wordle with R package names.

## Author

* Jaehyun Song, Ph.D.
* Associate Professor in [Faculty of Informatics](https://www.kansai-u.ac.jp/Fc_inf/), [Kansai University](https://www.kansai-u.ac.jp/ja/?stt_lang=ja)
* <song@kansai-u.ac.jp>
* <https://www.jaysong.net>

## Installation

```r
# If you have {remotes},
remotes::install_github("JaehyunSong/woRdle")
# If you have {devtools},
devtools::install_github("JaehyunSong/woRdle")
# If you have {pacman},
pacman::p_install_gh("JaehyunSong/woRdle")
```

## Enjoying Wordle!

```r
library(woRdle)
wordle()
```

## Arguments

A function `wordle()` has two arguments---`answer` and `strict`.

* `answer`: `"installed"` (default), `"cran"`, or any five character.
   * `"installed"`: A pacakge list is obtained from your PC.
   * `"cran"`: A package list is obtained from CRAN.
   * any five character: You can set any answer with five characters.
* `strict`: a logical value---`TRUE` or `FALSE` (default).
   * If `TRUE`, a guess not in package list is not applicable.
