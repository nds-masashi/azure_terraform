・devcontainer.jsonでazure cliインストール
	"name": "Python 3",
	// Or use a Dockerfile or Docker Compose file. More info: https://containers.dev/guide/dockerfile
	"image": "mcr.microsoft.com/devcontainers/python:1-3.12-bullseye",
	"features": {
		"ghcr.io/devcontainers/features/aws-cli:1": {},
		"azure-cli": "latest"
	}

・Terraformをインストール
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
terraform init
#構文チェック
terraform validate
#デプロイ構成の確認
terraform plan
#デプロイ
terraform apply
#削除
terraform destroy