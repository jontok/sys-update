#!/bin/bash
RED='\033[0;31m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
NC='\033[0m' # No Color
echo -e "${BLUE}Installing sys-update at /usr/bin/sys-update${NC}\n"

if [ "$1" == "--nala-install" ]
then
    echo -e "${BLUE}OS Version Check${NC}"
    if [ -f /etc/os-release ]; then
        # freedesktop.org and systemd
        . /etc/os-release
        OS=$NAME
        VER=$VERSION_ID
    elif type lsb_release >/dev/null 2>&1; then
        # linuxbase.org
        OS=$(lsb_release -si)
        VER=$(lsb_release -sr)
    elif [ -f /etc/lsb-release ]; then
        # For some versions of Debian/Ubuntu without lsb_release command
        . /etc/lsb-release
        OS=$DISTRIB_ID
        VER=$DISTRIB_RELEASE
    elif [ -f /etc/debian_version ]; then
        # Older Debian/Ubuntu/etc.
        OS=Debian
        VER=$(cat /etc/debian_version)
    elif [ -f /etc/SuSe-release ]; then
        # Older SuSE/etc.
        ...
    elif [ -f /etc/redhat-release ]; then
        # Older Red Hat, CentOS, etc.
        ...
    else
        # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
        OS=$(uname -s)
        VER=$(uname -r)
    fi
    VER="20.04"
    echo -e "$OS $VER\n"

    
    # check if version is supported
    if [ "$VER" == "21.04" ] || [ "$VER" == "21.10" ]
    then
        echo -e "${BLUE}Installing nala-legacy${NC}"

        sudo apt update && sudo apt install nala-legacy
    elif [ "$VER" == "22.04" ]
    then
        echo -e "${BLUE}Installing nala${NC}"

        sudo apt update && sudo apt install nala
    else
        echo -e "${RED}Your OS or OS Release is not supported by nala!"
        echo -e "${ORANGE}Supported Releases:"
        echo -e "   Debian Testing/Sid"
        echo -e "   Debian Stable"
        echo -e "   Ubuntu 22.04"
        echo -e "   Ubuntu 21.10"
        echo -e "   Ubuntu 21.04${NC}"
    fi
else
    echo -e "To install nala (https://gitlab.com/volian/nala) use '--nala-install' flag\n"
fi

if [ -x "$(command -v nala)" ]
then
    sudo cp ./sys-update.sh /usr/bin/sys-update
    echo -e "${GREEN}sys-update -h for Help${NC}"
else
    echo -e "${RED}Your OS or OS Release does not support this script!"
    echo -e "Check if apt package-manager is installed${NC}"
fi