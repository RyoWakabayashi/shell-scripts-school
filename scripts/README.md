# シェルスクリプト基礎

## 基本コマンド

### echo

文字を表示する

```bash
echo "Hello"
```

### 環境変数

- export

  環境変数に値を設定する

  ```bash
  export NAME="John"
  ```

  同じターミナル内で有効

  永続的に有効にする場合は `.bashrc` などに記述する

- printenv

  環境変数を表示する

  ```bash
  printenv NAME
  ```

- 変数展開

  `$<変数名>` もしくは `${<変数名>}` で変数を展開する

  ```bash
  echo $NAME
  echo "Hello, ${NAME}"
  ```

### ファイル操作

- pwd

  カレントディレクトリーを表示する

- cd

  カレントディレクトリーを移動する

  `cd` だけでホームディレクトリー `~` = `/home/<ユーザー名>` に移動する

  `.` がカレントディレクトリー

  `..` が親ディレクトリー

- ls

  ファイル一覧を表示する

  `ls -al` で非表示ファイルも含めてすべてを一覧表示する

- which

  実行コマンドのフルパスを取得する

  ```bash
  which python
  ```

- cp

  コピー

  `cp -r` でディレクトリー全体をコピーする

- mv

  移動

  リネームにも使用する

- rm

  削除

  `rm -r` でディレクトリー全体を削除する

- chmod

  パーミッション変更

  `chmod +x` で実行可能にする

- chown

  所有者変更

- touch

  ファイル作成

- mkdir

  ディレクトリー作成

  `mkdir -p` で途中のパスも含めてディレクトリーを作成する

- rmdir

  ディレクトリー削除

- find

  ファイルを検索する

  `-type f` でファイルのみを検索する

  `-type d` でディレクトリーのみを検索する

  `-name` でファイル名のパターン一致で検索する

  ```bash
  find . -name "*.txt"
  ```

  `-i` で大文字小文字を区別しない

  ```bash
  find . -iname "*.txt"
  ```

### テキスト操作

- cat

  ファイル全体を表示する

- less

  ファイルの一部を表示する

- head

  ファイルの先頭を表示する

  `head -n` で行数を指定する

- tail

  ファイルの末尾を表示する

  `tail -n` で行数を指定する

  `tail -f` で更新中のファイル末尾を表示し続ける

- grep

  テキストを検索する

  `-r` でディレクトリー内を検索する

  `-i` で大文字小文字を区別しない

- sed

  テキストの一部を置換する

- sort

  テキストを並べ替える

  ```bash
  sort files/test_001.txt
  ```

  ```bash
  sort -r files/test_001.txt
  ```

- cut

  テキストを分割する

  ```bash
  cut -d "," -f 1 files/test_001.txt
  ```

- awk

  テキストの列を操作する

  `-F [<区切り文字>]` で区切り文字を指定する（デフォルトは半角スペース）

  以下のように指定することで、 1 列目の値が `003` である行の 2 列目、 3 列目を標示する

  ```bash
  awk \
    -F '[,]' \
    '$1 == "003" {print $2,$3}' \
    files/test_001.txt
  ```

## コマンドの接続

