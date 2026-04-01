FROM redhat/ubi8-minimal:8.9 AS builder

WORKDIR /app

RUN microdnf install python3 -y && microdnf clean all

FROM redhat/ubi8-minimal:8.9

USER root

WORKDIR /app

COPY --from=builder /usr /usr

RUN microdnf install -y shadow-utils && \
    useradd -m -u 228 appuser && \
    microdnf clean all

COPY hello_world.py .

RUN chown appuser:appuser /app

USER appuser

CMD ["python3", "hello_world.py"]
