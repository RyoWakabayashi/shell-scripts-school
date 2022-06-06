# shell-scripts-school

シェルスクリプトの学習用

## 必要な環境

### ビルド環境

macOS 、 Linux もしくは Windows の WSL 上でビルドする

- [asdf]
- [Docker]
- [docker-compose]

### WSL 環境

Windows の WSL にインポートする

[WSL2]

## 編集・ビルド用セットアップ

asdf のプラグインをインストールする

```bash
asdf plugin-add direnv \
  ; asdf plugin-add hadolint \
  ; asdf plugin-add nodejs \
  ; asdf plugin-add python \
  ; asdf plugin-add shellcheck
```

asdf で Python と Node.js をインストールする

```bash
asdf install
```

依存パッケージをインストールする

```bash
npm install \
  && pip install --requirement requirements.txt
```

静的解析を実行する

```bash
pre-commit run --all-files
```

静的解析をコミット時に自動実行する

```bash
pre-commit install
```

## コンテナのビルド

非プロキシー環境で実施する

実行環境用のプロキシ設定を `RUN_ENV_PROXY` 環境変数に設定する

```bash
export RUN_ENV_PROXY=<プロキシサーバー:ポート番号>
```

```bash
docker-compose build
```

## コンテナのエクスポート

コンテナの起動

```bash
docker-compose up -d
```

コンテナのエクスポート

```bash
docker export shell-scripts-school -o shell-scripts-school.tar.gz
```

コンテナの停止・削除

```bash
docker-compose down
```

## コンテナのインポート

以降は WSL を起動する Windows 上の PowerShell ターミナルで実行する

```ps
wsl --import shell-scripts-school $HOME/AppData/shell-scripts-school ./shell-scripts-school.tar.gz
```

コンテナ (WSL のディストリビューション) を削除する場合は以下のコマンドを実行する

入れ替える場合は削除後に再度インポートする

```ps
wsl --unregister shell-scripts-school
```

## WSL の設定

初回導入時、以下に示す ./config/.wslconfig を編集し、ホームディレクトリーにコピーする

```text
localhostForwarding=True # localhost で WSL にアクセスできるようにする
memory=2GB # メモリサイズは環境によって変更する
```

```ps
cp ./config/.wslconfig ~/.wslconfig
```

## WSL の起動

```ps
wsl -d shell-scripts-school
```

[asdf]: https://github.com/asdf-vm/asdf
[docker]: https://www.docker.com/
[docker-compose]: https://docs.docker.jp/compose/toc.html
[wsl2]: https://docs.microsoft.com/ja-jp/windows/wsl/install