- `\`

  改行してもコマンドを継続する

- `;`

  同一行に複数のコマンドを記述する

- `>`

  コマンドの結果をファイルに上書きする

- `>>`

  コマンドの結果をファイルに追記する

- `|`

  コマンドの結果を次のコマンドに渡す

- `&&`

  前のコマンドが成功した場合に次のコマンドを実行する

- `||`

  前のコマンドが失敗した場合に次のコマンドを実行する

- コマンド展開

  バッククォートで囲まれた部分をコマンドとして実行する

  ```bash
  export LOCAL_IP=`hostname -i`
  ```

  `$()` で囲まれた部分をコマンドとして実行する

  ```bash
  export LOCAL_IP=$(hostname -i)
  ```

## メンテナンス用コマンド

### 使用状況

- top

  メモリー、CPU、ネットワークの使用状況を表示する

- free

  メモリーの使用状況を表示する

- df

  ディスク使用状況を表示する

  `-h` で人が見やすい単位で表示する

- ps

  プロセス一覧を表示する

- kill

  プロセスを強制終了する

- shutdown

  ローカルマシンを終了する

### ネットワーク

- ifconfig

  ネットワーク設定を表示する

- hostname

  ローカルマシンのホスト名を表示する

  `hostname -i` で IP アドレスを表示する

- ping

  疎通確認する

- nslookup

  DNSレコードを表示する

  ```bash
  nslookup www.google.com
  ```

- dig

  DNSレコードを表示する

  nslookup よりも詳細

  ```bash
  dig www.google.com
  ```

- curl

  Web 上のリソースにアクセスする

  API を呼び出したりする際に使用する

  お試し用 API を呼んでみる

  <https://httpbin.org/#/>

  ```bash
  curl "https://httpbin.org/get?foo=bar"
  ```

  `-X` でメソッド（省略時は GET）を指定する

  `-H` でヘッダーを指定する

  `-d` でデータを指定する

  ```bash
  curl -X POST \
    -H "Content-Type: application/json" \
    -d @files/dummy.json \
    "https://httpbin.org/post"
  ```

  ```bash
  curl -X PUT \
    -H "Content-Type: application/json" \
    -d @files/dummy.json \
    "https://httpbin.org/put"
  ```

- wget

  Web 上のリソースにアクセスする

  ファイルをダウンロードする際に使用する

  `-O` でダウンロード先のファイル名を指定する

  ```bash
  wget \
    "https://www.google.com/favicon.ico" \
    -O favicon.ico
  ```

### パッケージ管理

- apt

  `apt update` でパッケージリストを更新する

  `apt install` でパッケージをインストールする

  `apt upgrade` でパッケージをアップグレードする

  `apt show` でパッケージの詳細を表示する

## ユーザー切替

- whoami

  今操作しているユーザー名を表示する

- su

  別のユーザーに切り替える

- sudo

  ルートユーザーとして実行する

  `-e` で環境変数を引き継ぐ

- exit

  ログアウトする

## WSL 用コマンド

- wslvar

  Windows 上の環境変数を取得する

  ```bash
  wslvar USERPROFILE
  ```

- wslpath

  Windows 上のパスを WSL 上のパスに変換する

- code

  VSCode を開く

## Hello World

```bash
#!/bin/bash

set -euo pipefail

readonly ME=${0##*/}

display_usage() {

    cat <<EOE

    Hello World!

    構文: ./${ME}

EOE

    exit

}

say_hello() {

    echo "Hello World!"

}

main() {

    while getopts h opt; do
        case $opt in
            h)
                display_usage
            ;;
            \?)
                whoopsie "Invalid option!"
            ;;
        esac
    done

    say_hello

}

whoopsie() {

    local message=$1

    echo "${message} Aborting..."
    exit 192

}

main "$@"

exit 0
```

### シバン

Shebang

```bash
#!/bin/bash
```

先頭行に記述し、 `#!` に続けて実行する処理系を指定する

シバンを記述することにより、直接ファイルを実行した際、 bash で実行される

- Python の場合 `#!/usr/bin/env python`
- Node.js の場合 `#!/usr/bin/env node`

### シェルの設定

```bash
set -euo pipefail
```

`set` コマンドでシェルの設定を変更する

エラー発生時に処理を続行しないようにしている

- `-e` オプション: エラー時に処理を中断する
- `-u` オプション: 変数が未定義時に処理を中断する
- `-o pipefail` オプション: パイプラインの入力側で失敗した場合に処理を中断する

### スクリプトファイル名の取得

```bash
readonly ME=${0##*/}
```

変数 `0` にスクリプト自身のパスが格納されている

`${0}` だと変数を展開してフルパスがそのまま取得できる

`#` や `%` でパターンマッチングした文字を取り除くことができる

- `${<変数名>#<パターン>}` : 変数内のパターンに前方最短一致の文字列を取り除く
- `${<変数名>##<パターン>}` : 変数内のパターンに前方最長一致の文字列を取り除くる
- `${<変数名>%<パターン>}` : 変数内のパターンに後方最短一致の文字列を取り除く
- `${<変数名>%%<パターン>}` : 変数内のパターンに後方最長一致の文字列を取り除く

`0` が `/path/to/script.sh` の場合

- `${0}` は `/path/to/script.sh`
- `${0#*/}` は `to/script.sh`
- `${0##*/}` は `script.sh`
- `${0%/*}` は `/path/to`

したがって、 `${0##*/}` でスクリプト名を取得できる

`readonly` によって、変数を定義した後に変更できないようにする

### 使用方法の表示

スクリプトの使用方法を表示する関数

