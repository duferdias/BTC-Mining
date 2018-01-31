#!/bin/sh -
clear
# Miner por: JayDDee | CPUMiner-OPT v3.8.0
# Script base: AndreasBlk, BYETFAST, Darkstilo, FENIX_LINUX e SSH TLS
# Editado por duferdias

# Este script foi desenvolvido para execução em ambiente Linux.
# Configura a mineração de modo que os hashes são enviados à 
# ytn.misosi.ru através de um servidor proxy.

# Este script também pode ser executado automaticamente junto
# com a inicialização do sistema.

#-----------------
bash=$(echo $BASH)

if [ "$bash" = "/bin/bash" ]
then
exit 0
fi

ipdomain=$1
uName_wName=$2
IPdominio_exemplo=meudominio.web
uName_wName_exemplo=devminer.dvmr

if [ "$1" = ""  ] && [ "$2" = ""  ]
then
echo "		\033[41;1;37m Minerar Yenten com CPUMiner-OPT v3.8.0 via Stratum Proxy \033[0m"				
sleep
echo "\033[34mForma de uso:\033[0m"
echo "sudo sh $0 \033[31m IP ou Domínio\033[32m usuário.id-minerador\033[0m \n"
echo "\033[33mExemplo:\033[0m"
echo "sudo sh $0 \033[31m $IPdominio_exemplo\033[32m $uName_wName_exemplo\033[0m \n"
exit 0
fi

echo "		\033[41;1;37m Minerar Yenten com CPUMiner-OPT v3.8.0 via Stratum Proxy \033[0m"	
sleep 1
echo "DOMÍNIO, USUÁRIO E ID-MINERADOR CONFIGURADOS:\033[01;32m $ipdomain $uName_wName\033[0m"
sleep 1
echo "\033[01;31m Minerar Yenten com CPUMiner-OPT v3.8.0 via Stratum Proxy  https://ytn.misosi.ru \033[0m \n"
sleep 1

echo "\033[44;1;37m  Este script irá baixar, compilar e instalar o CPUMiner-OPT v3.8.0.  \033[0m"
echo "\033[44;1;37m           Ao término, a mineração iniciará automaticamente.          \033[0m"
sleep 10
clear

echo "\033[44;1;37mAtualizando lista de pacotes...\033[0m"
sudo apt-get update > /dev/null
sleep 2
clear

echo "\033[44;1;37mInstalando dependências...\033[0m"
sudo apt-get install screen -y > /dev/null
sudo apt-get install build-essential libssl-dev libcurl4-openssl-dev libjansson-dev libgmp-dev autoconf automake -y > /dev/null
memsize=`free | awk '/Mem/ { print $2 }'`
swapsize=`free | awk '/Swap/ { print $2 }'`
if [ "$memsize" -lt "1000000" ]
then
 if [ "$swapsize" -eq "0" ]
 then
  echo "Foi detectado que você possui menos que 1GB de RAM"
  echo "Será criada uma partição SWAP de 1GB para que o CPUMiner-OPT seja compilado com sucesso"
  sudo dd if=/dev/zero of=/var/swap.img bs=1024k count=1000 > /dev/null
  sudo mkswap /var/swap.img > /dev/null
  sudo chmod 600 /var/swap.img
  sudo swapon /var/swap.img
 fi
fi
sleep 2
clear

echo "\033[44;1;37mBaixando CPUMiner-OPT v3.8.0...\033[0m"
wget -q https://github.com/JayDDee/cpuminer-opt/archive/v3.8.0.tar.gz
sleep 2
clear

echo "\033[44;1;37mExtraindo CPUMiner-OPT v3.8.0...\033[0m"
tar -zxvf v3.8.0.tar.gz > /dev/null
cd cpuminer-opt-3.8.0
sleep 2
clear

echo "\033[44;1;37mCompilando CPUMiner-OPT v3.8.0...(pode demorar um pouco)\033[0m"
./build.sh > /dev/null
ln ./cpuminer ../cpuminer
sleep 2
clear

echo "\033[01;32mInstalação e configuração concluídas com sucesso."
sleep 3
clear

echo "\033[44;1;37m       A mineração será iniciada em uma nova sessão.     \033[0m"
echo "\033[44;1;37m           NÃO FECHE A JANELA DO CONSOLE AGORA!          \033[0m"
echo "\033[44;1;37m     Feche a janela do web-console ou de seu aplicativo  \033[0m"
echo "\033[44;1;37m  para acesso remoto somente após o início da mineração. \033[0m \n"
sleep 3
echo "Faça login em sua conta e acompanhe o status de sua mineração em:"
echo "https://ytn.misosi.ru/index.php?page=login"
sleep 17
clear

echo "\033[37;41mAbrindo sessão, aguarde...\033[0m"
sleep 3
sudo screen -dmS misosisp ./cpuminer -a yescryptr16 -o stratum+tcp://$ipdomain:16012 -u $uName_wName -p x
sleep 2
clear

echo "\033[37;41mSua mineração foi iniciada! Para visualizar o processo digite o comando abaixo:\033[01;0m \n"
echo "\033[37;41mCOMANDO [screen -x misosisp]\033[0m"
sleep 1