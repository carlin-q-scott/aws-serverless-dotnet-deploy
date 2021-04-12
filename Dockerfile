FROM amazonlinux

RUN sudo rpm -Uvh https://packages.microsoft.com/config/centos/7/packages-microsoft-prod.rpm
RUN sudo yum install dotnet-sdk-3.1

RUN dotnet tool install --global Amazon.Lambda.Tools --version 5.1.0