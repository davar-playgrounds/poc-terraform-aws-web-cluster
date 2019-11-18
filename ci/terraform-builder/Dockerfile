FROM hashicorp/terraform:0.12.15
RUN terraform --version
RUN mkdir /src
COPY . /src
# Set your parameters
ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ARG VERSION=0.0.0
ARG TARGET_ENV=DEV
ARG NUM_INSTANCES=3
ENV AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY_ID"
ENV AWS_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY"
ENV VERSION=$VERSION
ENV ENV_TARGET=$TARGET_ENV
ENV NUM_INSTANCES=$NUM_INSTANCES
WORKDIR /src/ci
# Copy the packer output to the location it is expected.
RUN cp /src/ci/packer-builder/output.txt /src/ci/image-builder/output.txt
# Note that the AMI will be picked up from the output.txt.
RUN sh pipeline.sh $VERSION $ENV_TARGET false $NUM_INSTANCES
