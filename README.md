# OMB on Vast

This is a fork of Datastax Version of Open Messaging Benchmark. 



# RUN

Run this project as a container to avoid dependency issues with Vast build. In order to do that, run:

    docker-compose up --build
  This will show on the screen the logs of OMB.
  To change the behavior of OMB, edit the variables in the docker-compose.yml, such as:
  * Broker IP
  * Port
  * Branch/Version to run on
  * Workload

