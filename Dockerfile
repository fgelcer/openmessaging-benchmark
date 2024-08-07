# Use an appropriate base image with Java and Maven pre-installed
FROM openjdk:11-slim

# Install Maven, Git, and other necessary tools
RUN apt-get update && apt-get install -y maven git && rm -rf /var/lib/apt/lists/*

# Accept the branch as a build argument
ARG BRANCH=master

# Set the working directory
WORKDIR /app

# Copy the repositry from host to container
COPY . /app/openmessaging-benchmark

# Change working directory to the cloned repository
WORKDIR /app/openmessaging-benchmark

# Ensure the correct branch is checked out
RUN git checkout ${BRANCH}

# Build the project using Maven
RUN mvn clean install -Dlicense.skip=True

# Default command to open terminal
ENTRYPOINT ["/bin/bash"]
