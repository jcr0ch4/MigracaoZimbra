#!/bin/bash
# 
#  backup-full-mailbox.sh
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
MAILHOST=servidor.de.email.com.br
ADMINUSER=usuario-com-poder-de-administrador
ADMINPASS=SENHA
TEMPDIR=PASTA
# $1 = lista de contas de e-mail geradas a partir do comando zmprov -l gaa

for i in $(cat $1)
do
	MAIL=$i
	dia=$(date +%c)
	echo "$dia -  Iniciando o Backup da conta : $i" >> $TEMPDIR/LOG-BACKUP-FULL.LOG
	$(which curl) -k -u $ADMINUSER:$ADMINPASS https://$MAILHOST:7071/home/$MAIL/?fmt=tgz > $TEMPDIR/$MAIL.tgz
	echo "$(date +%c) -  Finalizado o backup da conta com tamanho : $(du -sh $TEMPDIR/$MAIL.tgz)" >> $TEMPDIR/LOG-BACKUP-FULL.LOG
	echo "---------------------------------------------------------------------------" >> $TEMPDIR/LOG-BACKUP-FULL.LOG
done

