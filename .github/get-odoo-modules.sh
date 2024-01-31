#!/bin/bash

SSH_PATH="~/.ssh"

echo "-----BEGIN OPENSSH PRIVATE KEY-----" >> $SSH_PATH/github && \
echo ${{ secrets.MODULES_REPO_SSH_KEY }} >> $SSH_PATH/github && \
echo "-----END OPENSSH PRIVATE KEY-----" >> $SSH_PATH/github && \
chmod 600 $SSH_PATH/github && \
eval $(ssh-agent -s) && ssh-add $SSH_PATH/github && \
echo ${{ secrets.SSH_KNOWN_HOST_ID }} >> $SSH_PATH/known_hosts

echo "Host github.com" >> $SSH_PATH/config && \
echo " HostName github.com" >> $SSH_PATH/config && \
echo " IdentityFile ~/.ssh/github" >> $SSH_PATH/config && \
chmod 644 $SSH_PATH/config

git clone -b ${{ env.MODULES_REPO_BRANCH }} ${{ env.MODULES_REPO_URL }} ${{ env.ODOO_ADDONS_DIR }} --depth 1