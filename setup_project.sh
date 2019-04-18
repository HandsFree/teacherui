#!/bin/sh

mv setup_cfg.sh teacherui-backend/
cd teacherui-backend
chmod +x setup_cfg.sh
./setup_cfg.sh

./teacherui-backend
