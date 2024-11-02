# Stage 1: Build the Angular application
FROM node:16 AS build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json to install dependencies
COPY package*.json ./

# Install dependencies
RUN npm install --omit=dev

# Copy the rest of the application files
COPY . .

# Build the Angular application
RUN npm run build

# Stage 2: Serve the application using NGINX
FROM nginx:alpine

# Copy the built application from the build stage
COPY --from=build /app/dist/newproject /usr/share/nginx/html

# Expose the port NGINX will run on
EXPOSE 80

# Start NGINX server
CMD ["nginx", "-g", "daemon off;"]
