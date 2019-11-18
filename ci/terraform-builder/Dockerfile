FROM hashicorp/terraform:0.12.15
RUN terraform --version
RUN mkdir /src
COPY . /src
RUN ls -l /src
# Add aws keys
# Add env settings and pass ami