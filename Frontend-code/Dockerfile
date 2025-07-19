# ========== Build Stage ==========
FROM node:18-alpine AS builder

WORKDIR /app

# Only copy what's needed to install and build
COPY package*.json ./
COPY . .

RUN npm ci
RUN npm run build

# ========== Production Stage ==========
FROM node:18-alpine AS runner

WORKDIR /app

# Install only production dependencies
COPY --from=builder /app/package*.json ./
RUN npm ci --omit=dev

# Copy built assets
COPY --from=builder /app/public ./public
COPY --from=builder /app/.next ./.next

# Copy the entrypoint script for runtime env injection
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 3000

CMD ["/entrypoint.sh"]
