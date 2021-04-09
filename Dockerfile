FROM amazon/aws-sam-cli-build-image-python3.8

RUN pip3 install aws-sam-cli --upgrade
RUN pip3 install awscli --upgrade
RUN pip3 install aws-lambda-builders --upgrade

# Run: docker run --rm --entrypoint dotnet lambci/lambda:dotnetcore3.1 --info
# Check https://dotnet.microsoft.com/download/dotnet-core/3.1 for versions
ENV DOTNET_ROOT=/var/lang/bin
ENV PATH=/root/.dotnet/tools:$DOTNET_ROOT:$PATH \
    LD_LIBRARY_PATH=/var/lang/lib:$LD_LIBRARY_PATH \
    AWS_EXECUTION_ENV=AWS_Lambda_dotnetcore3.1 \
    DOTNET_SDK_VERSION=3.1.407 \
    DOTNET_CLI_TELEMETRY_OPTOUT=1 \
    NUGET_XMLDOC_MODE=skip
RUN curl -L https://dot.net/v1/dotnet-install.sh | bash -s -- -v $DOTNET_SDK_VERSION -i $DOTNET_ROOT && \
  mkdir /tmp/warmup && \
  cd /tmp/warmup && \
  dotnet new && \
  cd / && \
  rm -rf /tmp/warmup /tmp/NuGetScratch /tmp/.dotnet
