#!/bin/sh
pip install httpx

wget https://raw.githubusercontent.com/pythonpizza/infrastructure/main/script/request-deploy/request-deploy.py

python delete-environment.py
