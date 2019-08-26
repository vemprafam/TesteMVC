

# https://gitlab.com/jelleverheyen/cd-example/container_registry
# https://medium.com/faun/building-a-docker-image-with-gitlab-ci-and-net-core-8f59681a86c4

# https://gitlab.com/help/ci/docker/using_docker_build.md#using-the-gitlab-container-registry



# # Define base image
# FROM microsoft/dotnet:2.2-sdk AS build-env

# # Copy project files
# WORKDIR /source
# COPY ["src/Example.Presentation/Example.Presentation.csproj", "./Example.Presentation/Example.Presentation.csproj"]

# # Restore
# RUN dotnet restore "./Example.Presentation/Example.Presentation.csproj"

# # Copy all source code
# COPY . .

# # Publish
# WORKDIR /source/src
# RUN dotnet publish -c Release -o /publish

# # Runtime
# FROM microsoft/dotnet:2.2-aspnetcore-runtime
# WORKDIR /publish
# COPY --from=build-env /publish .
# ENTRYPOINT ["dotnet", "Example.Presentation.dll"]






FROM microsoft/dotnet:2.2-runtime-alpine

# application, runtime & dependency files should be in different layers
COPY publish/ /app/
COPY app/ /app/

WORKDIR /app
# app(.dll) should be $ASSEMBLY_NAME
ENTRYPOINT ["dotnet", "app.dll"]






# FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build
# WORKDIR /app

# # copy csproj and restore as distinct layers
# COPY dotnetapp/*.csproj ./dotnetapp/
# COPY utils/*.csproj ./utils/
# WORKDIR /app/dotnetapp
# RUN dotnet restore

# # copy and publish app and libraries
# WORKDIR /app/
# COPY dotnetapp/. ./dotnetapp/
# COPY utils/. ./utils/
# WORKDIR /app/dotnetapp
# RUN dotnet publish -c Release -o out


# # test application -- see: dotnet-docker-unit-testing.md
# FROM build AS testrunner
# WORKDIR /app/tests
# COPY tests/. .
# ENTRYPOINT ["dotnet", "test", "--logger:trx"]


# FROM mcr.microsoft.com/dotnet/core/runtime:2.2 AS runtime
# WORKDIR /app
# COPY --from=build /app/dotnetapp/out ./
# ENTRYPOINT ["dotnet", "dotnetapp.dll"]