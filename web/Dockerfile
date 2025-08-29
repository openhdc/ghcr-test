# Build stage
FROM golang:1.25.0-trixie AS builder

WORKDIR /src

# Copy dependency files first for better caching
COPY go.mod ./
RUN go mod download

# Copy source code
COPY . .

# Build the application
RUN go build -o ghcr-test .

# Runtime stage
FROM debian:trixie-slim

WORKDIR /app

# Install runtime dependencies
RUN apt-get update && apt-get install -y \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# Copy binary with correct ownership
COPY --from=builder --chown=nobody:nobody /src/ghcr-test ./ghcr-test
RUN chmod 550 ./ghcr-test

# Switch to non-root user
USER nobody

ENTRYPOINT ["/app/ghcr-test"]