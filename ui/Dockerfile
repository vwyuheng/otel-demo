# NOTE: Users must mount the Spring config file to /config/application.yml.

FROM openjdk:11-jre
LABEL maintainer="Willie Wheeler"

ENV APP_NAME otel-ui
ENV APP_HOME /app/bin
ENV AGENT_VERSION="8.10.0"

RUN mkdir -p ${APP_HOME}

COPY ./target/${APP_NAME}-*.jar ${APP_HOME}/${APP_NAME}.jar
COPY ./tmp/apache-skywalking-java-agent-${AGENT_VERSION}.tgz ${APP_HOME}/
RUN cd ${APP_HOME} && tar -zxvf apache-skywalking-java-agent-${AGENT_VERSION}.tgz && rm apache-skywalking-java-agent-${AGENT_VERSION}.tgz
COPY ./scripts/start-app.sh ${APP_HOME}/

WORKDIR ${APP_HOME}

ENTRYPOINT [ "./start-app.sh" ]
