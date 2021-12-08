#!/bin/bash
echo Creating src subdir
mkdir src
echo Creating zip_download dir
mkdir zip_download
pushd zip_download
IFS=$'\n'
for u in $(cat ../mix_protofiles_url.txt); do
    echo "Download with wget: $u"
    wget "$u"
    #curl -s "$u"
done
for z in $(find . -name '*.zip'); do
    echo "Unzip to ../src: $z"
    unzip -o "$z" -d ../src
done
popd

