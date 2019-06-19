## Isolated Deployment

This repository aims to simplify compilation and dependency management of VRSYS application stack ([lamure](https://github.com/vrsys/lamure), [guacamole](https://github.com/vrsys/guacamole), [avango](https://github.com/vrsys/avango)) on 64-bit Windows machines.
This is achieved through containerization of compilation environment and a convenience script.

## How to use

### Prerequisites

- Make sure that the target machine supports process isolation (recommended Windows 10 Version 1903 or later).
- Install [Docker Desktop](https://www.docker.com/products/docker-desktop) and switch to Windows Containers.
- Pull the latest Microsoft .Net image from DockerHub using PowerShell:

```docker image pull microsoft/dotnet-framework```

### Deployment Workflow

- Clone this repository into a local directory

```git clone https://github.com/0x0AF/vrsys-deployment```

- Change into the directory and build the deployment container from the definition in Dockerfile

```docker build -t buildtools2017native:latest .```

- Run the container with process isolation:

```docker  run --isolation=process -v C:\dev:C:\dev -m20g -it buildtools2017native```

where -m20g allows the use of 20Gb RAM.

- Inside the container, run the script (takes approx. 35 minutes):

```C:\install_dev.ps1```

- After the script is finished, exit the container. The application stack should be available natively at ```C:\dev\rep\```