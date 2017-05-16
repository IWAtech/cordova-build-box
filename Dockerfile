FROM mingc/android-build-box

MAINTAINER Paul Weber

RUN npm install --quiet -g cordova && npm cache clean

