#!/bin/bash

SERVER_IP="147.45.163.100"
REPO_URL="https://github.com/itegmark/mcg.git"
BRANCH="main"
SSH_PORT=22

# Set error handling.
set -e

# Add and commit changes
git add .
git commit -m 'deploying to production'
git push

# Deploy to production server kill previous process and start new!
ssh -t -t -p $SSH_PORT root@$SERVER_IP <<EOF
  cd mcg
  git stash
  git pull $REPO_URL $BRANCH
  pnpm build
  pnpm run start   
EOF
