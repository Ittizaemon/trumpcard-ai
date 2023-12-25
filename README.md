## 動かす上でインストールするもの

- docker
- nvidia driver

## notebooksのフォルダ構成について

- notebooks/models: 学習モデルを保存するディレクトリ
- notebooks/train-data: 学習時に必要なデータを入れるディレクトリ

## メモ

- NUMAを使うために必要なongintrepr.hはpython3.10まででないと存在しない。3.11からはなくなった模様
- 学習に使用する画像データ、csvファイル、modelデータはGoogle Drive からダウンロード
