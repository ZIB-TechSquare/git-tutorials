# 2. Everyday workflow: 5 Git commands beyond the basics

You know `add`, `commit`, `push` and `pull`. These five make every day faster. From the ZIB TechSquare Short *5 Git Commands Beyond the Basics*.

| I want to... | Command | Rewrites history? |
|--------------|---------|-------------------|
| Create a branch and switch to it | `git switch -c <branch>` | No |
| Park unfinished work | `git stash push -m "<note>"` / `git stash pop` | No |
| See what I'm about to commit | `git diff --staged` | No |
| Add a forgotten file to the last commit | `git commit --amend --no-edit` | ⚠ Yes |
| See branches as a timeline | `git log --oneline --graph` | No |

## 1. `git switch -c`: create a branch and switch to it

```bash
git switch -c feature/login   # new branch from where you are, and switch
git switch main               # back to main
git switch -                  # back to the previous branch
```

`git switch` (Git 2.23+) only changes branches, unlike `git checkout`, which also restores files. The older form is `git checkout -b feature/login`.

## 2. `git stash`: park your work with a name

```bash
git stash push -m "wip: login form"   # save and clean the working copy
git stash push -u -m "with new files" # -u also stashes untracked files
git stash list                        # stash@{0}: On main: wip: login form
git stash pop                         # apply the latest and remove it
git stash apply stash@{1}             # apply an older one, keep it
```

Use it when you must switch branches mid-task. A named stash is easy to find a week later.

## 3. `git diff --staged`: see exactly what you'll commit

```bash
git diff            # changes not staged yet
git diff --staged   # changes staged for the next commit (same as --cached)
```

Run it before every commit: it catches debug prints, secrets and files you didn't mean to add.

## 4. `git commit --amend --no-edit`: fix the last commit ⚠

```bash
git add README.md
git commit --amend --no-edit    # add it to the last commit, keep the message
git commit --amend -m "Better message"   # or change the message
```

**Watch out:** amending replaces the commit with a new one. Only amend commits you haven't pushed; if you have, make a new commit.

## 5. `git log --oneline --graph`: your history as a timeline

```bash
git log --oneline --graph          # current branch
git log --oneline --graph --all    # every branch
git config --global alias.lg "log --oneline --graph --all --decorate"
git lg                             # the same, shorter
```

## Try it

In the playground from [`practice/setup.sh`](../practice/setup.sh): `stash` the uncommitted change, `switch -c` a new branch, `pop` the stash there, commit, forget a file and `--amend` it, then look at it all with `log --oneline --graph --all`.

---

[All cheat sheets](../README.md) · ZIB TechSquare, [@zibtechsquare](https://www.youtube.com/@zibtechsquare)
