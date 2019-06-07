#!/bin/bash
#  Script Name : backp_all_account.sh 
#  
#  Copyright 2015 José Carlos Rocha <jcr0ch4@gmail.com>
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

lista_contas(){
	retorno=$(/opt/zimbra/bin/zmprov -l gaa |sort)
	echo "$retorno"

}

cmd_backup(){
	retorno_cmd=$(/opt/zimbra/bin/ldapsearch -x -H ldap://IP-LDAP_ZIMBRA:389 -D uid=zimbra,cn=admins,cn=zimbra -w SENHA-LDAP-ZIMBRA -LLL zimbraMailDeliveryAddress=$1 )
	echo "$retorno_cmd"
}
# Backup conta de e-mail
for i in $( /opt/zimbra/bin/zmprov -l gaa|sort ) ;
do 
	dominio=`echo $i|awk -F '@' '{print $2}'`
	case $dominio in
		"dominio01.com.br")	cmd_backup "$i" > /tmpdir/contas/$i.ldif
		;;
		"dominio02.com.br.com.br") cmd_backup "$i" > /tmpdir/contas/$i.ldif
		;;
		"dominio03.com.br") cmd_backup "$i" > /tmpdir/contas/$i.ldif
		;;
		"dominio04.com.br") cmd_backup "$i" > /tmpdir/contas/$i.ldif
		;;
	esac
done


