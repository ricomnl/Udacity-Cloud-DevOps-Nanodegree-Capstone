setup:
	# Create python virtualenv & source it
	# source ~/.devops/bin/activate
	python3 -m venv ~/.udacity-capstone

install:
	# This should be run from inside a virtualenv
	pip install --upgrade pip &&\
		pip install -r requirements.txt

test:	

lint:
	# This is linter for Dockerfiles
	hadolint Dockerfile
	# This should be run from inside a virtualenv
	pylint --disable=R,C,W1203 app.py

all: install lint test