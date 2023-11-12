# Use a Node.js base image
FROM node:latest as build

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy the entire project to the container
COPY . .

# Build the React app
RUN npm run build

# Use a smaller Nginx image for production
FROM nginx:alpine

# Copy the built app from the build stage to the nginx public directory
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# The default command to start Nginx when the container starts
CMD ["nginx", "-g", "daemon off;"]
