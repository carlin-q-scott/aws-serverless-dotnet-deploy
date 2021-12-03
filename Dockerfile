FROM amazonlinux

# add sources
RUN rpm -Uvh https://packages.microsoft.com/config/centos/7/packages-microsoft-prod.rpm

# install yum packages
RUN yum install -y dotnet-sdk-5.0 zip jq python3-pip python3-setuptools
RUN rm -rf /var/cache/yum

# install dotnet cli tools
ENV PATH=$PATH:/root/.dotnet/tools
RUN dotnet tool install -g --no-cache dotnet-ef --version 6.0.0
RUN dotnet tool install -g --no-cache Amazon.Lambda.Tools --version 5.2.0

# install AWS SAM CLI
RUN pip3 install awscli==1.22.19 aws-sam-cli==1.36.0 --upgrade --no-cache-dir