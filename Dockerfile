# FROM python:3.9.16-slim
FROM python:3.9.16

# Copying install_dependencies.sh & give permissions
COPY install_dependencies.sh /
RUN chmod +x /install_dependencies.sh

# install dependencies - making some changes here to test 
RUN ./install_dependencies.sh && \
    apt-get update && \
    /usr/bin/python3 -m pip install --upgrade pip

# install python package
COPY requirements.txt /
RUN pip --no-cache-dir install --upgrade setuptools && \
    pip --no-cache-dir install wheel && \
    pip --no-cache-dir install -r requirements.txt
	
# Making home & test folders
RUN mkdir crop-classification && \
    mkdir tests

# Copying tests
COPY /tests/test.py /tests
COPY /tests/run_tests.sh /tests

# Giving permission to tests to run 
RUN chmod +x /tests/test.py && \
    chmod +x /tests/run_tests.sh

WORKDIR "crop-classification-docker"
