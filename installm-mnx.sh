#!/bin/sh -
clear
# Miner por: Racquemis | MxMiner v0.17a
# Script base: AndreasBlk, BYETFAST, Darkstilo, FENIX_LINUX e SSH TLS
# Editado por duferdias

# Este script foi desenvolvido para execução em ambiente Linux.
# Pode ser executado automaticamente junto com a inicialização do sistema.

#-----------------
bash=$(echo $BASH)

if [ "$bash" = "/bin/bash" ]
then
exit 0
fi

wallet=$1
workerName=$2
carteira_exemplo=YyyXXxx111YyyXXxx111YyyXXxx111YyyW
usuario_miner=wName

if [ "$1" = ""  ] && [ "$2" = ""  ]
then
echo "		\033[41;1;37m Minerar Minexcoin com MxMiner v0.17a \033[0m"				
sleep
echo "\033[34mForma de uso:\033[0m"
echo "sudo sh $0 \033[31m Carteira de Minexcoin\033[32m Usuário Minerador\033[0m \n"
echo "\033[33mExemplo:\033[0m"
echo "sudo sh $0 \033[31m $carteira_exemplo\033[32m $usuario_miner\033[0m \n"
exit 0
fi

echo "		\033[41;1;37m Minerar Minexcoin com MxMiner v0.17a \033[0m"	
sleep 1
echo "CARTEIRA E USUÁRIO MINER CONFIGURADOS:\033[01;32m $wallet.$workerName\033[0m"
sleep 1
echo "\033[01;31mMinerar Minexcoin com MxMiner v0.17a  http://eu.minexpool.nl \033[0m \n"
sleep 1

echo "\033[44;1;37m    Este script irá baixar e executar o MxMiner v0.17a.    \033[0m"
echo "\033[44;1;37m  Ao ser executado, a mineração iniciará automaticamente.  \033[0m "
sleep 10
clear

echo "\033[44;1;37mAtualizando lista de pacotes...\033[0m"
sudo apt-get update > /dev/null
sleep 2
memsize=`free | awk '/Mem/ { print $2 }'`
swapsize=`free | awk '/Swap/ { print $2 }'`
if [ "$memsize" -lt "1000000" ]
then
 if [ "$swapsize" -eq "0" ]
 then
  echo "Foi detectado que você possui menos que 1GB de RAM"
  echo "Será criada uma partição SWAP de 1GB para que não ocorra travamentos no sistema"
  sudo dd if=/dev/zero of=/var/swap.img bs=1024k count=1000 > /dev/null
  sudo mkswap /var/swap.img > /dev/null
  sudo chmod 600 /var/swap.img
  sudo swapon /var/swap.img
 fi
fi
sleep 2
clear

echo "\033[44;1;37mBaixando MxMiner v0.17a...\033[0m"
wget -q https://github.com/duferdias/MxMiner/archive/v0.17a.tar.gz
sleep 2
clear

echo "\033[44;1;37mExtraindo MxMiner v0.17a...\033[0m"
tar -zxvf v0.17a.tar.gz > /dev/null
cd MxMiner-0.17a
sudo chmod +x mxminer 
sleep 2
clear

echo "\033[01;32mDownload e configuração concluídas com sucesso."
sleep 3
clear

echo "\033[44;1;37m       A mineração será iniciada em uma nova sessão.     \033[0m"
echo "\033[44;1;37m           NÃO FECHE A JANELA DO CONSOLE AGORA!          \033[0m"
echo "\033[44;1;37m     Feche a janela do web-console ou de seu aplicativo  \033[0m"
echo "\033[44;1;37m  para acesso remoto somente após o início da mineração. \033[0m \n"
sleep 3
echo "Acompanhe o status de sua mineração em: http://eu.minexpool.nl/workers/$wallet"
sleep 12
clear

echo "\033[37;41mAbrindo sessão, aguarde...\033[0m"
sleep 3
sudo screen -dmS minexpool ./mxminer -l eu -u $wallet.$workerName -z -nf 
sleep 2
clear

echo "\033[37;41mSua mineração foi iniciada! Para visualizar o processo digite o comando abaixo:\033[01;0m \n"
echo "\033[37;41mCOMANDO [screen -x minexpool]\033[0m"
sleep 1
