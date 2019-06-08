






zmaccts | grep never | awk ‘{print “zmmailbox -z -m ” $1 ” emptyFolder /Inbox”}’ | cat -n
