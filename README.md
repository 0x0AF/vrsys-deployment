## Isolated Deployment

This repository aims to simplify compilation and dependency management of VRSYS application stack ([lamure](https://github.com/vrsys/lamure), [guacamole](https://github.com/vrsys/guacamole), [avango](https://github.com/vrsys/avango)) on 64-bit Windows machines.
This is achieved through containerization of compilation environment and a convenience script.

## How to use

### Prerequisites

- Make sure that the target machine supports process isolation (recommended Windows 10 Version 1903 or later). The most reliable way to update is through [here](https://www.microsoft.com/de-de/software-download/windows10).
- Install [Docker Desktop](https://hub.docker.com/editions/community/docker-ce-desktop-windows) and switch to Windows Containers. The following configuration of Docker Daemon has been tested to work (this is a subject to change):

```
{
  "registry-mirrors": [],
  "insecure-registries": [],
  "debug": true,
  "experimental": true
}
```

To use DNS service of BUW (for stable network access at BUW), apply the following configuration:

```
{
  "registry-mirrors": [],
  "insecure-registries": [],
  "debug": true,
  "experimental": true,
  "dns" : [
    "141.54.65.1"
  ]
}
```

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

If required, the script can be ran partially, normally in the following order:

```C:\pull_dependencies.ps1``` (get the latest state of dependencies)

```C:\pull_repositories.ps1``` (get the latest state of repositories)

```C:\build_repositories.ps1``` (make BUILD and INSTALL targets of the application stack)

- After the script is finished, exit the container. The application stack should be available natively at ```C:\dev\rep\```

### Post-build Instructions

Running guacamole and avango after build requires some additional steps.

To run Vive examples one should install and update Steam VR. A headset must be connected and configured.

To run avango examples one should install ```python 3.5 (x64)``` and set the environment variable ```PYTHONPATH``` to its location.