# Palworld          
The following repository contains the source files for building a Palworld server.


### Running
To run the container, issue the following example command:
```
docker run -d \
-p 28015:28015/udp \
-p 28015:28015/tcp \
-p 28016:28016/tcp \
-e PALWORLD_SERVER_NAME="DOCKER PALWORLD" \
ghcr.io/netwarlan/palworld
```

### Environment Variables
We can make dynamic changes to our Palworld containers by adjusting some of the environment variables passed to our image.
Below are the ones currently supported and their (defaults):

Environment Variable | Default Value | Description
-------------------- | ------------- | -----------
PALWORLD_APP_PORT | 28082 | Port used to connect tot he PALWORLD+ app. (Default is 28082)
PALWORLD_RCON_ENABLE | false | Used to enable or disable RCON support
PALWORLD_RCON_PASSWORD | n/a | Password used for RCON
PALWORLD_RCON_PORT | 28016 | Port used for RCON
PALWORLD_SERVER_CONFIG | n/a | URL where a server.cfg can be used
PALWORLD_SERVER_DESCRIPTION | This PALWORLD server is going to be awesome! | Server Description
PALWORLD_SERVER_HEADER_IMAGE | https://www.netwar.org/wp-content/uploads/2018/01/Netwar_Logo.png | Image used when in game server browser
PALWORLD_SERVER_IDENTITY | PALWORLD | Used to distinguish different servers
PALWORLD_SERVER_LEVEL | Procedural Map | Map to use
PALWORLD_SERVER_MAXPLAYERS | 100 | Number of players that can actively join server.
PALWORLD_SERVER_NAME | Docker PALWORLD | Name of server
PALWORLD_SERVER_PORT | 28015 | Port used to connect to PALWORLD server. (Default is 28015)
PALWORLD_SERVER_SAVE_INTERVAL | 300 | In seconds, how often the server will save world state
PALWORLD_SERVER_SEED | 12345 | Seed used to generate random map
PALWORLD_SERVER_UPDATE_ON_START | true | When server is booting, should PALWORLD game files be updated 
PALWORLD_SERVER_URL | https://netwar.org | Server URL
PALWORLD_SERVER_USERS_CONFIG | n/a | URL where a users.cfg can be used
PALWORLD_SERVER_VALIDATE_ON_START | false | When server is booting, should PALWORLD validate game files (this will remove OXIDE)
PALWORLD_SERVER_WORLDSIZE | 3000 | Size of the world. (2000 is smallest, 6000 is largest)



Below list some options for In-game modifications:
Environment Variable | Default Value | Description
-------------------- | ------------- | -----------
PALWORLD_SERVER_WIPE_ALL | false | When server is booting, should all data be wiped
PALWORLD_SERVER_WIPE_MAP | false | When server is booting, should MAP files get wiped
PALWORLD_SERVER_WIPE_PLAYERS | false | When server is booting, should Player files get wiped
PALWORLD_UMOD_ENABLED | false | UMOD/Oxide mods enabled or disabled
PALWORLD_UMOD_BLUEPRINT_MANAGER | false | Installs "Blueprint Manager" plugin
PALWORLD_UMOD_BLUEPRINT_MANAGER_CONFIG | n/a | URL where to pull a config for "Blueprint Manager" plugin 
PALWORLD_UMOD_GATHER_MANAGER | false | Installs "Gather Manager" plugin
PALWORLD_UMOD_GATHER_MANAGER_CONFIG | n/a | URL where to pull a config for "Gather Manager" plugin 
PALWORLD_UMOD_NO_WORKBENCHES | false | Installs "No Workbenches" plugin
PALWORLD_UMOD_NO_WORKBENCHES_CONFIG | n/a | URL where to pull a config for "No Workbenches" plugin 