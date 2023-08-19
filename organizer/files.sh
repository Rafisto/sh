#!/bin/bash
if [ $# -ne 1 ] && [ $# -ne 2 ]
then
    echo "Error: Wrong number of arguments"
    echo "Usage: $0 [-r] <directory_name>"
    exit 1
fi

if [ $# -eq 2 ]
then
    if [ $1 != "-r" ]
    then
        echo "Error: Wrong flag"
        echo "Usage: $0 [-r] <directory_name>"
        exit 1
    fi
    rm -r $2
elif [ $# -eq 1 ]
then
    if [ $1 == "-h" ]
    then
        echo "Generate files - Rafist0"
        echo "Usage: $0 [-r] <directory_name>"
        exit 0
    fi
    if [ -d "$1" ]
    then
        echo "Directory $1 already exists"
        exit 1
    else
        mkdir $1
        cd $1
        touch text_file{1..10}.txt
        touch image_file{1..5}.jpg
        touch video_file{1..3}.mp4
        touch audio_file{1..2}.mp3
        mkdir recursive && cd recursive
        touch text_file{5..12}.txt
    fi
fi

