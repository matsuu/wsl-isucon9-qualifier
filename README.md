# matsuu/wsl-isucon9-qualifier

## これはなに

ISUCON9予選の環境をWSL2上に構築するスクリプトです。

## 構築

PowerShell上で以下を実行します。

```
# ダウンロード
git clone https://github.com/matsuu/wsl-isucon9-qualifier.git

# ディレクトリに移動
cd wsl-isucon9-qualifier

# 一時的にPowerShell実行を許可
Set-ExecutionPolicy RemoteSigned -Scope Process

# 構築スクリプト実行(引数はDistro名、インストールパス)
.\build.ps1 isucon9-qualify .\isucon9-qualify
```

## 実行

```
wsl.exe -d isucon9-qualify
```

### サイト表示確認

https://localhost/

### ベンチマーク実行

```
cd ~isucon/isucari
bin/benchmark
```

## 関連

* [ISUCON9予選問題](https://github.com/isucon/isucon9-qualify)
* [matsuu/wsl-isucon10-qualifier](https://github.com/matsuu/wsl-isucon10-qualifier)

## TODO

* エラー制御
  * 二重実行の防止
* `/etc/resolv.conf` 周りの調整
* PowerShellなんもわからん
