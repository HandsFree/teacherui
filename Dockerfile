FROM golang:alpine

# Installing packages
RUN apk update &&\
    apk add yarn &&\
    apk add nodejs &&\
    apk add git &&\
    rm -rf /var/cache/apk/* /tmp/* /var/tmp/*

# Fetch the backend and frontend
RUN go get github.com/HandsFree/teacherui-backend &&\
    git clone https://github.com/HandsFree/teacherui-frontend.git /go/src/github.com/HandsFree/teacherui-backend/frontend

# Set root dir for commands to teacherui-backend
WORKDIR /go/src/github.com/HandsFree/teacherui-backend

# TODO: use non-root user
USER root

# update all go deps, build into beaconing binary.
# cd into the frontend and build.
RUN go get && go build -o beaconing

RUN cd frontend &&\
    rm -rf node_modules &&\
    rm yarn.lock &&\
    yarn &&\
    yarn bp

ADD docker-entrypoint.sh /
ADD setup_cfg.sh /go/src/github.com/HandsFree/teacherui-backend

RUN chmod +x /docker-entrypoint.sh
RUN chmod +x setup_cfg.sh


ENTRYPOINT [ "/docker-entrypoint.sh" ]

EXPOSE 8080
