FROM microsoft/dotnet:2.2-runtime-alpine

# application, runtime & dependency files should be in different layers
COPY publish/ /app/
COPY app/ /app/

WORKDIR /app
# app(.dll) should be $ASSEMBLY_NAME
ENTRYPOINT ["dotnet", "app.dll"]

