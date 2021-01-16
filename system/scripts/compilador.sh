#!/bin/bash

print_raw "Baixando.... Para $DIR_COMPILADOR/cross-ng ";

if [ ! -d "$DIR_COMPILADOR/cross-ng" ];
   then
     git clone https://github.com/crosstool-ng/crosstool-ng "$DIR_COMPILADOR/cross-ng"
     clear
     echo " [ OK ] Compilador Baixado!"
   else
     echo " [ OK ] Compilador Já baixado!"
fi

cd "$DIR_COMPILADOR/cross-ng";

if [ ! -e "$DIR_COMPILADOR/cross-ng/configure" ];
  then
  	echo " Executando pre montagem.... ";
    chmod +x "$DIR_COMPILADOR/cross-ng/bootstrap";
    exec "$DIR_COMPILADOR/cross-ng/bootstrap";
fi

echo "Executando configure.... ";
echo `pwd`;
./configure --prefix="$DIR_COMPILADOR/build";

#Verifica se a saida retornou 0 na execucao do configure
if [ $? -eq 1 ];
 then
    echo "Ocorreu uma falha no $DIR_COMPILADOR/cross-ng/configure"
    echo " Para solucinar:"
    echo "  1° Verifique se as dependencias estão instaladas no seu pc"
    echo "   ArchLinux:"
    echo "      sudo pacman -S help2man"
    echo "   Debian:"
    echo "      sudo apt-get install help2man"
    echo "  2° tente executar como root"
    echo "   No script: "
    echo "      sudo ./config.sh "
    echo "   No codigo fonte: "
    echo "      sudo .$DIR_COMPILADOR/cross-ng/configure"
    echo "  3° Entre em contato com o crosstool-ng";
  else
    echo " [ OK ] Configuracao feita!"
fi

echo " Executando Montagem e instalacao";

make
make install

if [ $? -eq 1 ];
 then
    echo "Ocorreu uma falha no make, make install"
    echo " Para solucinar:"
    echo "  1° Verifique se as dependencias estão instaladas no seu pc"
    echo "  2° tente executar em um diretorio diferente, Cuidado ao tentar executar"
    echo "     na area de trabalho ,pois o caminho pode ser quebrado"
    echo "  3° Entre em contato com o crosstool-ng";

fi

if [ ! -e "$DIR_COMPILADOR/build/bin/.config" ];
 then
   echo " [ WARN ] toolchain do Compilador não configurado!";

   read -p "Deseja configurar ou quer que eu use o meu Default? (default/config)}> " isConfig;
   if [ isCompilar=="default" ];
     then
       echo "Movendo arquivo de configuração";
       echo "$DIR_SCRIPTS/compilador/.config";
       cp "$DIR_SCRIPTS/compilador/.config" "$DIR_COMPILADOR/build/bin/.config";

       echo "CT_LOCAL_TARBALLS_DIR=\"$DIR_COMPILADOR/build/src" >> "$DIR_COMPILADOR/build/bin/.config";
       echo "CT_WORK_DIR=\"$DIR_COMPILADOR/build/.build" >> "$DIR_COMPILADOR/build/bin/.config";
       echo "CT_BUILD_TOP_DIR=\"\${CT_WORK_DIR:-\${CT_TOP_DIR}/.build}/\${CT_HOST:+HOST-\${CT_HOST}/}\${CT_TARGET}" >> "$DIR_COMPILADOR/build/bin/.config";
       echo "CT_BUILD_DIR=\"\${CT_BUILD_TOP_DIR}/build" >> "$DIR_COMPILADOR/build/bin/.config";
       echo "CT_PREFIX_DIR=\"$DIR_COMPILADOR/build/x-tools\"" >> "$DIR_COMPILADOR/build/bin/.config";

     else
       $DIR_COMPILADOR/build/bin/ct-ng menuconfig

    fi
    echo " [ OK ] Configuracao do Montador feita!"
fi
#clear
echo " Executando build do toolchain....";
echo " POde levar alguns minutos";
read -p "Digite o  numero de nucleos da cpu para compilacao mais otimizada (1/2/3/4..)}> " nucleos;
echo "exec $DIR_COMPILADOR/build/bin/ct-ng build.$nucleos";

cd "$DIR_COMPILADOR/build/bin/";

$DIR_COMPILADOR/build/bin/ct-ng build.$nucleos
