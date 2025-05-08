#!/bin/sh
set -ue

# リモートホストのログイン情報を設定
sed -e "s/__LINUX_USER_PASSWORD__/${LINUX_USER_PASSWORD}/g" /workspace/ansible-root/hosts.sample > /workspace/ansible-root/hosts
sed -i -e "s/__LINUX_ROOT_PASSWORD__/${LINUX_ROOT_PASSWORD}/g" /workspace/ansible-root/hosts
sed -i -e "s/__WIN_ADMIN_PASSWORD__/${WIN_ADMIN_PASSWORD}/g" /workspace/ansible-root/hosts

# Ansible PlaybookのベースとなるGitリポジトリをクローン
if [ ! "${GIT_REPO_URL:+defined}" ]; then
  echo "GIT_REPO_URLが設定されていません。"
  exit 0
fi
if [ -n "`ls -A /ansible-playbooks`" ]; then
  echo "Ansible Playbookのベース資材が既に存在します。"
  exit 0
fi
sudo git clone -b ${GIT_BRANCH} ${GIT_REPO_URL} /ansible-playbooks
if [ $? -ne 0 ]; then
  echo "Gitリポジトリのクローンに失敗しました。"
  exit 1
fi
sudo chown -R app_user: /ansible-playbooks

echo "Ansible Playbookのベース資材をクローンしました: /ansible-playbooks"
