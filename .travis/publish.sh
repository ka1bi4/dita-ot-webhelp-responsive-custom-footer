#!/bin/bash

echo "Publish $TRAVIS_BRANCH !"

java -version

echo "Root folder"
ls -la .

echo "====================================="
echo "download DITA-OT 2.5.3"
echo "====================================="
wget https://github.com/dita-ot/dita-ot/releases/download/2.5.3/dita-ot-2.5.3.zip  >/dev/null

echo "====================================="
echo "extract DITA-OT"
echo "====================================="
unzip dita-ot-2.5.3.zip >/dev/null

echo "===================================================="
echo "Download WebHelp plugin"
echo "===================================================="
mkdir webhelp-plugin
chdir webhelp-plugin
# wget http://mirror.oxygenxml.com/InstData/Editor/Webhelp/DITA-OT%202.x/oxygen-webhelp.zip
cp ../resources/webhelp/oxygen-webhelp.zip oxygen-webhelp.zip
unzip oxygen-webhelp.zip >/dev/null
cp ../resources/doc/licensekey.txt com.oxygenxml.webhelp.responsive
ls -la com.oxygenxml.webhelp.responsive
cp -R com.oxygenxml.* ../dita-ot-2.5.3/plugins

chdir ..
echo "===================================================="
echo "Copy extension plugin"
echo "===================================================="
mkdir dita-ot-2.5.3/plugins/com.oxygenxml.webhelp.responsive.custom.footer
cp * dita-ot-2.5.3/plugins/com.oxygenxml.webhelp.responsive.custom.footer

echo "===================================================="
echo "List DITA-OT plugins"
echo "===================================================="
ls -la dita-ot-2.5.3/plugins/

echo "====================================="
echo "integrate plugins"
echo "====================================="
sh dita-ot-2.5.3/bin/dita --install

echo "====================================="
echo "Transform the sample to WebHelp Responsive output"
echo "====================================="

export ANT_OPTS=-Xmx1524m
sh dita-ot-2.5.3/bin/dita -i -v resources/sample/it-book/taskbook.ditamap -f webhelp-responsive -output=publishing/it-book

cp resources/gh-pages/index.html publishing/index.html
echo "====================================="
echo "List output file"
echo "====================================="
ls -la publishing
ls -la publishing/it-book
