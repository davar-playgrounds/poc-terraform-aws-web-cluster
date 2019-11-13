#!/usr/bin/env bash

VERSION=${1:-0.0.0}
ENV_TARGET=${2:-DEV}
cd image-builder
bash build-release.sh ${VERSION} 2>&1 | tee output.txt
tail -3 output.txt | head -3 | awk 'match($0, /ami-.*/) { print substr($0, RSTART, RLENGTH) }' >  ami.txt
AMI=$(cat ./ami.txt)
cd -
if [[ "DEV" == "${ENV_TARGET}" ]]; then
  echo "DEV AMI is $AMI"
  cd ../infra/non-prod/dev
  terraform plan -var deploy_image_website=${AMI} -var release_version=${VERSION} -out env.plan
  terraform apply env.plan
elif [[ "UAT" == "${ENV_TARGET}" ]]; then
  echo "UAT AMI is $AMI"
  cd ../infra/non-prod/uat
  terraform plan -var deploy_image_website=${AMI} -var release_version=${VERSION} -out env.plan
  terraform apply env.plan
elif [[ "PROD" == "${ENV_TARGET}" ]]; then
  echo "PROD AMI is $AMI"
  cd ../infra/prod
  terraform plan -var deploy_image_website=${AMI} -var release_version=${VERSION} -out env.plan
  terraform apply env.plan
else
  echo "${ENV_TARGET} is not known, will do nothing. Valid envs are DEV|UAT|PROD"
fi
cd -