#!/bin/sh

git clone https://github.com/HandsFree/teacherui-backend.git
git clone https://github.com/HandsFree/teacherui-frontend.git teacherui-backend/frontend

cd teacherui-backend

go build

cd frontend

yarn
yarn bp

cd ../

../setup_cfg.sh
