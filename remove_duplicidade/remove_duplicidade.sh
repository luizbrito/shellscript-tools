#!/bin/bash
echo " "
echo " #######################################################################"
echo " #                                                                     #"
echo " #                    REMOVE DUPLICIDADE                               #"
echo " #                                                                     #"
echo " #    Procedimento para remoção de linhas duplicadas de 2 arquivos.    #"
echo " #    A saida será um arquivo que possua linhas apenas em um dos       #"
echo " #    arquivos apenas o que não existe em                              #"
echo " #                                                                     #"
echo " #######################################################################"
echo " "

#Valida os parametros de entrada
if [ $# -lt 3 ]; then
  echo " "
  echo " ######################################################################"
  echo " #                                                                    #"
  echo " #      Utilizar o padrão:                                            #"
  echo " #      ./remove_duplicados.sh arquivo1 arquivo2 saida                #"
  echo " #                                                                    #"
  echo " #      NUMERO DE PARAMETROS: $# INFORMADOS.                           #"
  echo " #                                                                    #"
  echo " #  - O Shell deve ser utilizado para realizar a remoção das linhas   #"
  echo " #  duplicadas das ordens já carregadas no arquivo processado na hora #"
  echo " #  anterior.                                                         #"
  echo " #                                                                    #"
  echo " #  - Deve ser passado 3 parametros.                                  #"
  echo " #    1° - ARQUIVO_2021030101_1.CSV (arquivo base)                    #"
  echo " #    2° - ARQUIVO_2021030101_2.CSV (diferença com o anterior)        #"
  echo " #    3° - ARQUIVO_SAIDA_2021030101_3.CSV                             #"
  echo " #                                                                    #"
  echo " ######################################################################"
  exit -1
fi

if [ $# -gt 2 ]; then
  COUNT=0
  for ARG in $*-1; do
     COUNT=`expr $COUNT + 1`
     if [ -e "$ARG" ] ; then
       echo "O arquivo - $ARG - existe"
     else
       echo "O arquivo - $ARG - não existe"
     fi
  done
fi

# Cria arquivo temporario e Remove primeira linha
sed '1 d' $1 > $1_tmp
sed '1 d' $2 > $2_tmp

# Remove a ultima linha
sed '$d' $1_tmp > $1_tmp2
sed '$d' $2_tmp > $2_tmp2

# Copia o header
head -1 $2 > $3

# Copia as diferenças
diff $1_tmp2 $2_tmp2 | grep '> ' | sed 's/> //' >> $3

# Adicionar rodapé
echo "`cat $3``echo -e '\n90000'`" > $3

# limpa os arquivos temporarios # se quise debugar comente a linha abaixo
rm $1_tmp $2_tmp $1_tmp2 $2_tmp2
