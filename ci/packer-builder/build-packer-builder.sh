VERSION=${1:-0.0.0}
docker build -t phiro/poc-builder:${VERSION} \
  -f Dockerfile \
  --build-arg AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
  --build-arg AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
  --build-arg VERSION=$VERSION \
  ../..
