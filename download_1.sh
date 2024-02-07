#!/bin/bash
. list_proxies.sh # Important line 
. Utils.sh    #Important line
. list_useragent.sh

function incr_ip() {

    local a=`od -vAn -N4 -tu4 < /dev/urandom | sed 's/ //g'`

    findAliveIP # reading function in file /Lib_Autobiz/Utils.sh

    echo "==> Proxy data center: ${PROXY_ARR[$id_proxies]}"

    u_a=1;

    USERAGENT_ARR[$u_a]="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36"; let "u_a=u_a+1";

    max_useragent=$u_a;

    let "u_a=a % max_useragent"

}


curl -k -x "172.16.2.14:3128" --location "https://labonneboite.pole-emploi.fr/entreprises?j=%C3%89tudes%20et%20d%C3%A9veloppement%20informatique%20(Chef%20de%20projet%20%C3%A9tude%20et%20d%C3%A9veloppement%20informatique%2C%20...)&l=Paris%20(75000)&naf=&h=1&d=3000&sort=smart&ij=&occupation=etudes-et-developpement-informatique&lat=48.84495371275856&lon=2.3760858842364394&departments=&fbclid=IwAR3Y3EWHOjxGG7daXvX9ZxPRqzxinZTcQ819ZcKJBxgPqVIOEddtFwK5uDg"  -H 'Connection: keep-alive' -A "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36"  > page1.html
src_link = "https://labonneboite.pole-emploi.fr/entreprises?j=%C3%89tudes%20et%20d%C3%A9veloppement%20informatique%20(Chef%20de%20projet%20%C3%A9tude%20et%20d%C3%A9veloppement%20informatique%2C%20...)&l=Paris%20(75000)&naf=&h=1&d=3000&sort=smart&ij=&occupation=etudes-et-developpement-informatique&lat=48.84495371275856&lon=2.3760858842364394&departments=&fbclid=IwAR3Y3EWHOjxGG7daXvX9ZxPRqzxinZTcQ819ZcKJBxgPqVIOEddtFwK5uDg"
incr_ip()                            
curl -k -x "http://${PROXY_ARR[$id_proxies]}" --location " -A "${USERAGENT_ARR[$u_a]}" -H 'Connection: keep-alive' -b "${cookie}" -c "${cookie}" --retry 2 --retry-max-time 60 --globoff ${src_link} --compressed > page1.html