#!/bin/bash
echo "=================================================="
echo "   _  ______  ___  __________________";
echo "  __				                         ";
echo "  	___		                           ";
echo "				                        	   ";
echo -e "\e[0m"
echo "=================================================="


sleep 2

# DEGISKENLER by gumusbey
OLLO_WALLET=wallet
OLLO=ollod
OLLO_ID=ollo-testnet-0
OLLO_PORT=15
OLLO_FOLDER=.ollo
OLLO_FOLDER2=ollo
OLLO_VER=
OLLO_REPO=https://github.com/OLLO-Station/ollo
OLLO_GENESIS=https://raw.githubusercontent.com/OllO-Station/ollo/master/networks/ollo-testnet-0/genesis.json
OLLO_ADDRBOOK=https://raw.githubusercontent.com/OllO-Station/ollo/master/networks/ollo-testnet-0/addrbook.json
OLLO_MIN_GAS=0
OLLO_DENOM=utia
OLLO_SEEDS=
OLLO_PEERS=45acf9ea2f2d6a2a4b564ae53ea3004f902d3fb7@185.182.184.200:26656,62b5364abdfb7c0934afaddbd0704acf82127383@65.108.13.185:27060,f599dcd0a09d376f958910982d82351a6f8c178b@95.217.118.96:26878

sleep 1

echo "export OLLO_WALLET=${OLLO_WALLET}" >> $HOME/.bash_profile
echo "export OLLO=${OLLO}" >> $HOME/.bash_profile
echo "export OLLO_ID=${OLLO_ID}" >> $HOME/.bash_profile
echo "export OLLO_PORT=${OLLO_PORT}" >> $HOME/.bash_profile
echo "export OLLO_FOLDER=${OLLO_FOLDER}" >> $HOME/.bash_profile
echo "export OLLO_FOLDER2=${OLLO_FOLDER2}" >> $HOME/.bash_profile
echo "export OLLO_VER=${OLLO_VER}" >> $HOME/.bash_profile
echo "export OLLO_REPO=${OLLO_REPO}" >> $HOME/.bash_profile
echo "export OLLO_GENESIS=${OLLO_GENESIS}" >> $HOME/.bash_profile
echo "export OLLO_PEERS=${OLLO_PEERS}" >> $HOME/.bash_profile
echo "export OLLO_SEED=${OLLO_SEED}" >> $HOME/.bash_profile
echo "export OLLO_MIN_GAS=${OLLO_MIN_GAS}" >> $HOME/.bash_profile
echo "export OLLO_DENOM=${OLLO_DENOM}" >> $HOME/.bash_profile
source $HOME/.bash_profile

sleep 1

if [ ! $OLLO_NODENAME ]; then
	read -p "TYPE NODE NAME: " OLLO_NODENAME
	echo 'export OLLO_NODENAME='$OLLO_NODENAME >> $HOME/.bash_profile
fi

echo -e "NODE ID: \e[1m\e[32m$OLLO_NODENAME\e[0m"
echo -e "WALLET NAME: \e[1m\e[32m$OLLO_WALLET\e[0m"
echo -e "CHAIN ID: \e[1m\e[32m$OLLO_ID\e[0m"
echo -e "CHANGE PORT NUMBER: \e[1m\e[32m$OLLO_PORT\e[0m"
echo '================================================='

sleep 2


# INSTALLING UPDATES
echo -e "\e[1m\e[32m1. INSTALLING UPDATES... \e[0m" && sleep 1
sudo apt update && sudo apt upgrade -y


# LOADING REQUIREMENTS
echo -e "\e[1m\e[32m2. LOADING REQUIREMENTS... \e[0m" && sleep 1
sudo apt install curl tar wget clang pkg-config libssl-dev jq build-essential bsdmainutils git make ncdu gcc git jq chrony liblz4-tool -y

# INSTALLING GO
echo -e "\e[1m\e[32m1. INSTALLING GO... \e[0m" && sleep 1
ver="1.18.2"
cd $HOME
wget "https://golang.org/dl/go$ver.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$ver.linux-amd64.tar.gz"
rm "go$ver.linux-amd64.tar.gz"
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> ~/.bash_profile
source ~/.bash_profile
go version

sleep 1

