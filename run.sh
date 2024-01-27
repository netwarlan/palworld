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
[[ -z "${PALWORLD_SERVER_DIFFICULTY}" ]] && PALWORLD_SERVER_DIFFICULTY="None"
[[ -z "${PALWORLD_SERVER_MULTIPLAY}" ]] && PALWORLD_SERVER_MULTIPLAY="False"
[[ -z "${PALWORLD_SERVER_PVP}" ]] && PALWORLD_SERVER_PVP="False"
[[ -z "${PALWORLD_SERVER_SELECT_START_LOCATION}" ]] && PALWORLD_SERVER_SELECT_START_LOCATION="True"
[[ -z "${PALWORLD_SERVER_COOP_PLAYER_MAX}" ]] && PALWORLD_SERVER_COOP_PLAYER_MAX="4"
[[ -z "${PALWORLD_SERVER_MAX_PLAYERS}" ]] && PALWORLD_SERVER_MAX_PLAYERS="32"
[[ -z "${PALWORLD_SERVER_NAME}" ]] && PALWORLD_SERVER_NAME="NETWAR Palworld"
[[ -z "${PALWORLD_SERVER_DESCRIPTION}" ]] && PALWORLD_SERVER_DESCRIPTION=""
[[ -z "${PALWORLD_SERVER_ADMIN_PASSWORD}" ]] && PALWORLD_SERVER_ADMIN_PASSWORD=""
[[ -z "${PALWORLD_SERVER_PASSWORD}" ]] && PALWORLD_SERVER_PASSWORD=""
[[ -z "${PALWORLD_SERVER_PORT}" ]] && PALWORLD_SERVER_PORT="8211"
[[ -z "${PALWORLD_SERVER_IP}" ]] && PALWORLD_SERVER_IP=""
[[ -z "${PALWORLD_SERVER_RCON_ENABLE}" ]] && PALWORLD_SERVER_RCON_PORT="False"
[[ -z "${PALWORLD_SERVER_RCON_PORT}" ]] && PALWORLD_SERVER_RCON_PORT="25575"
[[ -z "${PALWORLD_SERVER_AUTH}" ]] && PALWORLD_SERVER_AUTH="True"
[[ -z "${PALWORLD_SERVER_BAN_LIST_URL}" ]] && PALWORLD_SERVER_BAN_LIST_URL="https://api.palworldgame.com/api/banlist.txt"


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
║ Setting up config                             ║
╚═══════════════════════════════════════════════╝"
echo "- Removing any existing configuration"
rm ${GAME_DIR}/Pal/Saved/Config/LinuxServer/PalWorldSettings.ini

if [[ ! -z "${PALWORLD_SERVER_CONFIG_URL}" ]]; then
echo "- Downloading config from URL $PALWORLD_SERVER_CONFIG_URL"
curl -sL ${PALWORLD_SERVER_CONFIG_URL} > ${GAME_DIR}/Pal/Saved/Config/LinuxServer/PalWorldSettings.ini
else
echo "- Building config from environment variables"
cat <<EOF > ${GAME_DIR}/Pal/Saved/Config/LinuxServer/PalWorldSettings.ini
[/Script/Pal.PalGameWorldSettings]
OptionSettings=(Difficulty=$PALWORLD_SERVER_DIFFICULTY,DayTimeSpeedRate=1.000000,NightTimeSpeedRate=1.000000,ExpRate=1.000000,PalCaptureRate=1.000000,PalSpawnNumRate=1.000000,PalDamageRateAttack=1.000000,PalDamageRateDefense=1.000000,PlayerDamageRateAttack=1.000000,PlayerDamageRateDefense=1.000000,PlayerStomachDecreaceRate=1.000000,PlayerStaminaDecreaceRate=1.000000,PlayerAutoHPRegeneRate=1.000000,PlayerAutoHpRegeneRateInSleep=1.000000,PalStomachDecreaceRate=1.000000,PalStaminaDecreaceRate=1.000000,PalAutoHPRegeneRate=1.000000,PalAutoHpRegeneRateInSleep=1.000000,BuildObjectDamageRate=1.000000,BuildObjectDeteriorationDamageRate=1.000000,CollectionDropRate=1.000000,CollectionObjectHpRate=1.000000,CollectionObjectRespawnSpeedRate=1.000000,EnemyDropItemRate=1.000000,DeathPenalty=All,bEnablePlayerToPlayerDamage=False,bEnableFriendlyFire=False,bEnableInvaderEnemy=True,bActiveUNKO=False,bEnableAimAssistPad=True,bEnableAimAssistKeyboard=False,DropItemMaxNum=3000,DropItemMaxNum_UNKO=100,BaseCampMaxNum=128,BaseCampWorkerMaxNum=15,DropItemAliveMaxHours=1.000000,bAutoResetGuildNoOnlinePlayers=False,AutoResetGuildTimeNoOnlinePlayers=72.000000,GuildPlayerMaxNum=20,PalEggDefaultHatchingTime=72.000000,WorkSpeedRate=1.000000,bIsMultiplay=$PALWORLD_SERVER_MULTIPLAY,bIsPvP=$PALWORLD_SERVER_PVP,bCanPickupOtherGuildDeathPenaltyDrop=False,bEnableNonLoginPenalty=True,bEnableFastTravel=True,bIsStartLocationSelectByMap=$PALWORLD_SERVER_SELECT_START_LOCATION,bExistPlayerAfterLogout=False,bEnableDefenseOtherGuildPlayer=False,CoopPlayerMaxNum=$PALWORLD_SERVER_COOP_PLAYER_MAX,ServerPlayerMaxNum=$PALWORLD_SERVER_MAX_PLAYERS,ServerName="$PALWORLD_SERVER_NAME",ServerDescription="$PALWORLD_SERVER_DESCRIPTION",AdminPassword="$PALWORLD_SERVER_ADMIN_PASSWORD",ServerPassword="$PALWORLD_SERVER_PASSWORD",PublicPort=$PALWORLD_SERVER_PORT,PublicIP=$PALWORLD_SERVER_IP,RCONEnabled=$PALWORLD_SERVER_RCON_ENABLE,RCONPort=$PALWORLD_SERVER_RCON_PORT,Region="",bUseAuth=$PALWORLD_SERVER_AUTH,BanListURL="$PALWORLD_SERVER_BAN_LIST_URL")
EOF
fi



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