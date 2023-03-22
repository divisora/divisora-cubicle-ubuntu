## Divisora: Private, Automatic and Dynamic portal to other security zones
## Description
T.B.D

## Build / Run
```
podman build -t divisora/cubicle-ubuntu .
```

## Run
```
# NOTE: See divisora-installer for instructions. Not ment to run manually
podman run --name divisora_cubicle-ubuntu -d -p 5000:5000 divisora/cubicle-ubuntu:latest
```