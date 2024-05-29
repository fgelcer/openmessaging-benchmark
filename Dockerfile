# Use an appropriate base image with Java and Maven pre-installed
FROM openjdk:11-slim

# Install Maven, Git, and other necessary tools
RUN apt-get update && apt-get install -y maven git && rm -rf /var/lib/apt/lists/*

# Accept the branch as a build argument
ARG BRANCH=topic-groups-bypass

# Set the working directory
WORKDIR /app

# Copy the repositry from host to container
COPY . /app/openmessaging-benchmark


# Clone the specified branch of the GitHub repository
# RUN git clone --branch ${BRANCH} https://github.com/fgelcer/openmessaging-benchmark.git

# Change working directory to the cloned repository
WORKDIR /app/openmessaging-benchmark

# Ensure the correct branch is checked out
RUN git checkout ${BRANCH}

# Build the project using Maven
RUN mvn clean install

# Ensure benchmark.sh is executable
RUN chmod +x ./bin/benchmark

# Add a script to replace variables in kafka.yaml and start the benchmark
COPY start-benchmark.sh /app/openmessaging-benchmark/start-benchmark.sh
RUN chmod +x /app/openmessaging-benchmark/start-benchmark.sh

# Default command
CMD ["./start-benchmark.sh"]
