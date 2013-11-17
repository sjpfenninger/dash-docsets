#!/bin/sh

# ${1} docset name
# ${2} docset input folder

doc2dash -n ${1} ${2}
/usr/libexec/PlistBuddy -c "Set :DocSetPlatformFamily 'python'" ${1}.docset/Contents/Info.plist
/usr/libexec/PlistBuddy -c "Add :dashIndexFilePath string 'genindex.html'" ${1}.docset/Contents/Info.plist
tar --exclude='.DS_Store' -cvzf feeds/${1}.tgz ${1}.docset