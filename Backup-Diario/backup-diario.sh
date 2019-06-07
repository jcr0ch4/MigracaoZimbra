#!/bin/bash
#
#  backup-diario.sh
#
#  Copyright 2019 Jose Carlos <jcr0ch4@gmail.com>
#  
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#  
#  
MAILHOST=servidor-de-email-zimbra.com.br
ADMINUSER=usuario-com-poder-administrativo
ADMINPASS=Senha
TEMPDIR=/tmpdir
hoje=$(date +%m/%d/%y)
anteontem=$(date +%m/0$(expr $(date +%d) - 2)/%y)
ontem=$(date +%m-0$(expr $(date +%d) - 1)-%y)
caminho=/root/lista_usuarios_zimbra

if [ -d $caminho ];then
	echo "Caminho nao encontrado, sera criado o diretorio .... "
	mkdir /root/lista_usuarios_zimbra/$ontem 

else
	echo "Caminho encontrado, pasta nao será criada."
fi



for i in $(cat $1)
do
	echo "Antes de Ontem : $ontem"
	echo "Hoje : $hoje"
	MAIL=$i
	dia=$(date +%c)
	echo "$dia -  Iniciando o Backup da conta : $i" 
	$(which curl) -k -u $ADMINUSER:$ADMINPASS "https://$MAILHOST:7071/home/$MAIL/?fmt=tgz&query=after:$anteontem+AND+before:$hoje" >> $caminho/$ontem/$MAIL.tgz
	echo "$(date +%c) -  Finalizado o backup da conta com tamanho : $(du -sh $caminho/$ontem/$MAIL.tgz)"
	echo "---------------------------------------------------------------------------" 
done

