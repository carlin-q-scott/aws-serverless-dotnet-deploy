FROM amazonlinux

RUN rpm -Uvh https://packages.microsoft.com/config/centos/7/packages-microsoft-prod.rpm
RUN yum install -y dotnet-sdk-3.1

# install AWS SAM CLI
RUN yum install -y python3-pip python3-setuptools
RUN pip3 install aws-sam-cli --upgrade
RUN pip3 install awscli --upgrade

# install misc deployment dependencies
RUN yum install -y zip jq

ENV PATH=$PATH:/root/.dotnet/tools
RUN dotnet tool install -g dotnet-ef
RUN dotnet tool install --global Amazon.Lambda.Tools
