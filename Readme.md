# VRChat用yt-dlp向けGoogleIPv6ブロッカー

## これは何

VRChat付属のyt-dlp.exeがIPv6接続を使わないようにWindowsファイアーウォールを設定するツールです。
Google(AS15169)が使用するIPv6レンジのIPアドレスをすべてブロックします。

## 実行方法

`main.ps1`を右クリックして管理者として実行するだけです。
ファイアウォールのルールがない場合は新規作成され、すでに存在する場合はブロックの有効、無効が切り替わります

Windowsの設定によっては実行ポリシーの関係で実行できません。
以下のコマンドを管理者権限として実行してください

`Set-ExecutionPolicy RemoteSigned -Scope CurrentUser`
