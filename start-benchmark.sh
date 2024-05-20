#!/bin/bash

# Replace IP and PORT in the driver file
sed -i "s/\${kafkaServiceUrl:-localhost:9092}/${IP}:${PORT}/" ${DRIVER_FILE}

# Run bin/benchmark with driver and workload files
./bin/benchmark \
  --drivers "${DRIVER_FILE}" \
  "${WORKLOAD_FILE}"
