# Build stage
FROM node:18 AS build

# Install pnpm (needed for n8n monorepo)
RUN npm install -g pnpm

# Set working directory
WORKDIR /app

# Copy repo files
COPY . .

# Install dependencies and build
RUN pnpm install --recursive && pnpm run build

# Runtime stage
FROM node:18

WORKDIR /data

# Copy built app from build stage
COPY --from=build /app/packages/cli/bin/n8n /usr/local/bin/n8n
COPY --from=build /app/packages /app/packages

# Create a non-root user
RUN useradd --home-dir /data --uid 1000 n8n \
  && chown -R n8n:n8n /data
USER n8n

EXPOSE 5678

CMD ["n8n", "start"]
