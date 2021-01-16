#!/bin/sh
pip install httpx

wget https://raw.githubusercontent.com/pythonpizza/infrastructure/main/script/delete-environment/delete-environment.py

python delete-environment.py
