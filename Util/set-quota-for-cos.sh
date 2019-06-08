#!/bin/bash
#
#  set-quota-for-cos.sh
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


for i in $(zmprov gac|grep -v defaul|grep -v ^$)
do 
	cota=$(echo $i |awk -F "_" '{print $2}'|grep -v ^$)
	valor=$( expr $cota \* 1024 \* 1024)
	echo  "mc $i zimbraMailQuota $valor" >>/tmp/acerto_cos.txt
done
zmprov < /tmp/acerto_cos.txt 
