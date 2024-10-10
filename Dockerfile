# Use the official .NET SDK image as a build environment
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env

# Set the working directory
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# Copy the rest of the application code
COPY . ./

# Build the application
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0

WORKDIR /app
COPY --from=build-env /app/out ./

# Expose the port on which the app runs
EXPOSE 80

# Command to run the application
ENTRYPOINT ["dotnet", "YourAppName.dll"]
