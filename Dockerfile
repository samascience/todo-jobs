# Stage 1: Build React Frontend
FROM node:16 AS build

# Set working directory
WORKDIR /app

# Install dependencies and build the frontend
COPY client/package.json client/package-lock.json ./
RUN npm install
COPY client/ ./
RUN npm run build

# Stage 2: Setup Node.js Backend and Serve Frontend
FROM node:16

# Set working directory
WORKDIR /app

# Install backend dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy built frontend from the build stage
COPY --from=build /app/dist ./public

# Copy backend source code
COPY . .

# Expose the port the app runs on
EXPOSE 5000

# Start the backend server
CMD ["npm", "run", "start"]
