#!/usr/bin/env bash

VERSION=${1:-0.0.0}
ENV_TARGET=${2:-DEV}
BUILD_NEW=${3:-true}
NUMBER_OF_INSTANCES=${4:-3}

cd image-builder
if [[ "${BUILD_NEW}" ==  "true" ]]; then
  bash build-release.sh ${VERSION} 2>&1 | tee output.txt
  tail -3 output.txt | head -3 | awk 'match($0, /ami-.*/) { print substr($0, RSTART, RLENGTH) }' >  ami.txt
else
  if [ ! -f ./ami.txt ];then
    echo "You need to build first to get an ami target"
    exit 1
  fi
fi
AMI=$(cat ./ami.txt)
cd -
if [[ "DEV" == "${ENV_TARGET}" ]]; then
  echo "DEV AMI is $AMI"
  cd ../infra/non-prod/dev
  terraform init
  terraform plan -var deploy_image_website=${AMI} -var release_version=${VERSION} -var number_of_instances=${NUMBER_OF_INSTANCES} -out env.plan
  terraform apply env.plan
elif [[ "UAT" == "${ENV_TARGET}" ]]; then
  echo "UAT AMI is $AMI"
  cd ../infra/non-prod/uat
  terraform init
  terraform plan -var deploy_image_website=${AMI} -var release_version=${VERSION} -var number_of_instances=${NUMBER_OF_INSTANCES} -out env.plan
  terraform apply env.plan
elif [[ "PROD" == "${ENV_TARGET}" ]]; then
  echo "PROD AMI is $AMI"
  cd ../infra/prod
  terraform init
  terraform plan -var deploy_image_website=${AMI} -var release_version=${VERSION} -var number_of_instances=${NUMBER_OF_INSTANCES} -out env.plan
  terraform apply env.plan
else
  echo "${ENV_TARGET} is not known, will do nothing. Valid envs are DEV|UAT|PROD"
fi
cd -