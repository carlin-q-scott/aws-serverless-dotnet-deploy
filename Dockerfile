FROM amazonlinux

# install dotnet core
RUN rpm -Uvh https://packages.microsoft.com/config/centos/7/packages-microsoft-prod.rpm
RUN yum install -y dotnet-sdk-3.1

# install dotnet cli tools
ENV PATH=$PATH:/root/.dotnet/tools
RUN dotnet tool install -g dotnet-ef --version 6.0.0
RUN dotnet tool install -g Amazon.Lambda.Tools --version 5.2.0

# install misc deployment dependencies
RUN yum install -y zip jq

# install AWS SAM CLI
RUN yum install -y python3-pip python3-setuptools
RUN pip3 install awscli==1.22.19 --upgrade
RUN pip3 install aws-sam-cli==1.36.0 --upgrade
