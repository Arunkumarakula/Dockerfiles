# Dockerfile for Frontend

# ==============================
# 1. Build Stage (Node + Vite)
# ==============================
FROM node:20-alpine AS build

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy project files and build React app
COPY . .
RUN npm run build

# ==============================
# 2. Production Stage (Nginx)
# ==============================
FROM nginx:alpine

# Copy built React app from build stage
COPY --from=build /app/dist /usr/share/nginx/html

# Optional: custom nginx.conf for React Router
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Run Nginx in foreground
CMD ["nginx", "-g", "daemon off;"]

