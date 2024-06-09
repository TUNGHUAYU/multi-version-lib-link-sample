#!/bin/bash

workdir=$(pwd)


if [[ $1 == "clean" ]]; then
	rm ${workdir}/*/lib*
	rm ${workdir}/*/*.o
	rm ${workdir}/*/*.out

else

	# Create show_version library ( v1 )
	cd ${workdir}/lib_v1/
	gcc -c -Wall -Werror -fpic show_version.c
	gcc -shared -o libshow_version.so.1 show_version.o
	
	# Create show_version library ( v2 )
	cd ${workdir}/lib_v2/
	gcc -c -Wall -Werror -fpic show_version.c
	gcc -shared -o libshow_version.so.2 show_version.o
	
	# Create app1 linking show_version library ( v1 )
	cd ${workdir}/app1/
	gcc -L${workdir}/lib_v1/  -Wall -o app1.out app1.c -l:libshow_version.so.1
	
	# Create app2 linking show_version library ( v2 )
	cd ${workdir}/app2/
	gcc -L${workdir}/lib_v2/  -Wall -o app2.out app2.c -l:libshow_version.so.2

fi






