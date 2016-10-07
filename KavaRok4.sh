#!/bin/bash

build-compose(){
	if [[ -f ./docker-compose.yml ]]
	then
		rm ./docker-compose.yml
	fi
	
	cat << EOF >> ./docker-compose.yml
nginx:
  image: rok4/kavarok4-nginx
  ports:
    - "8080:80"
  links:
    - rok4
EOF
	
	for lay in ${LAYERS}
	do
		cat << EOF	>> ./docker-compose.yml
data-${lay}:
  image: rok4/data-${lay}
EOF
	done
	
	cat << EOF	>> ./docker-compose.yml
rok4:
  image: rok4/rok4
  volumes_from:
EOF
	for lay in ${LAYERS}
	do
		cat << EOF	>> ./docker-compose.yml
    - data-${lay}
EOF
	done
}

up(){
	build-compose

	echo $LAYERS | tr ' ' '\n' > layers_list
	docker-compose up
}

addLayer(){
	echo "Add layer [$1]"
	nb=$(grep "^$1$" ./layers_list | wc -l) # C'est moche
	if [[ "$nb" == "0" ]]
	then
		echo "$1" >> ./layers_list
		LAYERS=$(cat ./layers_list | tr ' ' '\n')
		build-compose
		docker-compose start data-$1
		docker-compose restart rok4
	fi
}

removeLayer(){
	echo "Remove layer [$1]"
	nb=$(grep "^$1$" ./layers_list | wc -l) # C'est moche
	if [[ "$nb" != "0" ]]
	then
		sed -i "/$1/d" ./layers_list
		LAYERS=$(cat ./layers_list | tr '\n' ' ')
		docker-compose rm data-$1
		build-compose
		docker-compose restart rok4
	fi
}

stop(){
	docker-compose stop
	docker-compose rm
	exit 0
}

if [[ "$1" != "" ]]
then
	$@
else
	echo -n "> "
	while read line
	do
		$line
		echo -n "> "
	done
fi