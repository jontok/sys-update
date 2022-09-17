#!/bin/bash
# Colors
RED='\033[0;31m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
NC='\033[0m' # No Color
# Long ARGS
fetch="--fetch"
update="--update"
help="--help"

# Short ARGS
short_fetch="-f"
short_update="-u"
short_help="-h"

# Help
display_help(){
    echo -e "${ORANGE}Desciption:"
    echo -e "   Wrapper script for apt/nala system upgrades.\n"
    echo -e "Usage:"
    echo -e "   sys-update [option]\n"
    echo -e "Options:"
    echo -e "   -h, --help     Shows Available Options"
    echo -e "   -f, --fetch    Will fetch all upgradable packages"
    echo -e "   -u, --update   Will update repositories${NC}"
}

# Package Manager Switch
pkg_mng_switch(){
    if [ -x "$(command -v nala)" ]
    then
        package_manager="nala"
        echo -e "${BLUE}Using $(command -v nala)${NC}\n"
    else
        package_manager="apt"
        echo -e "${BLUE}Using $(command -v apt)!${NC}\n"
    fi
}

# Update/Upgrade/Fetch
pkg_mng_switch
if [ "$1" == $help ] || [ "$1" == $short_help ]
then
    display_help
elif [ "$1" == $fetch ] || [ "$1" == $short_fetch ]
then
    sudo $package_manager update && sudo $package_manager list --upgradeable
elif [ "$1" == $update ] || [ "$1" == $short_update ]
then
    sudo $package_manager update
else
    sudo $package_manager update && sudo $package_manager upgrade -y
fi
