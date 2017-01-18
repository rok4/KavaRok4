#/bin/bash

cat << EOF > /etc/nginx/conf.d/default.conf
upstream rok4 {
EOF

cat /etc/hosts | grep rok4 | awk '{print $1}' | sort | uniq | while read server
do
	echo "    server $server:9000;" >> /etc/nginx/conf.d/default.conf
done

cat << EOF >> /etc/nginx/conf.d/default.conf
}
                                               
server {
    listen       80;
    server_name  localhost;

    location / {
        root /usr/share/nginx/html/ ;
        index index.html;
    }
    
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }

    location /rok4 {
        fastcgi_pass rok4;
        include fastcgi_params;
    }
}
EOF

nginx -g 'daemon off;'
