
・Terraformをインストール
tfenvでインストール
brew install tfenv
tfenv list-remote
tfenv install 1.10.5
tfenv list
tfenv use 1.10.5

https://qiita.com/broccoli07/items/b059487bab0cdc583f26
$ wget https://releases.hashicorp.com/terraform/1.7.3/terraform_1.7.3_linux_amd64.zip
$ unzip terraform_1.7.3_linux_amd64.zip
$ sudo cp terraform /usr/local/bin
$ terraform -v

・Azure接続
az login
az account show
az account list
az account set --subscription "XXXXX"

・Terrformコマンド
envs/dev 配下で以下のコマンド

terraform -v
terraform init
#構文チェック
terraform validate
#デプロイ構成の確認
terraform plan
#デプロイ
terraform apply
#削除
terraform destroy


デプロイ時間
storage 1分ほど
vm 2分ほど

-----
terraform fmt --recursive
terraform init --upgrade
terraform [plan|apply|destroy] -target=module.[モジュール名]
terraform apply -target=module.base

-----
VM一覧 (--all追加すると遅いので要注意)
az vm image list --output table
az vm image list --architecture x64 --publisher MicrosoftWindowsServer --all --output table
az vm image list --architecture x64 --publisher RedHat --output table
az vm image list --architecture x64 --publisher Almalinux --all --output table

-----
https://zenn.dev/gatabutsu/articles/0737b817cda5a6
日本語化し、イメージを作成しておけば
日本語から作成可能
