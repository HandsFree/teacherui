FROM golang:alpine

ARG BCN_SECRET
ARG BCN_URL=""
ARG BCN_LOCAL
ARG PORT

# Installing packages
# `--virtual .bcn-deps` -- groups packages under .bcn-deps
RUN apk update &&\
    apk --no-cache add --virtual .bcn-deps yarn nodejs git

# Fetch the backend and frontend
RUN git clone https://github.com/HandsFree/teacherui-backend.git /teacherui &&\
    git clone https://github.com/HandsFree/teacherui-frontend.git /teacherui/frontend

# Set root dir for commands to teacherui-backend
WORKDIR /teacherui

# Build the backend and frontend
RUN go build -o teacherui-backend

RUN cd frontend &&\
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
ADD setup_cfg_docker.sh /teacherui

RUN chmod +x setup_cfg_docker.sh &&\
    chmod +x /start_docker.sh

CMD [ "/start_docker.sh" ]

EXPOSE $PORT
