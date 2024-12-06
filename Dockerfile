# Use the official Python image.
# https://hub.docker.com/_/python

# A Dockerfile is a script that contains a series of instructions on how to build a Docker image. A Docker image is a lightweight, standalone, and executable software package that includes everything needed to r$

# This line tells Docker to use the official Python image (version 3.9, slim variant) as the base image for your container. A base image is like a template that includes the operating system and Python already i$
FROM python:3-slim

# Set the working directory to /app
# This sets the working directory inside the Docker container to /app. Any subsequent commands will be run from this directory.
WORKDIR /app

# This copies all the files from your local project directory (where the Dockerfile is located) to the /app directory inside the Docker container.
COPY . /app

# Copy the service account key to the /app/config/dev directory inside the container
# Assuming the key is in the same location relative to the Dockerfile
COPY config/dev/serviceAccountKey.json /app/config/dev/serviceAccountKey.json


# This runs a command inside the Docker container to install the Python packages listed in requirements.txt using pip. The --no-cache-dir option reduces the size of the image by not caching the packages.
# RUN pip install --no-cache-dir -r requirements.txt
# RUN pip install -r requirements.txt
# By caching the dependencies in /app/.pip_cache, subsequent builds will reuse the cache.
RUN pip install --cache-dir=/app/.pip_cache -r requirements.txt

# Make port 8080 available to the world outside this container
# This informs Docker that the container will listen on port 8080 at runtime. It's a way of documenting which port the application inside the container uses, but it doesn’t actually publish the port (that’s done$
EXPOSE 8080

# This sets an environment variable NAME with the value World inside the container. Environment variables can be used to configure your application.
ENV PORT=8080
# Set the GOOGLE_APPLICATION_CREDENTIALS environment variable
ENV GOOGLE_APPLICATION_CREDENTIALS="/app/config/dev/serviceAccountKey.json"


# Run app.py when the container launches
# CMD ["python3", "app.py"]
CMD ["python3", "-u" ,"app.py"]