FROM updatemi/android-build-box

MAINTAINER Paul Weber

#install gradle
ENV GRADLE_VERSION="3.3"
ENV GRADLE_HOME="/opt/gradle/gradle-${GRADLE_VERSION}/bin"
ENV PATH="$GRADLE_HOME:${PATH}"
ENV CI=1
ENV CORDOVA_ANDROID_GRADLE_DISTRIBUTION_URL="file:///tmp/Gradle/gradle-${GRADLE_VERSION}-all.zip"
#ENV ORG_GRADLE_PROJECT_cdvBuildToolsVersion=25.0.3
#ENV ORG_GRADLE_PROJECT_cdvCompileSdkVersion=25.0.3
#ENV GRADLE_OPTS=$GRADLE_OPTS"-Dorg.gradle.daemon=false"

RUN jps && mkdir Gradle && cd Gradle && \
	wget -q https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-all.zip && \
	unzip -q -d /opt/gradle gradle-${GRADLE_VERSION}-all.zip && \
	gradle -v && cd ..

ADD .gradle/gradle.properties $GRADLE_HOME

#install cordova
RUN npm install --quiet -g cordova && \
	npm cache clean --force > /dev/null

RUN	cordova create temp && \
	cd temp && \
	cordova platform add android && \
	echo $PATH && echo Gradle Home $GRADLE_HOME && \
	cordova requirements android  && \
	cordova build android && \
	cd .. && \
	rm -r temp && gradle --stop && jps

