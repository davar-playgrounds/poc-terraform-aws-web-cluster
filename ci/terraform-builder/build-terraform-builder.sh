VERSION=${1:-0.0.0}
docker build -t phiro/poc-builder:${VERSION} -f Dockerfile ../..
