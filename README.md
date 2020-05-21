## Help
This is a script to parse the output files from http://gs.bs.s.u-tokyo.ac.jp/ to standard newick format.

Newick and OTUList files to be parsed by this script could be downloaded from the results page. If you wish to change the name of proteins, modify the second column in OTUList.

Download parse_GS_newick.R . Start R or R studio from the directory where you put the Newick and OTUList files. Use `setwd` to change the directory if neccessary.

Enter the following commands in R or RStudio:
```r
source("parse_GS_newick.R")

parseGS(newick = "your newick file",OTUList = "your OTUList")
```
  
If no OTUList file was provided, the input files will still be parsed, but without changing the IDs.
Specify the name of parsed file with the "output" argument. If not provided, the input newick file name will be used with a "Parsed-" prefix.  

## 説明
http://gs.bs.s.u-tokyo.ac.jp/ からの出力ファイルを標準のnewick形式に変換するスクリプトです。

このスクリプトで解析されるNewickファイルとOTUListファイルは、結果ページからダウンロードできます。 タンパク質の名前を変更する場合は、OTUListの2列目を変更してください。

パーズしたいファイルのある場所で起動する、もしくは`setwd`を使う、絶対パスを入れるなどしてファイルを指定してください。

RまたはRStudioで次のコマンドを入力してパージングを実行します。

```r
source("parse_GS_newick.R")

parseGS(newick = "your newick file",OTUList = "your OTUList")
```

OTUListファイルが提供されなかった場合でも、入力ファイルは解析されますが、IDは変更されません。

"output"引数を使用して、解析済みファイルの名前を指定します。 指定しない場合、入力newickファイル名は"Parsed-"接頭辞とともに使用されます。

