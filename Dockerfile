FROM mcr.microsoft.com/dotnet/sdk:3.1

RUN apt-get -o Acquire::Max-FutureTime=86400 update
RUN apt-get install -y apt-utils
RUN apt-get install -y build-essential
RUN apt-get remove -y python
RUN apt-get -y autoremove
ENV LANG="en_US.UTF-8" LC_COLLATE="en_US.UTF-8"
RUN apt-get install -y python3-pip python3-setuptools

RUN pip3 install aws-sam-cli --upgrade
RUN pip3 install awscli --upgrade

RUN apt-get install -y zip jq

RUN apt-get remove -y build-essential apt-utils
RUN apt-get autoremove -y
RUN rm -rf /var/lib/apt/lists/*

ENV PATH=$PATH:/root/.dotnet/tools
RUN dotnet tool install -g --version 3.1 dotnet-ef
RUN dotnet tool install -g --version 4.3 amazon.lambda.tools
