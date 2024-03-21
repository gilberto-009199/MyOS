#!/bin/bash
# utilize um link simbolico ln -s Área\ de tranalho para desktop
# para resolver erros a respeito do caminho da pasta do sistema e compilador

# Variaveis

# DIR Fontes do sistema
DIR_OS="$DIR_SYSTEM/sources";
# DIR das Dependencias
DIR_DEPENDENCIAS="$DIR_SYSTEM/dependences";
# DIR das Ferramentas de Desenvolvimento
DIR_SCRIPTS="$DIR_SYSTEM/scripts";

# DIR das Ferramentas de Desenvolvimento
DIR_TOOLS="$DIR_SYSTEM/tools";
# DIR do compilador do Sistema
DIR_COMPILADOR="$DIR_TOOLS/compile";

print_raw " Verificando e configurando.";

#Verificando se a pasta do compilador existe
# Verificar a menssagem do usuario 
if [ ! -d "$DIR_COMPILADOR/build" ];
 then
   echo " [ WARN ] Diretorio do Compilador ausente!";
   echo "Execute a compilação e determine o prefix como:"
   echo "./configure --prefix=\"$DIR_COMPILADOR/build\"";

   echo "Eu posso baixar e compilar o crosstool-ng";
   read -p "Deseja que eu baixe e compile para vc? (s/n)}> " isCompilar;
   if [ isCompilar=="s" ];
     then
       print_raw "Iniciando $DIR_SCRIPTS/compilador.sh....";
       source "$DIR_SCRIPTS/compilador.sh";
   fi
 else
   echo " [ OK ] Diretorio do compilador";
fi
