#!/bin/bash

red='\e[1;31m'
green='\e[0;32m'
yell='\e[1;33m'
BIBlue='\033[1;94m'       # Blue
BGCOLOR='\e[1;97;101m'    # WHITE RED
tyblue='\e[1;36m'
NC='\e[0m'
purple() { echo -e "\\033[35;1m${*}\\033[0m"; }
tyblue() { echo -e "\\033[36;1m${*}\\033[0m"; }
yellow() { echo -e "\\033[33;1m${*}\\033[0m"; }
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
cd /root
if [ "${EUID}" -ne 0 ]; then
echo "You need to run this script as root"
exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
echo "OpenVZ is not supported"
exit 1
fi
localip=$(hostname -I | cut -d\  -f1)
hst=( `hostname` )
dart=$(cat /etc/hosts | grep -w `hostname` | awk '{print $2}')
if [[ "2" != "2" ]]; then
echo "$localip $(hostname)" >> /etc/hosts
fi

if [[ ! -f /root/.isp ]]; then
curl -sS ipinfo.io/org?token=44ae7fd0b5d0d5 > /root/.isp
fi
if [[ ! -f /root/.city ]]; then
curl -sS ipinfo.io/city?token=44ae7fd0b5d0d5 > /root/.city
fi
if [[ ! -f /root/.myip ]]; then
curl -sS ipv4.icanhazip.com > /root/.myip
fi

export MYIP=$(cat /root/.myip);
export ISP=$(cat /root/.isp);
export CITY=$(cat /root/.city);
source /etc/os-release

function lane_atas() {
echo -e "${BIBlue}┌──────────────────────────────────────────┐${NC}"
}
function lane_bawah() {
echo -e "${BIBlue}└──────────────────────────────────────────┘${NC}"
}

rm -rf /etc/rmbl
mkdir -p /etc/rmbl
mkdir -p /etc/rmbl/theme
mkdir -p /var/lib/ >/dev/null 2>&1
echo "IP=" >> /var/lib/ipvps.conf
clear
lane_atas
echo -e "${BIBlue}│ ${BGCOLOR}             MASUKKAN NAMA KAMU         ${NC}${BIBlue} │${NC}"
lane_bawah
echo " "
until [[ $name =~ ^[a-zA-Z0-9_.-]+$ ]]; do
read -rp "Masukan Nama Kamu Disini ( tanpa spasi ): " -e name
done
rm -rf /root/.profil
echo "$name" > /root/.profil
echo ""
clear
author=$(cat /root/.profil)
echo ""
echo ""

data_server=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
date_list=$(date +"%Y-%m-%d" -d "$data_server")
url_izin="https://raw.githubusercontent.com/edydevelopeler/D4l4NWeDus/main/ip"
client=$(curl -sS $url_izin | grep $MYIP | awk '{print $2}')
exp=$(curl -sS $url_izin | grep $MYIP | awk '{print $3}')
today=`date -d "0 days" +"%Y-%m-%d"`
time=$(printf '%(%H:%M:%S)T')
date=$(date +'%d-%m-%Y')
d1=$(date -d "$exp" +%s)
d2=$(date -d "$today" +%s)
certifacate=$(((d1 - d2) / 86400))
checking_sc() {
  useexp=$(curl -s $url_izin | grep $MYIP | awk '{print $3}')
  if [[ $date_list < $useexp ]]; then
    echo -ne
  else
    clear
    echo -e "\033[96m============================================\033[0m"
    echo -e "\033[44;37m           NotAllowed Autoscript         \033[0m"    
    echo -e "\033[96m============================================\033[0m"
    echo -e "\e[95;1m buy / sewa AutoScript installer VPS \e[0m"
    echo -e "\033[96m============================================\033[0m"    
    echo -e "\e[96;1m   1 IP        : Rp.10.000   \e[0m"
    echo -e "\e[96;1m   2 IP        : Rp.15.000   \e[0m"   
    echo -e "\e[96;1m   7 IP        : Rp.40.000   \e[0m"
    echo -e "\e[96;1m   Unli IP     : Rp.150.000  \e[0m"
    echo -e "\e[97;1m   open source : Rp.400.000  \e[0m"       
    echo -e ""
    echo -e "\033[34m Contack WA/TLP: 087760204418     \033[0m"
    echo -e "\033[34m Telegram user : t.me/WuzzSTORE \033[0m"    
    echo -e "\033[96m============================================\033[0m"
    exit 0
  fi
}
checking_sc

