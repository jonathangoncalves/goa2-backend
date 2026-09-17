FROM ghcr.io/astral-sh/uv:python3.11-bookworm-slim

WORKDIR /app
ENV PYTHONUNBUFFERED=1 PATH="/app/.venv/bin:$PATH" UV_COMPILE_BYTECODE=1

# Deps first so code edits don't bust the layer cache
COPY pyproject.toml uv.lock README.md ./
RUN uv sync --frozen --no-dev --no-install-project

COPY src ./src
COPY data ./data
RUN uv sync --frozen --no-dev

EXPOSE 8000
CMD ["uvicorn", "goa2.main:app", "--host", "0.0.0.0", "--port", "8000"]
