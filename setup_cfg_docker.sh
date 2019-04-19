#!/bin/sh

mkdir -p cfg
touch cfg/config.toml
echo "[auth]" >> cfg/config.toml
echo "id = \"teacherui\"" >> cfg/config.toml
echo "secret = \"$BCN_SECRET\"" >> cfg/config.toml

echo "[server]" >> cfg/config.toml
echo "local = $BCN_LOCAL" >> cfg/config.toml
echo "host = \"$BCN_HOST\"" >> cfg/config.toml
echo "callback_url = \"$BCN_URL\"" >> cfg/config.toml
echo "port = $PORT" >> cfg/config.toml
echo "file_root_path = \"./files\"" >> cfg/config.toml
echo "glp_files_path = \"glp_files/\"" >> cfg/config.toml
echo "beaconing_api_route = \"https://core.beaconing.eu/api/\"" >> cfg/config.toml
echo "templates = [ \"/teacherui/templates/index.html\", \"/teacherui/templates/unauthorised_user.html\" ]" >> cfg/config.toml
echo "dist_folder = \"/teacherui/frontend/public/dist\"" >> cfg/config.toml

echo "[localisation]" >> cfg/config.toml
echo "map_file = \"./trans.map\"" >> cfg/config.toml
echo "key_file = \"./trans.keys\"" >> cfg/config.toml

echo "[debug]" >> cfg/config.toml
echo "grmon = false" >> cfg/config.toml

echo "Config:"
cat cfg/config.toml

