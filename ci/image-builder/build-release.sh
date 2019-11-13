VERSION=${1:-0.0.0}
aws-vault exec home -- packer build \
  -var aws_access_key=${AWS_ACCESS_KEY_ID} \
  -var aws_secret_key=${AWS_SECRET_ACCESS_KEY} \
  -var vpc_region=ap-southeast-2 \
  -var version=${VERSION} \
  website-builder.json


