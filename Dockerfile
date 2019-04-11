############################################################
# Dockerfile to build Express application 
# container image, based on node image
############################################################
FROM node:10.15-alpine

LABEL Author="AIA"
LABEL Version="0.0.1"

# Variables
ENV PORT 8080
ENV WDIR /usr/src/app

# Create app directory
RUN mkdir -p ${WDIR}
WORKDIR ${WDIR}

COPY .npmrc .npmrc

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

# Insert proxy settings here

# run NPM install
RUN npm install

# Bundle app source
COPY . ./

# run NPM build & # Verify files are there
RUN npm run build && find ${WDIR} -type f  -follow -print | grep -v ./node_modules

# Port for Web
EXPOSE ${PORT}

HEALTHCHECK --interval=5m --timeout=3s \
  CMD curl -f http://localhost:${PORT} || exit 1

# Start the app
CMD [ "npm", "start" ]