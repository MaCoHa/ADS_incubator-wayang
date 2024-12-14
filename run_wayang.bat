@echo off
echo Building Docker image...
docker build --pull --rm -f "DockerFile" -t incubator-wayang:latest "."
if %ERRORLEVEL% neq 0 (
    echo Docker build failed.
    exit /b %ERRORLEVEL%
)

echo Removing existing container...
docker rm wayang-container
if %ERRORLEVEL% neq 0 (
    echo Container removal failed. Proceeding anyway...
)

echo Running new container...
docker run -it --name wayang-container -p 8080:8080 -p 7077:7077 -p 4040:4040 incubator-wayang:latest
if %ERRORLEVEL% neq 0 (
    echo Failed to run container.
    exit /b %ERRORLEVEL%
)

echo All commands executed successfully.
