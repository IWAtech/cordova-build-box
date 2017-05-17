FROM mingc/android-build-box

MAINTAINER Paul Weber

#install gradle
ENV GRADLE_VERSION="3.5"
ENV GRADLE_HOME="/opt/gradle/gradle-${GRADLE_VERSION}/bin"
ENV PATH="$GRADLE_HOME:${PATH}"
ENV CI=1

RUN mkdir Gradle && cd Gradle && \
	wget -q https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-all.zip && \
	mkdir /opt/gradle && \
	unzip -q -d /opt/gradle gradle-${GRADLE_VERSION}-all.zip && \
	gradle -v && rm gradle-${GRADLE_VERSION}-all.zip && cd ..
#install cordova
RUN npm install --quiet -g cordova && \
	npm cache clean > /dev/null && \
	cordova create temp && \
	cd temp && \
	cordova platform add android && \
	#echo $PATH && echo Gradle Home $GRADLE_HOME && \
	cordova requirements android && \
	cd .. && \
	rm -r temp 

