#!/usr/bin/env bash
# Builds a throwaway Git repository to practise the commands in the cheat sheets.
# Usage: bash practice/setup.sh [folder]   (default: ./git-playground)
# Delete the folder when done; run again for a fresh start.
set -euo pipefail

dir="${1:-git-playground}"
if [ -e "$dir" ]; then
  echo "'$dir' already exists. Delete it or pass another folder name." >&2
  exit 1
fi

mkdir "$dir"
cd "$dir"
git init -q -b main
git config user.name "Playground"
git config user.email "playground@example.com"
git config commit.gpgSign false   # no signing prompts in a throwaway repo
git config tag.gpgSign false

commit() { echo "$2" >> "$1"; git add "$1"; git commit -q -m "$3"; }

commit app.py   "print('hello')"            "Add app"
commit app.py   "print('login')"            "Add login"
git tag v1.0
commit app.py   "print('profile')"          "Add profile page"
commit app.py   "raise SystemExit(1)  # bug" "Add settings page"
commit README.md "# Playground"             "Add README"

git switch -q -c feature
commit feature.py "def search(): pass"      "Add search"
commit feature.py "# fix typo"              "fix typo"
commit feature.py "# fix bug 2"             "fix bug 2"
git switch -q main

echo "print('unsaved work')" >> app.py      # an uncommitted change to restore or stash

cat <<EOF
Playground ready in ./$dir
  main:    5 commits, tag v1.0 on the 2nd; the 4th adds a bug (try: git bisect)
  feature: 3 commits, two of them "fix" commits (try: git rebase -i)
  app.py:  one uncommitted change (try: git restore or git stash)

  cd $dir && git log --oneline --graph --all
EOF
