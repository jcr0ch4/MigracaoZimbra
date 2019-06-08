#!/bin/bash
#
#  backup-lista-de-email
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

1. First we export&save all members from distribution list called "dist_list1" to a text file:

zmprov gdlm dist_list1@domain.com > distlist.txt 

2. Then we move the file to the other server (using scp for example) and run:

for i in `cat distlist.txt | egrep -v '#|members'`;do zmprov adlm dist_list2@domain.com $i;done 

The above command imports all members from the "dist_list1" distribution list, into the "dist_list2" distribution list on the second server.




# Criar as Listas


# Backup de menbros da lista informda 
zmprov gdlm $lista > /tmpdir/Lista-de-Distribuicao/membros_da_lista.txt

for i in `cat distlist.txt | egrep -v '#|members'`;do zmprov  $i;done 