```bash
display_usage() {

    cat <<EOE

    Hello World!

    構文: ./${ME}

EOE

    exit

}
```

以下のようにして関数を定義する

```bash
<関数名> () {

  <関数の処理内容>

  exit
}
```

ヒアドキュメントによって複数行出力できる

ヒアドキュメントの構文

```bash
cat <<任意の文字列
出力したい文字列
任意の文字列
```

- 単一行毎に出力する場合

  ```bash
  echo ""
  echo "    Hello World!"
  echo ""
  echo "    構文: ./${ME}"
  echo ""
  ```

- ヒアドキュメントを利用した場合

  ```bash
  cat <<EOE

      Hello World!

      構文: ./${ME}

  EOE
  ```

### 処理本体

処理本体を関数として定義する

```bash
say_hello() {

    echo "Hello World!"

}
```

### メイン関数

処理全体の流れをメイン関数に定義する

```bash
main() {

    while getopts h opt; do
        case $opt in
            h)
                display_usage
            ;;
            \?)
                whoopsie "Invalid option!"
            ;;
        esac
    done

    say_hello

}
```

`getopts` コマンドで引数を解析する

上記のように記述することで `-h` が指定されれば `display_usage` を実行し、
それ以外が指定された場合は `whoopsie "Invalid option!"` を実行する

いずれにも該当しない場合、 `say_hello` を実行する

`<関数名> <引数1> <引数2> ...` というようにして関数を呼び出すことができる

### 例外処理

想定される例外処理を whoopsie 関数で定義する

```bash
whoopsie() {

    local message=$1

    echo "${message} Aborting..."
    exit 192

}
```

`local` で関数内のみで参照される変数を定義する

`$1` には woopsie 関数の第 1 引数が格納されている

`echo "${message} Aborting..."` によって、引数で与えられたメッセージを表示している

`exit 192` により、 `0` でない戻り値（エラー状態）で処理を終了する

### メイン関数の呼び出し

メイン関数を呼び出します

```bash
main "$@"
```

`$@` にはすべてのコマンドライン引数が格納されている

### 正常終了

終了コード 0 （正常終了）で処理を終了する

```bash
exit 0
```

## 条件分岐

```bash
...
switch() {

    local input=$1

    if [ "${input}" -eq 3 ]; then
        echo "Equal 3"
    elif [ "${input}" -gt 3 ]; then
        echo "Over 3"
    else
        echo "Under 3"
    fi

    set +u
    if [ -n "${NAME}" ]; then
        echo "Hello ${NAME}"
        if [ "${NAME}" = "Tom" ] && [ "${input}" != 3 ]; then
            echo "Good Bye!"
        fi
    fi
    set -u

}

main() {

    local input

    while getopts i:h opt; do
        case $opt in
            h)
                display_usage
            ;;
            i)
                input=$OPTARG
            ;;
            \?)
                whoopsie "Invalid option!"
            ;;
        esac
    done

    if [ -z "${input}" ]; then
        whoopsie "Please set -i <number>"
    fi

    if ! expr "${input}" : "[0-9]*$" >&/dev/null; then
        whoopsie "Please set -i <number>"
    fi

    switch $input

}
...
```

### if 文

```bash
if [ <条件式> ]; then
    <処理>
elif [ <条件式> ]; then
    <処理>
else
    <処理>
fi
```

### 数値比較演算子

| 比較演算子 | 意味 |
|:------------:|:----|
| `-eq` | 両辺が等しい |
| `-ne` | 両辺が等しくない |
| `-gt` | 左辺が右辺より大きい |
| `-ge` | 左辺が右辺以上 |
| `-lt` | 左辺が右辺より小さい |
| `-le` | 左辺が右辺以下 |

### 文字列比較演算子

| 比較演算子 | 意味 |
|:------------:|:----|
| `=` | 両辺が等しい |
| `!=` | 両辺が等しくない |
| `-n` | 引数の値が空でない |
| `-z` | 引数の値が空 |

### 論理演算子

| 演算子 | 意味 |
|:------------:|:----|
| `!` | 否定 |
| `&&` | AND |
| `||` | OR |

### case 文

```bash
case <変数> in
    <パターン>)
        <処理>
    ;;
    <パターン>)
        <処理>
    ;;
    \?)
        <上記以外の場合の処理>
    ;;
esac
```

## ループ

