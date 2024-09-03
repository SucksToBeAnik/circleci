# Use a specific node version or a base image as needed
FROM node:latest

WORKDIR /usr/src

# Install pm2 globally
RUN npm install --global pm2

# Copy package.json and package-lock.json
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the application
RUN npm run build

# Set default port for the application
ENV PORT=3000

# Expose the port on which the app runs
EXPOSE 3000
EXPOSE 80

# Run the application using environment variable PORT
# CMD ["sh", "-c", "./node_modules/.bin/next start -p $PORT"]
CMD ["sh", "-c", "pm2-runtime ./node_modules/.bin/next start -p $PORT"]
