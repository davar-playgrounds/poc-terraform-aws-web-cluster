VERSION=${1:-0.0.0}
NUM_INSTANCES=${2:-3}
TARGET_ENV=${3:-DEV}
docker build -t phiro/poc-builder:"${VERSION}" \
  -f Dockerfile \
  --build-arg AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY_ID" \
  --build-arg AWS_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY" \
  --build-arg VERSION="$VERSION" \
  --build-arg NUM_INSTANCES="$NUM_INSTANCES" \
  --build-arg TARGET_ENV="$TARGET_ENV" \
  ../.. > results.txt
cat results.txt | awk 'BEGIN{found=0;}/## START ##/{if(!found){found=1;$0=substr($0,index($0, "## START ##")+11);}}/## END ##/{if(found){found=2;$0=substr($0,0,index($0,"### END ##")-1);}}{ if(found){print;if(found==2)found=0;}}' > terraform.tfstate
