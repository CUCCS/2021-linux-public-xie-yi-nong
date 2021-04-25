#!/usr/bin/env bash

function Qua_Compress(){
    Q=$1
    for img in *; do
        type=${img##*.} 
        if [[ ${type} == "jpg" || ${type} == "jpeg" ]]; 
            then convert "${img}" -quality "${Q}" "${img}";
            echo "${img}压缩完成"
        fi;
    done
    exit 0
}

function Size_Compress(){
    D=$1
    for img in *; do
        type=${img##*.}
        if [[ ${type} == "jpg" || ${type} == "jpeg" || ${type} == "png" || ${type} == "svg" ]]; 
            then convert "${img}" -resize "${D}" "${img}";
            echo "${img}压缩完成"
        fi; 
    done
    exit 0
}

function Watermarking(){
    for img in *; do
        type=${img##*.}
        if [[ ${type} != "jpg" && ${type} != "jpeg" && ${type} != "png" && ${type} != "svg" ]];
            then convert "${img}" -pointsize "$1"  -draw "text 0,20 '$2'" "${img}";
             echo "${img}水印添加完毕"
        fi;
    done
    exit 0
}

function Prefix(){
    for img in *; do
        type=${img##*.}
        if [[ ${type} == "jpg" || ${type} == "jpeg" || ${type} == "png" || ${type} == "svg" ]];
            then mv "${img}" "$1""${img}";
            echo "${img}前缀添加完毕"
        fi;
    done
    exit 0
}

function Postfix(){
    for img in *; do
        type=${img##*.}
        if [[ ${type} == "jpg" || ${type} == "jpeg" || ${type} == "png" || ${type} == "svg" ]];
            then
            newname=${img%.*}$1"."${type}
            mv "${img}" "${newname}"
            echo "${img}后缀添加完毕"
        fi;
    done
    exit 0
}

function Transform(){
    for img in *; do
        type=${img##*.}
        if [[ ${type} == "png" || ${type} == "svg" ]]
            then 
            newfile=${img%.*}".jpg"
            convert "${img}" "${newfile}"
   	        echo "${img}已转换为jpg格式的图片"
        fi;
    done
    exit 0
}

function help(){
    echo "-q Q               对jpeg格式图片进行图片质量因子为Q的压缩"
    echo "-s S               对jpeg/png/svg格式图片在保持原始宽高比的前提下压缩成D分辨率"
    echo "-w fontsize watermark_text  对图片批量添加自定义文本水印"
    echo "-p text            统一添加文件名前缀，不影响原始文件扩展名"
    echo "-f text            统一添加文件名后缀，不影响原始文件扩展名"
    echo "-t                 将png/svg图片统一转换为jpg格式图片"
    exit 0
}

while [ "$1" != "" ];do
case "$1" in
    "-q")
        Qua_Compress "$2"
        ;;
    "-s")
        Size_Compress "$2"
        ;;
    "-w")
        Watermarking "$2" "$3"
        ;;
    "-p")
        Prefix "$2"
        ;;
    "-f")
        Postfix "$2"
        ;;
    "-t")
        Transform
        ;;
    "-h")
        help
        ;;
    esac
done