FROM redhat/ubi8-minimal:8.9

USER root

WORKDIR /app

RUN microdnf install -y python3 shadow-utils && \
    useradd -m -u 228 appuser && \
    microdnf clean all

COPY hello_world.py .

RUN chown appuser:appuser /app

USER appuser

CMD ["python3", "hello_world.py"]
