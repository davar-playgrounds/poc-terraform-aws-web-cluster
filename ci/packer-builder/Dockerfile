FROM hashicorp/packer:1.4.4
ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ARG VERSION
ENV AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY_ID"
ENV AWS_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY"
ENV VERSION=$VERSION
COPY . /src
WORKDIR /src/ci/image-builder
RUN   packer build \
      -var aws_access_key="$AWS_ACCESS_KEY_ID" \
      -var aws_secret_key="$AWS_SECRET_ACCESS_KEY" \
      -var vpc_region=ap-southeast-2 \
      -var version="$VERSION" \
      website-builder.json
