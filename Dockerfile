# Stage 1: Cargo Chef
FROM lukemathwalker/cargo-chef:0.1.62-rust-bookworm as chef
WORKDIR /app
RUN apt update && apt install lld clang -y

# Stage 2: Node and Tailwind setup
FROM node:18-slim as node_builder
WORKDIR /app
# Copy package.json and package-lock.json (or yarn.lock)
COPY ./package.json ./package-lock.json ./
# Install Node.js dependencies for Tailwind CSS
RUN npm install
# Copy Tailwind and other frontend-related files
COPY ./tailwind.config.js ./public ./
# Build Tailwind CSS
RUN npx tailwindcss -i ./public/tailwind.css -o ./public/styles.css --minify

# Stage 3: Cargo Planner
FROM chef as planner
COPY . .
# Compute a lock-like file for our project
RUN cargo chef prepare  --recipe-path recipe.json

FROM chef as builder
ENV SQLX_OFFLINE true
COPY --from=planner /app/recipe.json recipe.json
# Build project dependencies, not our application!
RUN cargo chef cook --release --recipe-path recipe.json
COPY . .
# Build project
RUN cargo build --release --bin server

FROM debian:bookworm-slim AS runtime

# Set the working directory
WORKDIR /app

# Install runtime dependencies
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends ca-certificates \
    # Clean up to keep the image size small
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Copy the compiled binary from the builder stage
COPY --from=builder /app/target/release/server server

# Copy the public folder from the builder stage
COPY --from=builder /app/public /app/public

# Set environment variables
ENV PORT 8080
ENV APP_ENVIRONMENT production
ENV RUST_LOG server=info,tower_http=info,sqlx=info

# Expose the port your app runs on
EXPOSE 8080

# Run the binary
ENTRYPOINT ["./server"]
