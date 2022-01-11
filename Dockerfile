#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

#FROM mcr.microsoft.com/dotnet/aspnet:3.1 AS base
#WORKDIR /app
#EXPOSE 80
#EXPOSE 443
#
#FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build
#WORKDIR /src
#COPY ["WebCICD.csproj", "."]
#RUN dotnet restore "./WebCICD.csproj"
#COPY . .
#WORKDIR "/src/."
#RUN dotnet build "WebCICD.csproj" -c Release -o /app/build
#
#FROM build AS publish
#RUN dotnet publish "WebCICD.csproj" -c Release -o /app/publish
#
#FROM base AS final
#WORKDIR /app
#COPY --from=publish /app/publish .
#ENTRYPOINT ["dotnet", "WebCICD.dll"]


FROM mcr.microsoft.com/dotnet/aspnet:3.1 AS base
WORKDIR /app

COPY *.csproj .

RUN dotnet publish --no-restore -c Release -o out

FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build
WORKDIR /app
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "WebCICD.dll"]