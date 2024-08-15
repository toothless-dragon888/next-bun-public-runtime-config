FROM oven/bun:latest AS build-env
# Disable telemetry
ENV NEXT_TELEMETRY_DISABLED 1

WORKDIR /app

# Building app
COPY package*.json ./
COPY bun.lockb ./

# Install node modules
# Note: We also install dev deps as TypeScript may be needed
RUN bun install

# Copy files. Use dockerignore to avoid copying node_modules
COPY . .

# Build
RUN bun next build

# Running the app
FROM gcr.io/distroless/nodejs20-debian11
WORKDIR /app

# Mark as prod, disable telemetry, set port
ENV NEXT_TELEMETRY_DISABLED 1

# Copy from build
COPY --from=build-env /app/next.config.mjs ./
COPY --from=build-env /app/.env ./
COPY --from=build-env /app/public ./public
COPY --from=build-env /app/.next ./.next
COPY --from=build-env /app/node_modules ./node_modules

EXPOSE 3000

# Run app command
CMD ["./node_modules/next/dist/bin/next", "start"]
