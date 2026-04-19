# Stage 1: Build
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
# Install ALL dependencies (including dev) to build/test
RUN npm install
COPY . .

# Stage 2: Runtime
FROM node:20-alpine
WORKDIR /app
# Only copy the package files
COPY --from=builder /app/package*.json ./
# Install ONLY production dependencies (no tailwind, no nodemon)
RUN npm install --omit=dev
# Copy the source code
COPY --from=builder /app/server.js ./
COPY --from=builder /app/controllers ./controllers
COPY --from=builder /app/middleware ./middleware
COPY --from=builder /app/routes ./routes
COPY --from=builder /app/utils ./utils

USER node
EXPOSE 5000
CMD ["node", "server.js"]