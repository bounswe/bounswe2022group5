# Pull Docker Hub base image
FROM node:14-alpine
# Set working directory
WORKDIR /usr/src/app

COPY package*.json ./

RUN apk update 
RUN apk add git

# Install app dependencies
RUN npm i

# Copy app to container
COPY . .
# Create a build
RUN npm run build
# Install server
RUN npm i --global serve
# Run the app
CMD ["serve", "-s", "build"]