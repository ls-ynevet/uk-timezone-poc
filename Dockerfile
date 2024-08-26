# Use the official .NET Core SDK image to build the application
FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the .csproj file and restore any dependencies (via NuGet)
COPY *.csproj ./
RUN dotnet restore

# Copy the rest of the application code
COPY . ./

# Build the application
RUN dotnet publish -c Release -o out

# Use the official .NET Core runtime image to run the application
FROM mcr.microsoft.com/dotnet/runtime:3.1 AS runtime

# Install libfaketime
RUN apt-get update && apt-get install -y faketime

# Set the working directory in the container
WORKDIR /app

# Copy the compiled application from the build stage
COPY --from=build /app/out ./


# Define the entry point of the application with libfaketime to fake date and time
# Use faketime to run the .NET application
CMD faketime "${FAKE_TIME:-'2023-08-25 10:00:00'}" dotnet UkTimePoc.dll