#!/bin/sh
pip install httpx

wget https://raw.githubusercontent.com/pythonpizza/infrastructure/script/request-deploy/request-deploy.py

python request-deploy.py
