# Используйте базовый образ
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app

# Используйте образ SDK для сборки
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Копируем файлы проекта
COPY /WebServiceModule.csproj WebServiceModule/
COPY DataModule/DataModule.csproj DataModule/

# Восстанавливаем зависимости
RUN dotnet restore "WebServiceModule/WebServiceModule.csproj"

# Копируем все файлы
COPY . .

# Сборка проекта
WORKDIR "/src/WebServiceModule"
RUN dotnet build "WebServiceModule.csproj" -c Release -o /app/build

# Публикация приложения
FROM build AS publish
RUN dotnet publish "WebServiceModule.csproj" -c Release -o /app/publish

# Финальный образ
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish/ .
ENTRYPOINT ["dotnet", "WebServiceModule.dll"]