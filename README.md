# cordova-build-box
A dockerized cordova app build environment for android.

Use this docker image to execute cordova commands without setting up an Android and Cordova environment on your machine.

Installation of the image:

`docker pull IWAtech/cordova-build-box`

Usage of the image:

```docker run --rm -v `pwd`:/project updatemi/cordova-build-box bash -c "cd /project && cordova help"```

You could create a shell alias for easier usage, e.g. in .bashrc:

`alias docker-cdv=docker run --rm -v `pwd`:/project updatemi/cordova-build-box bash -c` 



