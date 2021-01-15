#!/bin/bash

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
