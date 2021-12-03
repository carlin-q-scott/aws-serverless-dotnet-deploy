# AWS Elastic Beanstalk for Dotnet Core

This is a docker image for deploying dotnet core applications to AWS Serverless(SAM)/Lambda. It should be used as part of a Delivery pipeline, such as through GitLab.

## What's Included

* awscli - Python based CLI for interacting with the AWS APIs
* sam - Python based CLI for modifying AWS Serverless Application Modules
* amazon.lambda.tools - dotnet tool for publishing a serverless application or lambda function to AWS
* dotnet-ef - dotnet tool for applying Entity Framework db migrations

As a bonus, this image uses the official Amazon Linux base image used by AWS Lambda. So you can use it to build targeted/optimized binaries and lambda layers.

## Usage

To use this docker image manually outside of a CI system, you need to share your aws credentials and solution folder with the container, like so:

Linux Bash:

```bash
docker run -it --name amazon -v $HOME/.aws:/root/.aws -v $(pwd):/src carlin/aws-serverless-dotnet-deploy bash
```

Windows Powershell:

```powershell
docker run -it --name amazon -v $env:USERPROFILE/.aws:/root/.aws -v $pwd:/src carlin/aws-serverless-dotnet-deploy bash
```

### Publish Optimized Binaries

You can optimize cold start for your lambda function by publishing your csproj with the `--runtime linux-x64` build flag.

```powershell
dotnet publish --configuration "Release" --runtime linux-x64 --self-contained false
```

Note that this build flag is also used to restore nuget packages optimized for linux.

### Lambda Layers

Lambda layers can be used to greatly speed up lambda function boot times, especially for dotnet, as it avoids cold start compilation of binaries for the target platform. They can also be shared between lambda functions, even across your organization's AWS accounts for an extra speed boost; the lambda layer will remain cached as long as it gets used frequently enough to reset the cache expiration.

Use the dotnet lambda publish-layer command from inside the docker container to publish a sharable lambda layer:

```powershell
dotnet lambda publish-layer your-dotnet-layer --layer-type runtime-package-store --s3-bucket arn:aws:s3:::your-bucket --enable-package-optimization true
```
