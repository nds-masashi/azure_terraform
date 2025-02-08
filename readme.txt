
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