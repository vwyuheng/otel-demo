#!/bin/bash

[ -z "$JAVA_XMS" ] && JAVA_XMS=2048m
[ -z "$JAVA_XMX" ] && JAVA_XMX=2048m

set -e

# SkyWalking Agent 配置
export SW_AGENT_NAME=${APP_NAME} # 配置 Agent 名字。一般来说，我们直接使用 Spring Boot 项目的 `spring.application.name` 。
export SW_AGENT_COLLECTOR_BACKEND_SERVICES=oap:11800 # 配置 Collector 地址。
export SW_AGENT_SPAN_LIMIT=2000 # 配置链路的最大 Span 数量。一般情况下，不需要配置，默认为 300 。主要考虑，有些新上 SkyWalking Agent 的项目，代码可能比较糟糕。
export JAVA_AGENT=-javaagent:${APP_HOME}/skywalking-agent/skywalking-agent.jar # SkyWalking Agent jar 地址。

# OpenTelemetry:
# https://github.com/open-telemetry/opentelemetry-java-instrumentation
JAVA_OPTS="${JAVA_OPTS} \
  -Xms${JAVA_XMS} \
  -Xmx${JAVA_XMX}"

exec java ${JAVA_OPTS} ${JAVA_AGENT} \
  -jar "${APP_HOME}/${APP_NAME}.jar" \
  --spring.config.location=/config/application.yml
