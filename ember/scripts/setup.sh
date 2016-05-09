#!/bin/bash

# Install node
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash
nvm install 5.0
nvm use 5.0

# Install ember, phantom, and bower to prepare the environment
npm install -g ember-cli@1.13.13
npm install -g bower@1.7.1
npm install -g phantomjs@2.1.3
npm install -g mavensmate@0.0.43

if [ "$1" == "production" ]; then
	return
fi

# Install watchman
brew install watchman
