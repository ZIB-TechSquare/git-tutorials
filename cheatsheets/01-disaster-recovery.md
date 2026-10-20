# 1. Disaster recovery: 5 Git commands that save your code

Git can undo almost any mistake, if you know which command to reach for. From the ZIB TechSquare Short *5 Git Commands That Save Your Code*.

| I want to... | Command | Rewrites history? |
|--------------|---------|-------------------|
| Throw away my changes to a file | `git restore <file>` | No, but the changes are gone for good |
| Undo my last commit, keep the code | `git reset --soft HEAD~1` | ⚠ Yes |
| Undo a commit I already pushed | `git revert <commit>` | No, safe on shared branches |
| Find a commit I thought I lost | `git reflog` | No |
| Find the commit that broke something | `git bisect` | No |

## 1. `git restore`: throw away changes in a file

```bash
git restore app.py            # working copy back to the last commit
git restore --staged app.py   # unstage it, keep the changes
git restore .                 # every file in this folder
```

**Watch out:** `git restore <file>` deletes uncommitted changes, and Git can't bring them back: they were never committed, so `reflog` doesn't know them. If you're unsure, `git stash` instead.

## 2. `git reset --soft HEAD~1`: undo the last commit, keep the code ⚠

```bash
git reset --soft HEAD~1   # the commit is gone, its changes stay staged
git reset HEAD~1          # (--mixed, the default) changes stay, unstaged
git reset --hard HEAD~1   # commit AND changes gone — recover with reflog
```

Use it for "I committed too early" or "wrong message". `HEAD~1` means one commit before the current one; `HEAD~3` goes back three.

**Watch out:** only on commits you haven't pushed. If you have, use `git revert`.

## 3. `git revert`: undo a pushed commit safely

```bash
git log --oneline         # find the commit, e.g. a1b2c3d
git revert a1b2c3d        # makes a new commit that reverses it
git push
```

The old commit stays in history and a new one cancels it, so nobody's copy breaks. Reverting a merge commit needs `-m 1` (keep the main branch's side).

## 4. `git reflog`: Git's safety net

```bash
git reflog                       # every place HEAD has been
# a1b2c3d HEAD@{2}: commit: add login form
git switch -c rescue a1b2c3d     # bring it back on a new branch
```

The reflog records where HEAD and each branch pointed, locally. It rescues commits after a `reset --hard`, a bad rebase or a deleted branch. Entries for commits nothing points to any more are kept 30 days by default, the rest 90 days. It can't rescue changes that were never committed.

## 5. `git bisect`: find the commit that broke it

```bash
git bisect start
git bisect bad              # the current commit is broken
git bisect good v1.0        # this tag (or hash) worked
# Git checks out a commit in the middle: test it, then
git bisect good             # or: git bisect bad
# ...repeat until Git names the first bad commit
git bisect reset            # back to where you started
```

Each answer halves the search, so even 1,000 commits take about 10 steps. If a script can tell good from bad (exit code 0 = good), let Git do it all: `git bisect run npm test`.

## Try it

In the playground from [`practice/setup.sh`](../practice/setup.sh): edit a file and `restore` it; `reset --soft` the last commit and commit it again; `reset --hard HEAD~2`, then find the commits with `reflog`.

---

[All cheat sheets](../README.md) · ZIB TechSquare, [@zibtechsquare](https://www.youtube.com/@zibtechsquare)
