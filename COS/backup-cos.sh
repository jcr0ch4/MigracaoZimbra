#!/bin/bash
#
#  backup-cos·sh
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


# The result is a file/s for each COS, and the users within this specific COS
# Note: If there are no custom created COS, there will be no users listed in the default and default_external files. That 
# means all users are in the "default" COS.
# Since the default and the default_external files will contain no users, their respective files are deleted at 
# the end. Zimbra only detect users that are not in the default COS. Thus, every non detected user is in the default COS. 

#mkdir /tmp/cos_users
ldap_master_url=ldap://IP DO ZIMBRA LDAP:389
zimbra_ldap_userdn=uid=zimbra,cn=admins,cn=zimbra
zimbra_ldap_password=SENHA DO ZIMBRA NO LDAP

source ~/bin/zmshutil; zmsetvars

for i in `zmprov gac`
do
	id=`zmprov gc $i | grep -e "\bzimbraId\b"|cut -d " " -f 2`
	ldapsearch -x -H $ldap_master_url -D $zimbra_ldap_userdn -w $zimbra_ldap_password| grep -e $id -e "dn: uid=" -e mail:|grep -v Email| grep -e zimbraCOSId -B1 -A1|grep mail|awk '{print $2}' > /tmpdir/COS/$i.ldif


done



