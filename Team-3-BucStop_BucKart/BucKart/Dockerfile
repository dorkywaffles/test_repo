FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

# Fix: Use correct relative path for the .csproj file
COPY ["BucKart.csproj", "./"]

RUN dotnet restore "BucKart.csproj"
COPY . .
WORKDIR "/src"
RUN dotnet build "BucKart.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "BucKart.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "BucKart.dll"]
