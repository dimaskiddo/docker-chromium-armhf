# Chromium in Docker for ARM with Widevine
This is a Google Chromium container using the armhf architecture.
Currently, it provides Widevine CDM support with Hardware Acceleration enabled.


## Build Docker Container Image
To build the Docker image, you have to clone it first,
```
git clone https://github.com/dimaskiddo/docker-chromium-armhf.git
cd docker-chromium-armhf
docker build -t dimaskiddo/ubuntu-armhf:chromium-78.0 .
```


## Run Chromium in Docker Container
You need to enable XHost forwarding first:
```
xhost +local:docker
```
If the xhost command can not be found, make sure to install it first

Then you can run the image using the following command:
```
docker pull dimaskiddo/ubuntu-armhf:chromium-78.0

docker run -d --rm --privileged \
  -e DISPLAY=unix$DISPLAY \
  -v $HOME:/home/user \  
  -v /etc/machine-id:/etc/machine-id \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /dev:/dev \
  -v /run:/run \
  --ipc=host \
  dimaskiddo/ubuntu-armhf:chromium-78.0
```

Or simply use the script chromium-armhf:
```
sudo cp script/chromium-armhf /usr/local/bin
sudo chmod 755 /usr/local/bin/chromium-armhf
chromium-armhf
```


## Known Bugs
- Settings Tab crashed directly after loading

