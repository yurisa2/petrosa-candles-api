FROM tiangolo/uvicorn-gunicorn:python3.10


# Allow statements and log messages to immediately appear in the Knative logs
ENV PYTHONUNBUFFERED True
# ENV TZ America/Sao_Paulo

# Copy local code to the container image.
ENV APP_HOME /app
WORKDIR $APP_HOME
COPY . ./

RUN apt update && apt install -y git

# Install production dependencies.
RUN pip install --no-cache-dir -r requirements.txt


RUN pip3 install opentelemetry-distro opentelemetry-exporter-otlp
# RUN opentelemetry-bootstrap -a install

ENV OTEL_SERVICE_NAME=petrosa-candles-api
ENV OTEL_TRACES_EXPORTER=otlp
ENV OTEL_METRICS_EXPORTER=otlp
ENV OTEL_LOGS_EXPORTER=otlp
ENV OTEL_PYTHON_LOG_CORRELATION=true
ENV OTEL_EXPORTER_OTLP_TRACES_ENDPOINT=otelcollector.petrosa-system.svc.cluster.local:4317
ENV OTEL_EXPORTER_OTLP_LOGS_ENDPOINT=http://otelcollector.petrosa-system.svc.cluster.local:4317
ENV OTEL_EXPORTER_OTLP_METRICS_ENDPOINT=http://otelcollector.petrosa-system.svc.cluster.local:4317
ENV OTEL_EXPORTER_OTLP_METRIC_ENDPOINT=http://otelcollector.petrosa-system.svc.cluster.local:4317
ENV OTEL_EXPORTER_OTLP_INSECURE=true
ENV OTEL_EXPORTER_OTLP_TRACES_INSECURE=true
ENV OTEL_EXPORTER_OTLP_LOGS_INSECURE=true
ENV OTEL_EXPORTER_OTLP_METRICS_INSECURE=true
ENV OTEL_EXPORTER_OTLP_METRIC_INSECURE=true
ENV OTEL_EXPORTER_OTLP_SPAN_INSECURE=true
ENV OTEL_METRIC_EXPORT_INTERVAL=5

CMD ["uvicorn", "app.app:router", "--host", "0.0.0.0", "--port", "80", "--log-level", "warning"]