function ARCHITECTURE() {
if [[ "$( uname -m | awk '{print $1}' )" == "x86_64" ]]; then
    echo -ne
else
    echo -e "${r} Your Architecture Is Not Supported ( ${y}$( uname -m )${NC} )"
    exit 1
fi

if [[ ${ID} == "ubuntu" || ${ID} == "debian" ]]; then
    echo -ne
else
    echo -e " ${r}This Script only Support for OS ubuntu 20.04 & debian 10"
    exit 0
fi
}
ARCHITECTURE
clear

function instalasi(){
fun_bar() {
    CMD[0]="$1"
    CMD[1]="$2"
    
    (
        # Hapus file fim jika ada
        [[ -e $HOME/fim ]] && rm -f $HOME/fim
        
        # Jalankan perintah di background dan sembunyikan output
        ${CMD[0]} -y >/dev/null 2>&1
        ${CMD[1]} -y >/dev/null 2>&1
        
        # Buat file fim untuk menandakan selesai
        touch $HOME/fim
    ) >/dev/null 2>&1 &

    tput civis # Sembunyikan kursor
    echo -ne "  \033[0;32mProcces\033[1;37m - \033[0;33m["
    
    while true; do
        for ((i = 0; i < 18; i++)); do
            echo -ne "\033[97;1m#"
            sleep 0.1
        done
        
        # Jika file fim ada, hapus dan keluar dari loop
        if [[ -e $HOME/fim ]]; then
            rm -f $HOME/fim
            break
        fi
        
        echo -e "\033[0;31m]"
        sleep 1
        tput cuu1 # Kembali ke baris sebelumnya
        tput dl1   # Hapus baris sebelumnya
        echo -ne "  \033[0;32mProcess\033[1;37m- \033[0;31m["
    done
    
    echo -e "\033[0;31m]\033[1;37m -\033[1;32m OK!\033[0m"
    tput cnorm # Tampilkan kursor kembali
}

domain_setup(){
wget https://raw.githubusercontent.com/edydevelopeler/EdYPlerJomMoxXZBbanGetv7/main/install/rmbl.sh && chmod +x rmbl.sh && ./rmbl.sh
clear
}

cd
echo -e "${BIBlue}╭══════════════════════════════════════════╮${NC}"
echo -e "${BIBlue}│ \033[1;37mPlease select a your Choice to Set Domain${BIBlue}│${NC}"
echo -e "${BIBlue}╰══════════════════════════════════════════╯${NC}"
echo -e "${BIBlue}╭══════════════════════════════════════════╮${NC}"
echo -e "${BIBlue}│  [ 1 ]  \033[1;37mDomain kamu sendiri       ${NC}"
echo -e "${BIBlue}│  [ 2 ]  \033[1;37mDomain random             ${NC}"
echo -e "${BIBlue}╰══════════════════════════════════════════╯${NC}"
until [[ $domain =~ ^[132]+$ ]]; do 
read -p "   Please select numbers 1  atau 2 : " domain
done
if [[ $domain == "1" ]]; then
clear
lane_atas
echo -e  "${BIBlue}│              \033[1;37mSETUP DOMAIN                ${BIBlue}│${NC}"
lane_bawah
echo " "
until [[ $dnss =~ ^[a-zA-Z0-9_.-]+$ ]]; do 
read -rp "Masukan domain kamu Disini : " -e dnss
done
rm -rf /etc/xray
rm -rf /etc/v2ray
rm -rf /etc/nsdomain
rm -rf /etc/per
mkdir -p /etc/xray
mkdir -p /etc/v2ray
mkdir -p /etc/nsdomain
touch /etc/xray/domain
touch /etc/v2ray/domain
touch /etc/xray/slwdomain
touch /etc/v2ray/scdomain
echo "$dnss" > /root/domain
echo "$dnss" > /root/scdomain
echo "$dnss" > /etc/xray/scdomain
echo "$dnss" > /etc/v2ray/scdomain
echo "$dnss" > /etc/xray/domain
echo "$dnss" > /etc/v2ray/domain
echo "IP=$dnss" > /var/lib/ipvps.conf
echo ""
cd
sleep 1
clear
rm /root/subdomainx
clear
fi
if [[ $domain == "2" ]]; then
clear
lane_atas
echo -e "${BIBlue}│ \033[1;37mPlease select a your Choice to Set Domain${BIBlue}│${NC}"
lane_bawah
lane_atas
echo -e "${BIBlue}│  [ 1 ]  \033[1;37mDomain nama.gekastore.me          ${NC}"                                        
lane_bawah
until [[ $domain2 =~ ^[1-5]+$ ]]; do 
read -p "   Please select numbers 1 sampai 1 : " domain2
done
fi
if [[ $domain2 == "1" ]]; then
clear
lane_atas
echo -e  "${BIBlue}│  \033[1;37mContoh subdomain nama.gekastore.me        ${BIBlue}│${NC}"
echo -e  "${BIBlue}│    \033[1;37mnama jadi subdomain kamu              ${BIBlue}│${NC}"
lane_bawah
echo " "
until [[ $dn1 =~ ^[a-zA-Z0-9_.-]+$ ]]; do
read -rp "Masukan subdomain kamu Disini tanpa spasi : " -e dn1
done
rm -rf /etc/xray
rm -rf /etc/v2ray
rm -rf /etc/nsdomain
rm -rf /etc/per
mkdir -p /etc/xray
mkdir -p /etc/v2ray
mkdir -p /etc/nsdomain
mkdir -p /etc/per
touch /etc/per/id
touch /etc/per/token
touch /etc/xray/domain
touch /etc/v2ray/domain
touch /etc/xray/slwdomain
touch /etc/v2ray/scdomain
echo "$dn1" > /root/subdomainx
cd
sleep 1
fun_bar 'domain_setup'
clear
rm /root/subdomainx
fi

inst_tools(){
cd
sysctl -w net.ipv6.conf.all.disable_ipv6=1 >/dev/null 2>&1
sysctl -w net.ipv6.conf.default.disable_ipv6=1 >/dev/null 2>&1
clear
wget https://raw.githubusercontent.com/edydevelopeler/EdYPlerJomMoxXZBbanGetv7/main/tools.sh &> /dev/null
chmod +x tools.sh >/dev/null 2>&1
bash tools.sh >/dev/null 2>&1
clear
start=$(date +%s)
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
apt install git curl -y >/dev/null 2>&1
apt install python -y >/dev/null 2>&1
}
inst_ssh(){
  wget https://raw.githubusercontent.com/edydevelopeler/EdYPlerJomMoxXZBbanGetv7/main/install/ssh-vpn.sh && chmod +x ssh-vpn.sh && ./ssh-vpn.sh >/dev/null 2>&1
}
inst_xray(){
  wget https://raw.githubusercontent.com/edydevelopeler/EdYPlerJomMoxXZBbanGetv7/main/install/ins-xray.sh && chmod +x ins-xray.sh && ./ins-xray.sh >/dev/null 2>&1
}
inst_ws(){
  wget https://raw.githubusercontent.com/edydevelopeler/EdYPlerJomMoxXZBbanGetv7/main/sshws/insshws.sh && chmod +x insshws.sh && ./insshws.sh >/dev/null 2>&1
}
inst_backup(){
  wget https://raw.githubusercontent.com/edydevelopeler/EdYPlerJomMoxXZBbanGetv7/main/install/set-br.sh && chmod +x set-br.sh && ./set-br.sh >/dev/null 2>&1
}
inst_ohp(){
  wget https://raw.githubusercontent.com/edydevelopeler/EdYPlerJomMoxXZBbanGetv7/main/sshws/ohp.sh && chmod +x ohp.sh && ./ohp.sh >/dev/null 2>&1
}
inst_extramenu(){
  wget https://raw.githubusercontent.com/edydevelopeler/EdYPlerJomMoxXZBbanGetv7/main/update.sh && chmod +x update.sh && ./update.sh >/dev/null 2>&1
}
inst_slowdns(){
  wget https://raw.githubusercontent.com/edydevelopeler/EdYPlerJomMoxXZBbanGetv7/main/slowdns/installsl.sh && chmod +x installsl.sh && bash installsl.sh >/dev/null 2>&1
}
inst_udp(){
  wget https://raw.githubusercontent.com/edydevelopeler/EdYPlerJomMoxXZBbanGetv7/main/install/udp-custom.sh && chmod +x udp-custom.sh && bash udp-custom.sh >/dev/null 2>&1
}
inst_noobz(){
  wget https://raw.githubusercontent.com/edydevelopeler/EdYPlerJomMoxXZBbanGetv7/main/noobz/noobzvpns.zip >/dev/null 2>&1
  unzip noobzvpns.zip >/dev/null 2>&1
  chmod +x noobzvpns/*
  cd noobzvpns
  bash install.sh >/dev/null 2>&1
  rm -rf noobzvpns
  systemctl restart noobzvpns
}
inst_limitxray(){
  wget https://raw.githubusercontent.com/edydevelopeler/EdYPlerJomMoxXZBbanGetv7/main/bin/limit.sh && chmod +x limit.sh && ./limit.sh >/dev/null 2>&1
}
inst_trojan(){
  wget https://raw.githubusercontent.com/edydevelopeler/EdYPlerJomMoxXZBbanGetv7/main/install/ins-trgo.sh && chmod +x ins-trgo.sh && ./ins-trgo.sh >/dev/null 2>&1
}

start_instalasi

}

function start_instalasi(){
lane_atas
echo -e "${BIBlue}│ ${BGCOLOR}         PROCCESS INSTALL TOOLS         ${NC}${BIBlue} │${NC}"
lane_bawah
fun_bar 'inst_tools'

lane_atas
echo -e "${BIBlue}│ ${BGCOLOR}     PROCCESS INSTALL SSH & OVPN        ${NC}${BIBlue} │${NC}"
lane_bawah
fun_bar 'inst_ssh'

lane_atas
echo -e "${BIBlue}│ ${BGCOLOR}         PROCCESS INSTALL XRAY          ${NC}${BIBlue} │${NC}"
lane_bawah
fun_bar 'inst_xray'

lane_atas
echo -e "${BIBlue}│ ${BGCOLOR}     PROCCESS INSTALL WEBSOCKET SSH     ${NC}${BIBlue} │${NC}"
lane_bawah
fun_bar 'inst_ws'

lane_atas
echo -e "${BIBlue}│ ${BGCOLOR}      PROCCESS INSTALL BACKUP MENU      ${NC}${BIBlue} │${NC}"
lane_bawah
fun_bar 'inst_backup'

lane_atas
echo -e "${BIBlue}│ ${BGCOLOR}          PROCCESS INSTALL OHP          ${NC}${BIBlue} │${NC}"
lane_bawah
fun_bar 'inst_ohp'

lane_atas
echo -e "${BIBlue}│ ${BGCOLOR}      PROCCESS INSTALL EXTRA MENU       ${NC}${BIBlue} │${NC}"
lane_bawah
fun_bar 'inst_extramenu'
clear
lane_atas
echo -e "${BIBlue}│ ${BGCOLOR}      PROCCESS INSTALL BACKUP MENU      ${NC}${BIBlue} │${NC}"
lane_bawah
fun_bar 'inst_backup'

lane_atas
echo -e "${BIBlue}│ ${BGCOLOR}       PROCCESS INSTALL SLOW DNS        ${NC}${BIBlue} │${NC}"
lane_bawah
fun_bar 'inst_slowdns'

lane_atas
echo -e "${BIBlue}│ ${BGCOLOR}      PROCCESS INSTALL UDP CUSTOM       ${NC}${BIBlue} │${NC}"
lane_bawah
fun_bar 'inst_udp'

lane_atas
echo -e "${BIBlue}│ ${BGCOLOR}       PROCCESS INSTALL NOOBZVPNS       ${NC}${BIBlue} │${NC}"
lane_bawah
fun_bar 'inst_noobz'

lane_atas
echo -e "${BIBlue}│ ${BGCOLOR}      PROCCESS INSTALL LIMIT XRAY       ${NC}${BIBlue} │${NC}"
lane_bawah
fun_bar 'inst_limitxray'

lane_atas
echo -e "${BIBlue}│ ${BGCOLOR}       PROCCESS INSTALL TROJAN-GO       ${NC}${BIBlue} │${NC}"
lane_bawah
fun_bar 'inst_trojan'
}
instalasi
function iinfo(){
domain=$(cat /etc/xray/domain)
TIMES="10"
CHATID="-1002047467153"
KEY="6963918712:AAGgsUertEe6RumSsHw76ktmVHunVTNxTuY"
URL="https://api.telegram.org/bot$KEY/sendMessage"
TIME=$(date '+%d %b %Y')
RAMMS=$(free -m | awk 'NR==2 {print $2}')
MODEL2=$(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')
MYIP=$(curl -sS ipv4.icanhazip.com)
IZIN=$(curl -sS https://raw.githubusercontent.com/edydevelopeler/D4l4NWeDus/main/ip | grep $MYIP | awk '{print $3}' )
d1=$(date -d "$IZIN" +%s)
d2=$(date -d "$today" +%s)
USRSC=$(wget -qO- https://raw.githubusercontent.com/edydevelopeler/D4l4NWeDus/main/ip | grep $MYIP | awk '{print $2}')
EXPSC=$(wget -qO- https://raw.githubusercontent.com/edydevelopeler/D4l4NWeDus/main/ip | grep $MYIP | awk '{print $3}')
TEXT="
<code>🧿───────────────────🧿</code>
<b> INSTALL AUTOSCRIPT PREMIUM</b>
<code>🧿───────────────────🧿</code>
<code>ID   : </code><code>$USRSC</code>
<code>Date : </code><code>$TIME</code>
<code>Exp  : </code><code>$EXPSC</code>
<code>ISP  : </code><code>$ISP</code>
<code>🧿───────────────────🧿</code>
<i>Automatic Notification from Github</i>
"'&reply_markup={"inline_keyboard":[[{"text":"ᴏʀᴅᴇʀ","url":"https://t.me/lunoxximpostor"},{"text":"WA","url":"https://wa.me/6287760204418"}]]}'

curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
clear
}

cat> /root/.profile << END
if [ "$BASH" ]; then
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi
fi
mesg n || true
clear
menu
END
chmod 644 /root/.profile
if [ -f "/root/log-install.txt" ]; then
rm /root/log-install.txt > /dev/null 2>&1
fi
if [ -f "/etc/afak.conf" ]; then
rm /etc/afak.conf > /dev/null 2>&1
fi
if [ ! -f "/etc/log-create-user.log" ]; then
echo "Log All Account " > /etc/log-create-user.log
fi
history -c
serverV=$( curl -sS https://raw.githubusercontent.com/edydevelopeler/EdYPlerJomMoxXZBbanGetv7/main/versi  )
echo $serverV > /opt/.ver
aureb=$(cat /home/re_otm)
b=11
if [ $aureb -gt $b ]
then
gg="PM"
else
gg="AM"
fi
cd
rm /root/setup.sh >/dev/null 2>&1
rm /root/slhost.sh >/dev/null 2>&1
rm /root/ssh-vpn.sh >/dev/null 2>&1
rm /root/ins-xray.sh >/dev/null 2>&1
rm /root/insshws.sh >/dev/null 2>&1
rm /root/set-br.sh >/dev/null 2>&1
rm /root/ohp.sh >/dev/null 2>&1
rm /root/update.sh >/dev/null 2>&1
rm /root/slowdns.sh >/dev/null 2>&1
rm -rf /etc/noobz
mkdir -p /etc/noobz
echo "" > /etc/xray/noob

cat <<EOF>> /etc/rmbl/theme/green
BG : \E[40;1;42m
TEXT : \033[0;32m
EOF
cat <<EOF>> /etc/rmbl/theme/yellow
BG : \E[40;1;43m
TEXT : \033[0;33m
EOF
cat <<EOF>> /etc/rmbl/theme/red
BG : \E[40;1;41m
TEXT : \033[0;31m
EOF
cat <<EOF>> /etc/rmbl/theme/blue
BG : \E[40;1;44m
TEXT : \033[0;34m
EOF
cat <<EOF>> /etc/rmbl/theme/magenta
BG : \E[40;1;45m
TEXT : \033[0;35m
EOF
cat <<EOF>> /etc/rmbl/theme/cyan
BG : \E[40;1;46m
TEXT : \033[0;36m
EOF
cat <<EOF>> /etc/rmbl/theme/lightgray
BG : \E[40;1;47m
TEXT : \033[0;37m
EOF
cat <<EOF>> /etc/rmbl/theme/darkgray
BG : \E[40;1;100m
TEXT : \033[0;90m
EOF
cat <<EOF>> /etc/rmbl/theme/lightred
BG : \E[40;1;101m
TEXT : \033[0;91m
EOF
cat <<EOF>> /etc/rmbl/theme/lightgreen
BG : \E[40;1;102m
TEXT : \033[0;92m
EOF
cat <<EOF>> /etc/rmbl/theme/lightyellow
BG : \E[40;1;103m
TEXT : \033[0;93m
EOF
cat <<EOF>> /etc/rmbl/theme/lightblue
BG : \E[40;1;104m
TEXT : \033[0;94m
EOF
cat <<EOF>> /etc/rmbl/theme/lightmagenta
BG : \E[40;1;105m
TEXT : \033[0;95m
EOF
cat <<EOF>> /etc/rmbl/theme/lightcyan
BG : \E[40;1;106m
TEXT : \033[0;96m
EOF
cat <<EOF>> /etc/rmbl/theme/color.conf
lightcyan
EOF

sleep 3
echo  ""
cd
iinfo
rm -rf *
lane_atas
echo -e "${BIBlue}│ ${BGCOLOR} INSTALL SCRIPT SELESAI..                 ${NC}${BIBlue} │${NC}"
lane_bawah
echo  ""
sleep 4
clear
reboot
