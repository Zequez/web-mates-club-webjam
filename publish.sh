#!/usr/bin/env bash
cd "$(dirname "$0")"
set -e

git rev-parse --git-dir >/dev/null 2>&1 || git init

touch .gitignore
grep -qxF 'www' .gitignore || echo 'www' >> .gitignore

git add -A
git commit -m "Deploy $(date '+%Y-%m-%d %H:%M:%S')" || true

if ! git remote get-url origin >/dev/null 2>&1; then
  read -rp "Origin repo URL: " origin
  git remote add origin "$origin"
fi

git push --all origin
gh-pages -d www -b www

echo "DONE."