# REPO DOWNLOADING
echo -e "\e[1m\e[32m1. REPO DOWNLOADING... \e[0m" && sleep 1
cd $HOME
git clone $OLLO_REPO
cd $OLLO_FOLDER2
make install

sleep 1

# CONFIGURATION
echo -e "\e[1m\e[32m1. SETTING CONFIGURATIONS... \e[0m" && sleep 1
$OLLO config chain-id $OLLO_ID
$OLLO config keyring-backend file
$OLLO init $OLLO_NODENAME --chain-id $OLLO_ID

# ADDRBOOK and GENESIS SETTING
# wget $OLLO_GENESIS -O $HOME/$OLLO_FOLDER/config/genesis.json
curl https://raw.githubusercontent.com/OllO-Station/ollo/master/networks/ollo-testnet-0/genesis.json | jq .result.genesis > $HOME/.ollo/config/genesis.json
wget $OLLO_ADDRBOOK -O $HOME/$OLLO_FOLDER/config/addrbook.json

# SETTING PEERS and SEEDS
SEEDS="$OLLO_SEEDS"
PEERS="$OLLO_PEERS"
sed -i -e "s/^seeds *=.*/seeds = \"$SEEDS\"/; s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" $HOME/$OLLO_FOLDER/config/config.toml

sleep 1


# config pruning
pruning="custom"
pruning_keep_recent="100"
pruning_keep_every="0"
pruning_interval="50"
sed -i -e "s/^pruning *=.*/pruning = \"$pruning\"/" $HOME/$OLLO_FOLDER/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" $HOME/$OLLO_FOLDER/config/app.toml
sed -i -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" $HOME/$OLLO_FOLDER/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" $HOME/$OLLO_FOLDER/config/app.toml


# PORTS CHANGE
sed -i.bak -e "s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:${OLLO_PORT}658\"%; s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://127.0.0.1:${OLLO_PORT}657\"%; s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:${OLLO_PORT}060\"%; s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:${OLLO_PORT}656\"%; s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":${OLLO_PORT}660\"%" $HOME/$OLLO_FOLDER/config/config.toml
sed -i.bak -e "s%^address = \"tcp://0.0.0.0:1317\"%address = \"tcp://0.0.0.0:${OLLO_PORT}317\"%; s%^address = \":8080\"%address = \":${OLLO_PORT}080\"%; s%^address = \"0.0.0.0:9090\"%address = \"0.0.0.0:${OLLO_PORT}090\"%; s%^address = \"0.0.0.0:9091\"%address = \"0.0.0.0:${OLLO_PORT}091\"%" $HOME/$OLLO_FOLDER/config/app.toml
sed -i.bak -e "s%^node = \"tcp://localhost:26657\"%node = \"tcp://localhost:${OLLO_PORT}657\"%" $HOME/$OLLO_FOLDER/config/client.toml

# PROMETHEUS ACTIVATION
sed -i -e "s/prometheus = false/prometheus = true/" $HOME/$OLLO_FOLDER/config/config.toml

# MINIMUM GAS PRICE
sed -i -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0.00125$OLLO_DENOM\"/" $HOME/$OLLO_FOLDER/config/app.toml

# INDEXER DISABLE
indexer="null" && \
sed -i -e "s/^indexer *=.*/indexer = \"$indexer\"/" $HOME/$OLLO_FOLDER/config/config.toml

# RESET
$OLLO tendermint unsafe-reset-all --home $HOME/$OLLO_FOLDER

echo -e "\e[1m\e[32m4. CREATING SERVICE... \e[0m" && sleep 1
# create service
sudo tee /etc/systemd/system/$OLLO.service > /dev/null <<EOF
[Unit]
Description=$OLLO
After=network.target
[Service]
Type=simple
User=$USER
ExecStart=$(which $OLLO) start
Restart=on-failure
RestartSec=10
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF


# SERVICES RESTART
sudo systemctl daemon-reload
sudo systemctl enable $OLLO
sudo systemctl restart $OLLO

echo '=============== KURULUM TAMAM! by gumusbey==================='
echo -e 'CHECK LOGS: \e[1m\e[32mjournalctl -fu ollod -o cat\e[0m'
echo -e "SYNC STATUS: \e[1m\e[32mcurl -s localhost:${OLLO_PORT}657/status | jq .result.sync_info\e[0m"

source $HOME/.bash_profile
