#!/bin/bash

if [ $# -ne 2 ] 
then
    echo "Error: Wrong number of arguments"
    echo "Usage: $0 <directory_name> <output_directory>"
    exit 1
fi
mkdir $2

if [ -d "$1" ]
then
    cd $1
    extensions=$(find . -type f -name '*.*' | sed 's|.*\.||' | uniq -c | grep -o -P '\w+$')
    cd ../$2
    for e in $extensions 
    do
        mkdir $e
    done
    cd ../$1
    for file in $(find . -type f)
    do
        filename=$(basename -- "$file")
        extension="${filename##*.}"
        name="${filename%.*}"
        if [ -f "../$2/$extension/$file" ]
        then
            INDEX=1
            while [ -f "../$2/$extension/$INDEX$file" ]
            do
                INDEX=$((INDEX+1))
            done

            cp "$file" "../$2/$extension/$name.$INDEX.$extension"
        else
            cp "$file" "../$2/$extension"
        fi
    done
else
    echo "Error: Directory $1 or $2 does not exist"
    exit 1
fi
