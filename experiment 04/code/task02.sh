#!/usr/bin/env bash

function Age(){
    awk -F '\t' '
        BEGIN{
            small=0;
            middle=0;
            high=0;
        }
        NR>1{
            if($6<20){
                small++;
            }
            else if($6<=30){
                middle++;
            }
            else{
                high++;
            }
        }
        END{
            total=small+middle+high;
            printf("年龄区间范围\t球员数量\t百分比\n");
            printf("20岁以下\t%d\t%f%%\t\n",small,100*small/total);
            printf("20~30之间（包含20和30）\t%d\t%f%%\t\n",middle,100*middle/total);
            printf("30岁以上\t%d\t%f%%\t\n",high,100*high/total);
        }' worldcupplayerinfo.tsv
        exit 0
}

function Position(){
    awk -F '\t' '
        BEGIN{
            total=0;
        }
        NR>1{
            position[$5]++;
            total++;
        }
        END{
            printf("所处位置\t球员数量\t百分比\n");     
            for (i in position){
                printf("%s\t%d\t%f%%\t\n",i,position[i],100*position[i]/total);
            }
        }
        ' worldcupplayerinfo.tsv
        exit 0
}

function Name(){
    awk -F '\t' '
        BEGIN{
            max=0; 
            min=100; 
        }
        NR>1{ 
            len=length($9);
            names[$9]=len;
            max=len>max?len:max;
            min=len<min?len:min; 
        }        
        END{
            for(i in names){            
                if(names[i]==max){
                    printf("名字最长的球员是:%s\n",i);
                }
                else if(names[i]==min){
                    printf("名字最短的球员是:%s\n",i); 
                }
            }
        } 
        ' worldcupplayerinfo.tsv
        exit 0
}

function Age_max_min(){
    awk -F '\t' '
        BEGIN{
            max=-1;
            min=999;
        }
        NR>1{
            age=$6;
            names[$9]=age;
            max=age>max?age:max;
            min=age<min?age:min;
        }
        END{
            printf("年龄最大的球员是");
            for(i in names){
                if(names[i]==max){
                    printf("%s,", i); 
                }
            }
            printf("年龄是%d\n", max);
            printf("年龄最小的球员是");
            for(i in names){
                if(names[i]==min){
                    printf("%s,", i); 
                }
            }
            printf("年龄是%d\n", min);
        }' worldcupplayerinfo.tsv
        exit 0
}

function help(){
    echo "-a                 统计不同年龄区间范围（20岁以下、[20-30]、30岁以上）的球员数量、百分比"
    echo "-p                 统计不同场上位置的球员数量、百分比"
    echo "-n                 名字最长的球员是谁？名字最短的球员是谁？"
    echo "-m                 年龄最大的球员是谁？年龄最小的球员是谁？"
    exit 0
}

while [ "$1" != "" ];do
    case "$1" in
        "-a")
            Age
            ;;
        "-p")
            Position
            ;;
        "-n")
            Name
            ;;
        "-m")
            Age_max_min
            ;;
        "-h")
            help
            ;;
    esac
done