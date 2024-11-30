# womble-weewx - creating a docker image for weewx

Firstly massive credit to 
https://github.com/felddy/weewx-docker for the work putting together the project. I needed to move weewx to a new server, and wanted to use Docker to run the new server. 

- SDR is used to pickup the sensor data
- the config and report is wrotten to an nfs mounted directory
- a MariaDB hosts the database
- i did have an existing configuration i needed to move.

1. 'just build' builds the docker image. Found that i needed to rebuild the the original but with the uid of the user i use on the server
2. a 'sub' docker image adds in the required SDR tools and importantly sets the rtl tool to run as root.
3. once the docker image of built then the setup can run. this needs to run the extension install.
4. at this point i need to update the configuration to match the original
5. then it can run as a daemon 

6. 
