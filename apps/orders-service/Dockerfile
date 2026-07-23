# ====================================================================
# Stage 1: Build - install dependencies
# ====================================================================

FROM python:3.12-slim AS builder

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir --user -r requirements.txt

# ====================================================================
# Stage 2: Runtime - final image
# ====================================================================

FROM python:3.12-slim

WORKDIR /app

# Create a non-root user for security reasons
RUN useradd --create-home appuser

# Copy installed dependencies from the build stage
COPY --from=builder --chown=appuser:appuser /root/.local /home/appuser/.local
COPY --chown=appuser:appuser ./app ./app

# Set the PATH environment variable to include the local bin directory
ENV PATH=/home/appuser/.local/bin:$PATH

USER appuser

EXPOSE 8000

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]