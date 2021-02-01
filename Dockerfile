###########################################################
#
# Dockerfile for micro-dockerhub-hook
#
###########################################################

# Setting the base to nodejs 15
FROM mhart/alpine-node:15

# Maintainer
LABEL Maintainer="Jonas Enge"

#### Begin setup ####

# Installs docker
COPY --from=docker:latest /usr/local/bin/docker /usr/bin/docker
COPY --from=docker/compose:alpine-1.28.0 /usr/local/bin/docker-compose /usr/bin/docker-compose

# Extra tools for native dependencies
# RUN apk add --no-cache make gcc g++ python

# Bundle app source
ENV WORKDIR /src
COPY . ${WORKDIR}

# Change working directory
WORKDIR "${WORKDIR}"

# Install dependencies
RUN npm install --production

# Env variables
ENV SERVER_PORT ${PORT}
# ENV TOKEN abc123
# ENV DEBUG DISABLE

EXPOSE ${PORT}

# Startup
ENTRYPOINT npm start
