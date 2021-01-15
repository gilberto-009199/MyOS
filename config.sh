#!/bin/bash

clear
# DIR Area de Trabalho do sistema( WorkSpace )
Ambiente=`pwd`;
# DIR Scripts
DIR_SCRIPTS="${Ambiente}/scripts";
# DIR Documentacao
DIR_DOCUMENTAO="${Ambiente}/doc";
# DIR OS
DIR_SYSTEM="${Ambiente}/system";

# Funcoes de placeholder
MSG="";
print_raw(){
   echo -e "$1";
}
util_cor_verde(){ MSG="\e[1;32m$1\e[0m"; }
util_cor_vermelha(){ MSG="\e[1;31m$1\e[0m"; }
util_cor_azul(){ MSG="\e[1;36m$1\e[0m"; }
util_cor_roxa(){ MSG="\e[1;35m$1\e[0m"; }

# Menssagem do Dia kk(Banner Motd)
[[ -f "$DIR_DOCUMENTAO/banner" ]] && cat "$DIR_DOCUMENTAO/banner";

# Verificando dependencias base
if [ ! -d "$DIR_SCRIPTS" ];
   then
	print_raw " Diretorio de Dependencia Inexistente!";
	util_cor_vermelha "$DIR_DOCUMENTAO";
	print_raw " Baixando para $?!";
   else
	echo -e " [ \e[1;32mOK\e[0m ] Diretorio dos Scripts!";
	if [ -f "$DIR_SCRIPTS/util.sh" ];
	   then
		source "$DIR_SCRIPTS/util.sh";
	   else
 		print_raw " SCRIPT Inexistente!";
		util_cor_vermelha "$DIR_SCRIPTS/util.sh";
		print_raw " Baixando para $MSG";
	fi
fi

if [ ! -d "$DIR_DOCUMENTAO" ];
   then
	print_raw " Diretorio Inexistente!";
	util_cor_vermelha "$DIR_DOCUMENTAO";
	print_raw " Baixando para $MSG ";
	mkdir -f "$DIR_DOCUMENTAO";
   else
	util_cor_verde "OK"; 
	print_raw " [ $MSG ] Diretorio da Documentação!";
fi

if [ ! -d "$DIR_SYSTEM" ];
   then
	print_raw " Diretorio Inexistente!";
	util_cor_vermelha "$DIR_SYSTEM";
	print_raw " Criando Diretorio $MSG";
	mkdir -f " $DIR_SYSTEM";
   else
	util_cor_verde "OK"; 
	print_raw " [ $MSG ] Diretorio do Sistema!";
fi

if [ -f "$DIR_SYSTEM/config.sh" ];
   then
	util_cor_roxa "$DIR_SYSTEM/config.sh";
	print_raw " Iniciando $MSG ";
	source "$DIR_SYSTEM/config.sh";
   else
	print_raw " SCRIPT Inexistente!";
	util_cor_vermelha "$DIR_SYSTEM/config.sh";
	print_raw " Baixando para $MSG";
fi



