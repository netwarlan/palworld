#!/usr/bin/env bash

echo "
╔═══════════════════════════════════════════════╗
║                                               ║
║       _  _____________      _____   ___       ║
║      / |/ / __/_  __/ | /| / / _ | / _ \      ║
║     /    / _/  / /  | |/ |/ / __ |/ , _/      ║
║    /_/|_/___/ /_/   |__/|__/_/ |_/_/|_|       ║
║                                 OFFICIAL      ║
║                                               ║
╠═══════════════════════════════════════════════╣
║ Thanks for using our DOCKER image! Should you ║
║ have issues, please reach out or create a     ║
║ github issue. Thanks!                         ║
║                                               ║
║ For more information:                         ║
║ github.com/netwarlan                          ║
╚═══════════════════════════════════════════════╝"


## Set default values if none were provided
## ==============================================
[[ -z "${PALWORLD_SERVER_UPDATE_ON_START}" ]] && PALWORLD_SERVER_UPDATE_ON_START=true
[[ -z "${PALWORLD_SERVER_VALIDATE_ON_START}" ]] && PALWORLD_SERVER_VALIDATE_ON_START=false
[[ -z "${PALWORLD_SERVER_CONFIG_URL}" ]] && PALWORLD_SERVER_CONFIG_URL=""

## Update on startup
## ==============================================
if [[ "${PALWORLD_SERVER_UPDATE_ON_START}" = true ]] || [[ "${PALWORLD_SERVER_VALIDATE_ON_START}" = true ]]; then
echo "
╔═══════════════════════════════════════════════╗
║ Checking for updates                          ║
╚═══════════════════════════════════════════════╝"
  if [[ "${PALWORLD_SERVER_VALIDATE_ON_START}" = true ]]; then
    VALIDATE_FLAG='validate'
    echo " - Validating"
  else
    VALIDATE_FLAG=''
  fi

  ${STEAMCMD_DIR}/steamcmd.sh \
  +force_install_dir ${GAME_DIR} \
  +login ${STEAMCMD_USER} ${STEAMCMD_PASSWORD} ${STEAMCMD_AUTH_CODE} \
  +app_update ${STEAMCMD_APP} ${VALIDATE_FLAG} \
  +quit
fi


## Get Server Config
## ==============================================
echo "
╔═══════════════════════════════════════════════╗
║ Grabbing Config                               ║
╚═══════════════════════════════════════════════╝"
echo " - Removing any existing configurations"
rm ${GAME_DIR}/Pal/Saved/Config/LinuxServer/PalWorldSettings.ini
echo " - Downloading config"
curl -sL ${PALWORLD_SERVER_CONFIG_URL} > ${GAME_DIR}/Pal/Saved/Config/LinuxServer/PalWorldSettings.ini



## Flatten permissions
## ==============================================
echo "
╔═══════════════════════════════════════════════╗
║ Flatten Permissions                           ║
╚═══════════════════════════════════════════════╝"
echo "- Level setting permissions"
chown ${GAME_USER}:${GAME_USER} -R ${GAME_DIR}
chmod 770 -R ${GAME_DIR}
echo "- Level set complete."




## Run
## ==============================================
echo "
╔═══════════════════════════════════════════════╗
║ Starting server                               ║
╚═══════════════════════════════════════════════╝"
${GAME_DIR}/PalServer.sh