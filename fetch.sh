#!/bin/bash



BLACK='\033[0;30m'
DARK_GRAY='\033[1;30m'
RED='\033[0;31m'
LIGHT_RED='\033[1;31m'
GREEN='\033[0;32m'
LIGHT_GREEN='\033[1;32m'
BROWN_ORANGE='\033[0;33m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
LIGHT_BLUE='\033[1;34m'
PURPLE='\033[0;35m'
LIGHT_PURPLE='\033[1;35m'
CYAN='\033[0;36m'
LIGHT_CYAN='\033[1;36m'
LIGHT_GRAY='\033[0;37m'
WHITE='\033[1;37m'
NC='\033[0m' 


imageColor=$RED
TextColor=$YELLOW
Spec=$BROWN_ORANGE

#CHANGE THIS PATH TO YOUR REPO PATH
IMAGE=~/Desktop/projects/Neofetch/hehe.png 


display_info() {
    OS=$(uname -o)
    DISTRO=$(grep -o 'NAME=".*"' /etc/os-release | cut -d '"' -f2 |uniq)
    KERNEL=$(uname -r)
    HOSTNAME=$(hostname)
    CPU=$(lscpu | grep "Model name" | awk -F: '{print $2}' | xargs)
    MEMORY=$(free -h | grep Mem | awk '{print $2}')
    DISK=$(df -h / | grep / | awk '{print $4}')
    UPTIME=$(uptime -p | sed 's/up //')
    SHELL=$(basename "$SHELL") 
    RESOLUTION=$(display_monitors) 
    PACKAGES=$(get_package_count)
    GPU=$(lspci | grep -e VGA -e 3D | awk -F ':' '{print $3}')

    
    echo -e "${TextColor} OS: ${Spec} $OS ${NORMAL}"
    echo -e "${TextColor} Distro:${Spec} $DISTRO"
    echo -e "${TextColor} Kernel:${Spec} $KERNEL"
    echo -e "${TextColor} Hostname:${Spec} $HOSTNAME"
    echo -e "${TextColor} CPU:${Spec} $CPU"
    echo -e "${TextColor} GPU:${Spec}$GPU"
    echo -e "${TextColor} Memory:${Spec} $MEMORY"
    echo -e "${TextColor} Disk:${Spec} $DISK"
    echo -e "${TextColor} Uptime:${Spec} $UPTIME"
    echo -e "${TextColor} Shell:${Spec} $SHELL" 
    echo -e "${TextColor} Resolution:${Spec} $RESOLUTION"
    echo -e "${TextColor} Terminal:${Spec} $TERM"
    echo -e "${TextColor} Packages:${Spec} $PACKAGES"
}

get_package_count() {
    if command -v pacman &> /dev/null; then
        pacman -Qq | wc -l
    elif command -v dpkg &> /dev/null; then
        dpkg -l | grep -c '^ii'
    elif command -v rpm &> /dev/null; then
        rpm -qa | wc -l
    elif command -v brew &> /dev/null; then
        brew list | wc -l
    elif command -v flatpak &> /dev/null; then
        flatpak list | wc -l
    else
        echo "N/A"
    fi
}

display_monitors() {

    xrandr | awk '/ connected/ {gsub(/\+.*/, "", $3); if ($3 == "primary") print $4; else print $3}' | sort -t 'x' -k 1,1nr -k 2,2nr | uniq -w 4 | paste -sd ','
}


# Generate ASCII art from an image using jp2a
image_to_ascii() {
    jp2a --width=40 $IMAGE

}

# Display ASCII art on the left and system information on the right
display_combined() {
    ascii_art=$(image_to_ascii)
    sys_info=$(display_info)
    monitor_info=$(display_monitors)
    colored_ascii_art=$(echo "$ascii_art" | awk -v imageColor="$imageColor" -v nc="$NC" '{print imageColor $0 nc}')
   
    paste <(echo -e "$colored_ascii_art") <(echo "$sys_info";)
}


display_combined
