# AMI for self-hosted GitHub actions runner (Linux amd64)

Run the following commands:
`packer init .`
`packer validate -var aws_region=ap-northeast-1 -var version=22.04 .`
`export AWS_PROFILE=<AWS_PROFILE_NAME>`
`packer build -var aws_region=ap-northeast-1 -var version=22.04 template.pkr.hcl`


