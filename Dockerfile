FROM golang:alpine

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

# Add setup files
ADD docker-entrypoint.sh /
ADD setup_cfg.sh /teacherui

RUN chmod +x /docker-entrypoint.sh &&\
    chmod +x setup_cfg.sh

# ENTRYPOINT [ "/bin/ash" ]
ENTRYPOINT [ "/docker-entrypoint.sh" ]

EXPOSE 8080