```bash
loop() {

    for VAL in 1 2 3; do
        echo "for step ${VAL}!!!"
    done

    # shellcheck disable=SC2044
    for FILE in $(find ./files -type f -name '*.txt'); do
        echo "${FILE##*/}"
    done

    local count=1

    while [ $count -lt 5 ]; do
        echo "while step ${count}!!!"
        count=$((count+1))
    done

}
```

### for 文

```bash
for <変数> in <配列>; do
    <処理>
done
```

### while 文

```bash
while [ <継続条件> ]; do
    <処理>
done
```

## find xargs による一括処理

検索結果の各ファイルに対して一括処理を行う

```bash
find ./files \
  -type f \
  -iname '*.txt' \
  -print0 \
  | xargs -0 \
    -I {} \
    head -n 1 {}
```

`-print0` によって find の出力結果の区切り文字を Null 文字にする
（ファイル名に含まれるスペースに対処するため）

`xargs` は配列で与えられた引数をコマンドに渡す

`-0` で配列の区切り文字を Null 文字としてパースする

`-I <任意の文字列>` でコマンド内で使用する変数名を指定する

## jq によるデータ解析

[jq] は JSON を解析するためのコマンド

- jq を使わない場合

  ```bash
  cat "files/dummy.json"
  ```

- jq を使う場合

  ```bash
  cat "files/dummy.json" | jq
  ```

### データ抽出

`.<項目名>` で指定した項目の値を抽出する

`[]` で配列の各値を抽出する

`[<インデックス>]` で配列の指定したインデックスの値を抽出する

`select( <条件式> )` で条件を満たすレコードを抽出する

```bash
cat "files/dummy.json" \
  | jq ".employees[]" \
  | jq "select( .salary >= 2500 )" \
  | jq "{name: .name, salary: .salary, main_language: .languages[0]}"
```

### データ集計

- 件数

  ```bash
  cat "files/dummy.json" \
    | jq ".employees | length"
  ```

- 最大値

  ```bash
  cat "files/dummy.json" \
    | jq ".employees[].salary" \
    | jq -s "max"
  ```

- 最小値

  ```bash
  cat "files/dummy.json" \
    | jq ".employees[].salary" \
    | jq -s "min"
  ```

- 合計

  ```bash
  cat "files/dummy.json" \
    | jq ".employees[].salary" \
    | jq -s "add"
  ```

- 平均

  ```bash
  cat "files/dummy.json" \
    | jq ".employees[].salary" \
    | jq -s "add/length"
  ```

- 最大のレコード

  ```bash
  cat "files/dummy.json" \
    | jq ".employees" \
    | jq "max_by(.salary)"
  ```

- グループ毎の最大のレコード

  ```bash
  cat "files/dummy.json" \
    | jq ".employees" \
    | jq "group_by(.address.state)" \
    | jq "map(max_by(.salary))"
  ```

- グループ毎の平均

  ```bash
  cat "files/dummy.json" \
    | jq ".employees" \
    | jq "group_by(.address.state)" \
    | jq "map({ state: .[0].address.state, avg_salary: ([.[].salary] | add/length) })"
  ```

### ソート

```bash
cat "files/dummy.json" \
  | jq ".employees[]" \
  | jq -s "sort_by(.salary)"
```

### JSON を CSV に変換

```bash
echo \
  '"name","age","main_languages","salary","state"' \
  > "files/dummy.csv" \
  && cat "files/dummy.json" \
    | jq ".employees[]" \
    | jq "[.name, .age, .languages[0], .salary, .address.state]" \
    | jq -r "@csv" >> "files/dummy.csv"
```

## curl と jq による API 呼び出し

curl の結果を jq にパイプすることで、 JSON を解析することができる

```bash
curl -X POST \
  -H "Content-Type: application/json" \
  -d @files/dummy.json \
  "https://httpbin.org/post" \
  | jq ".json.employees[0]"
```

## Docker におけるシェルの利用

Dockerfile 内では `RUN` コマンドを使用してシェルを実行する

次のコマンドでは日本語を標示できるようにしている

`apt-get install` に `-y` を指定して、対話形式をキャンセルしている

Dockerfile ではすべての処理が自動的に実行できるようにしなければならない

```bash
RUN apt-get update -q && \
    apt-get install --no-install-recommends -y language-pack-ja && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    update-locale LANG=ja_JP.UTF8
```

Docker を活用するためには、シェルを習得していなければならない

[jq]: [https://stedolan.github.io/jq/]
