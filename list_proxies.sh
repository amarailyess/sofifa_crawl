unset PROXY_ARR
# while read line
# do
#         PROXY_ARR=("${PROXY_ARR[@]}" "$line")
# done < /usr/local/bin/list_proxy
# max_proxy=${#PROXY_ARR[@]}

# PROXY_ARR[$i]="172.16.2.14:3128"; let "i=i+1";
# PROXY_ARR[$i]="172.16.2.14:3228"; let "i=i+1";
    
port=6001;
while [ ${port} -lt 6040 ]
do
        PROXY_ARR[$i]="172.16.2.14:${port}"; let "i=i+1";
        let "port=port+1";
done

max_proxy=${#PROXY_ARR[@]}