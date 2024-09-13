#!/bin/bash
# Follows the Contributing instructions to install dependencies clone and run the script

# Update and install basic tools
USER_HOME="/home/developer"

# Install Node.js 20.x and npm using nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Install Node.js
nvm install 20
nvm use 20

if ! command -v node &> /dev/null; then
    echo "Node.js installation failed"
    exit 1
fi

echo 'Node.js version:'
node --version

echo 'npm version:'
npm --version

# Install Yarn using npm instead of cURL
npm install -g yarn

if ! command -v yarn &> /dev/null; then
    echo "Yarn installation failed"
    exit 1
fi

echo 'Yarn version:'
yarn --version

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env

echo 'Rust version:'
rustc --version

#Test Environment build
# Checkout git and branch
GIT_URL=$(git config --get remote.origin.url)
REPO_OWNER=$(echo $GIT_URL | sed -E 's|https://github.com/([^/]+)/.*|\1|')
git clone https://github.com/$REPO_OWNER/pearai-app.git
cd pearai-app
git checkout $CURRENT_BRANCH
source $USER_HOME/.bashrc
# Run the setup script
chmod +x ./scripts/pearai/setup-environment.sh
source ./scripts/pearai/setup-environment.sh
