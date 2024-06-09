#!/bin/sh

cp /etc/nixos/* .
cp ~/.config/scripts/* ./config-scripts -r
cp ~/.local/share/scripts/* ./local-scripts -r

rm -fr ./config-scripts/node_modules
rm -fr ./local-scripts/node_modules

if [ $1 ]; then
	almighty-push main $1
fi
