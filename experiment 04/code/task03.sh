#!/usr/bin/env bash

function Host(){
    printf "%40s\t%s\n" "主机" "出现的次数"
    awk -F '\t' '
    NR>1{
        host[$1]++;
    }
    END{
        for(i in host){
            printf("%40s\t%d\n", i, host[i]);
        }
    }
    ' web_log.tsv | sort -g -k 2 -r | head -100
   exit 0
}

function IP(){
    printf "%20s\t%s\n" "IP" "出现的总次数";
    awk -F '\t' '
    NR>1{
        if(match($1, /^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$/)) ip[$1]++;}
    END{
        for(i in ip){
            printf("%20s\t%d\n", i, ip[i]);
            }
    }
    ' web_log.tsv | sort -g -k 2 -r | head -100
    exit 0
}

function URL(){
    printf "%55s\t%s\n" "URL" "出现的总次数"
    awk -F '\t' '
    NR>1{
        url[$5]++;
        }
    END{
        for(i in url){
            printf("%55s\t%d\n",i,url[i]);
            }
    }
    ' web_log.tsv | sort -g -k 2 -r | head -100
    exit 0
}

function StatesCode(){
    awk -F '\t' '
    BEGIN{
        printf("响应状态码\t出现次数\t对应百分比\n");
    }
    NR>1{
        code[$6]++;
    }
    END{ 
        for(i in code){
            printf("%d\t%d\t%f%%\n", i, code[i], 100.0*code[i]/(NR-1));
        }
    }
    ' web_log.tsv
    exit 0
}

function StatesCode4xx(){
    printf "%55s\t%s\n" "状态码403的URL" "出现的总次数"
    awk -F '\t' '
    NR>1{
        if($6=="403"){
            code[$5]++;
        }
    }
    END{
        for(i in code){
            printf("%55s\t%d\n", i, code[i]);
            }
    }
    ' web_log.tsv | sort -g -k 2 -r | head -10

    printf "%55s\t%s\n" "状态码为404的URL" "出现的总次数"
    awk -F '\t' '
    NR>1{
        if($6=="404"){
            code[$5]++;
            }
    }
    END{
        for(i in code){
            printf("%55s\t%d\n", i, code[i]);
            }
    }
    ' web_log.tsv | sort -g -k 2 -r | head -10
    exit 0
}

function FindHost(){
    printf "%40s\t%s\n" "given_hostname" "count"
    awk -F "\t" '
    NR>1{
        if("'"$1"'"==$5){
            host[$1]++;
        }
    }
    END{
        for(i in host){
            printf("%40s\t%d\n", i, host[i]);
        }
    }
    ' web_log.tsv | sort -g -k 2 -r | head -100
    exit 0
}

function help(){
    echo "-t      统计访问来源主机TOP 100和分别对应出现的总次数"
    echo "-i      统计访问来源主机TOP 100 IP和分别对应出现的总次数"
    echo "-u      统计最频繁被访问的URL TOP 100"
    echo "-s      统计不同响应状态码的出现次数和对应百分比"
    echo "-c      分别统计不同4XX状态码对应的TOP 10 URL和对应出现的总次数"
    echo "-d  URL    给定URL输出TOP 100访问来源主机"
    exit 0
}

while [ "$1" != "" ];do
    case "$1" in
       "-t")
      Host
      ;;
       "-i")
      IP
      ;;
       "-u")
      URL
      ;;
       "-s")
      StatesCode
      ;; 
       "-c")
      StatesCode4xx
      ;;
       "-d")
      FindHost "$2"
      ;;
       "-h")
      help
      ;;
    esac
done