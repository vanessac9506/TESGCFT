FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /app

# Copia csproj (projeto) e restaura as dependências e as ferramentas do projeto
COPY *.csproj ./
RUN dotnet restore SGCFT.csproj

# Compila o aplicativo, lê suas dependências especificadas no arquivo de projeto
# e publica o conjunto de arquivos resultantes em um diretório
COPY . ./
RUN dotnet publish SGCFT.csproj -c Release -o out

# Contrói a imagem
FROM microsoft/dotnet:2.1-aspnetcore-runtime AS runtime
WORKDIR /app
COPY — from=build /app/out/
ENTRYPOINT [“dotnet”, “SGCFT.dll”]`
