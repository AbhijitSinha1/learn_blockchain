#! /bin/bash
bold=$(tput bold)
normal=$(tput sgr0)

function help() {
  echo "usage setup.sh [OPTION]"
  echo -e "${bold}-b, --balance${normal}\t\tinitial balance provided to the account"
  echo -e "${bold}-c, --chain-id${normal}\t\ta unique number for each blockchain in the private network"
  echo -e "${bold}--connect${normal}\t\tconnect to an already exisiting block chain"
  echo -e "${bold}-d, --data-dir${normal}\t\tthe directory to store the blockchain data"
  echo -e "${bold}-port${normal}\t\t\tport"
  echo -e "${bold}-rpca, --rpc-api${normal}\trpc api"
  echo -e "${bold}-rpch, --rpc-host${normal}\trpc host"
  echo -e "${bold}-rpcp, --rpc-port${normal}\trpc port"
}

if [ $# == 0 ];
then
  help
  exit -1
fi

data=''
home=$( getent passwd "$USER" | cut -d: -f6 )
workspace="$home/blockchain"
chainId=`date +%s`
balance=0
rpcHost='localhost'
rpcPort=9999
rpcAPI='personal,db,eth,net,web3'
port=9998
difficulty=400
gasLimit=8000000
connect=0

while test $# -gt 0; do
  case $1 in
    -h|--help)
      help
      ;;
    -d|--data-dir)
      shift
      if [ $# == 0 ];
      then
        help
      else
	data=$1
      fi
      shift
      ;;
    -c|--chain-id)
      shift
      if [ $# == 0 ];
      then
        help
      else
        chainId=$1
      fi
      shift
      ;;
    -b|--balance)
      shift
      if [ $# == 0 ];
      then
        help
      else
        balance=$1
      fi
      shift
      ;;
    -rpch|--rpc-host)
      shift
      if [ $# == 0 ];
      then
        help
      else
        rpcHost=$1
      fi
      shift
      ;;
    -rpcp|--rpc-port)
      shift
      if [ $# == 0 ];
      then
        help
      else
        rpcPort=$1
      fi
      shift
      ;;
    -rpca|--rpc-api)
      shift
      if [ $# == 0 ];
      then
        help
      else
        rpcAPI=$1
      fi
      shift
      ;;
    -p|--port)
      shift
      if [ $# == 0 ];
      then
        help
      else
        port=$1
      fi
      shift
      ;;
    --connect)
      shift
      connect=1
      ;;
    *)
      break
      ;;
  esac
done

if [ -z $data ];
then
  help
  exit -1
fi

if [ $connect == 0 ];
then
  echo "workspace: $workspace, data dir: $data, chain id: $chainId, balance: $balance, rpc host: $rpcHost, rpc port: $rpcPort, rpc api: $rpcAPI, port: $port"

  mkdir -p $workspace

  echo -e "${bold}1/4 creating data directory: $workspace$data ${normal}"
  mkdir $workspace/$data

  echo "${bold}2/4 initiating a new account ${nromal}"
  geth --datadir $workspace/$data account new

  echo "${bold}3/4 generating genesis block ${normal}"

  echo -n "${bold}Address:  ${normal}"
  read -a account
  echo -n "${bold}Gas Limit: [0x8000000] ${normal}"
  read -a gasLimit
  echo -n "${bold}Difficulty: [0x400] ${normal}"
  read -a difficulty

  if [ -z $gasLimit ];
  then
    gasLimit='0x8000000'
  fi
  if [ -z $difficulty ];
  then
    difficulty='0x400'
  fi

  echo "{
    \"config\": {
      \"chainId\": $chainId,
      \"homesteadBlock\": 0,
      \"eip155Block\": 0,
      \"eip158Block\": 0
    },
    \"gasLimit\": \"$gasLimit\",
    \"difficulty\": \"$difficulty\",
    \"alloc\": {
      \"$account\": {
        \"balance\":\"$balance\"
      }
    }
  }" > $workspace/$data/genesis.json
fi

echo "${bold}4/4 initiating genesis block${normal}"

echo -n "${bold}API: [personal,db,eth,net,web3]${normal}"
read -a rpcAPI

if [ -z $rpcAPI ];
then
  rpcAPI="personal,db,eth,net,web3"
fi

geth --datadir $workspace/$data init $workspace/$data/genesis.json
geth --rpc --rpcport $rpcPort --rpcaddr $rpcHost --rpccorsdomain "*" --datadir $workspace/$data --port $port --rpcapi $rpcAPI --mine
