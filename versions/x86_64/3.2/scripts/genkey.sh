#!/usr/bin/env bash

bash /bin/setup-system.sh
abuild-keygen -n
sudo cp "$HOME"/.abuild/*.rsa* /opt/keys
