FROM golang:alpine

ARG BCN_SECRET
ARG BCN_HOST="0.0.0.0"
ARG BCN_URL=""
ARG BCN_LOCAL
ARG PORT

# Installing packages
# `--virtual .bcn-deps` -- groups packages under .bcn-deps
RUN apk update &&\
    apk --no-cache add --virtual .bcn-deps yarn nodejs git

# Fetch the backend and frontend
RUN git clone https://github.com/HandsFree/teacherui-backend.git /teacherui-backend &&\
    git clone https://github.com/HandsFree/teacherui-frontend.git /teacherui-frontend

# Build the backend and frontend
RUN cd /teacherui-backend &&\
    go build -o teacherui-backend &&\
    cd /teacherui-frontend &&\
    rm -rf node_modules &&\
    rm yarn.lock &&\
    yarn &&\
    yarn bp

# Cleanup
RUN rm -rf /var/cache/apk/* /tmp/* /var/tmp/* /var/log/* \
    /go/pkg/mod/* /teacherui/frontend/node_modules /teacherui/frontend/src &&\
    apk del .bcn-deps

# Add scripts
ADD start_docker.sh /
ADD setup_cfg_docker.sh /teacherui-backend

# Set root dir for commands to teacherui-backend
WORKDIR /teacherui-backend

RUN chmod +x setup_cfg_docker.sh &&\
    chmod +x /start_docker.sh

CMD [ "/start_docker.sh" ]

EXPOSE $PORT
