Docker Builder
==============

This code base can be deployed onto a docker enabled server, so that code snippets can be pushed over tcp and run

1. Clone code onto server enabled with docker. Make sure user running server can use docker with out sudo

2. Build the base image for Ruby, whose docker file is located in base/

3. Set the DOCKER_SERVER_DIR and DOCKER_SERVER_PORT environment variables

4. Run the docker_server.rb executable