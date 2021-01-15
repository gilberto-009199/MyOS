#!/bin/bash

# Carregando o banner
cat ~/banner

# Variaveis de trabalho
work="$HOME/Desktop/My/";
#work="/opt/workspace";
#Variaveis de informacoes
terminal="\e[1;31m $SHELL\e[0m";
usuario="\e[1;31m $USER\e[0m";
workspace="\e[1;31m $work\e[0m";
# Nome dos Comandos
comandowork="\e[1;35m work \e[0m";
comandomais="\e[1;35m mais \e[0m";
comandosincronizar="\e[1;35m sincronizar <dir> <dir> \e[0m";
# Menssagem do dia kkkk
echo -e "\e[1;36m Bem-vindo, $usuario \e[0m";
echo -e "\e[1;36m Shell: $terminal \e[0m";
echo -e "\e[1;36m Work: $workspace \e[0m";
echo -e "\e[1;36m Para ir Digite: $comandowork \e[0m";
#echo -e "\e[1;36m Para Mais Digite: $comandomais \e[0m";


work(){
  cd "$work";
}
mais(){
  echo -e "\e[1;36m Comandos adicionais: \e[0m";
  echo -e "\e[1;36m  +$comandosincronizar \e[0m";
  echo -e "\e[1;36m      Sincroniza 2 diretorios \e[0m";
  echo -e "\e[1;36m  +$comandosincronizar \e[0m";
  echo -e "\e[1;36m       Salva diretorio em um arquivo .img \e[0m";
}
g_isDir(){
	isExists=1;

	if [ ! -d "$1" ];
	  then
	    echo "Diretorio $1 inexistente!";
  	    read -p "Deseja que eu Crie para vc? (s/n)}> " isCreateDir;
	    if [ "$isCreateDir" == "s" ]; then
		mkdir "$1";
		isExists=0;
	    fi
	  else
	    isExists=0;
	fi
	return $isExists;
}
sincronizar(){ 
#	-r => recursividade
#	-H => preservar hardlinks
#	-u,--update => update only (don't overwrite newer files)
#	--progress => mostrar progresso da operacao
	
	g_isDir $1;
	if [ $? -eq 0 ];
	  then
	    echo "[ OK ] $2";
 	  else
	    read -p "Um erro ocorreu! Deseja ignorar?(s/n)}> " ignorar;
	    if [ ! "$ignorar" == "s" ]; then
		echo " A funcao g_isDir retornou um erro!";
		return 1;
	    fi
	fi
	g_isDir $2;
	if [ $? -eq 0 ];
	  then
	    echo "[ OK ] $2";
 	  else
	    read -p "Um erro ocorreu! Deseja ignorar?(s/n)}> " ignorar;
	    if [ ! "$ignorar" == "s" ]; then
		echo "A funcao g_isDir retornou um erro!";
		return 1;
	    fi
	fi

	#rsync -rhu --progress "$1/" "$2/"
	#rsync -rhu --progress "$2/" "$1/"

}

if [ -d "/home/$USER/bin/" ];
  then
    export PATH="/home/$USER/bin/:$PATH";
  else
    echo "Não encontrei!/bin";
fi

# HOOKS do asdf, se estiver instalado
[[ -f ~/.asdf/asdf.sh ]] && source ~/.asdf/asdf.sh
[[ -f ~/.asdf/completions/asdf.bash ]] && source ~/.asdf/completions/asdf.bash
