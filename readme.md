# Palworld          
The following repository contains the source files for building a Palworld server.


### Running
To run the container, issue the following example command:
```
docker run -d \
-p 28015:28015/udp \
-p 28015:28015/tcp \
-e PALWORLD_SERVER_NAME="DOCKER PALWORLD" \
ghcr.io/netwarlan/palworld
```

### Environment Variables
We can make dynamic changes to our Palworld containers by adjusting some of the environment variables passed to our image.
Below are the ones currently supported and their (defaults):

Environment Variable | Default Value | Description
-------------------- | ------------- | -----------
PALWORLD_SERVER_UPDATE_ON_START | true | Update server on startup
PALWORLD_SERVER_VALIDATE_ON_START | false | Validate server files on startup
PALWORLD_SERVER_DIFFICULTY | None | Adjusts the overall difficulty of the game
PALWORLD_SERVER_MULTIPLAY | False | Enables or disables multiplayer mode
PALWORLD_SERVER_PVP | False | Enables or disables player versus player (PvP) mode
PALWORLD_SERVER_SELECT_START_LOCATION | True | Enables or disables the selection of starting locations on the map
PALWORLD_SERVER_COOP_PLAYER_MAX | 4 | Sets the maximum number of cooperative players in a session
PALWORLD_SERVER_MAX_PLAYERS | 32 | Sets the maximum number of players allowed on the server
PALWORLD_SERVER_NAME | NETWAR Palworld | Sets the name of the Palworld server
PALWORLD_SERVER_DESCRIPTION | n/a | Provides a description for the Palworld server
PALWORLD_SERVER_ADMIN_PASSWORD | n/a | Sets the password for server administration
PALWORLD_SERVER_PASSWORD | n/a | Sets the password for joining the Palworld server
PALWORLD_SERVER_PORT | 8211 | Sets the public port for the Palworld server
PALWORLD_SERVER_IP | n/a | Sets the public IP address for the Palworld server
PALWORLD_SERVER_RCON_ENABLE | False | Enables or disables Remote Console (RCON) for server administration
PALWORLD_SERVER_RCON_PORT | 25575 | Sets the port for Remote Console (RCON) communication.
PALWORLD_SERVER_AUTH | True | Enables or disables server authentication
PALWORLD_SERVER_BAN_LIST_URL | https://api.palworldgame.com/api/banlist.txt | Sets the URL for the server's ban list.