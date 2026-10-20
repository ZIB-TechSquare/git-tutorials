# 3. Clean commit history: 5 Git commands for code review

Commits like "fix bug 2" won't pass code review. These five keep a project's history readable. From the ZIB TechSquare Short *5 Git Commands for a Clean Commit History*.

| I want to... | Command | Rewrites history? |
|--------------|---------|-------------------|
| Commit only part of a file | `git add -p` | No |
| Squash small commits into one | `git rebase -i HEAD~3` | ⚠ Yes |
| Fold a fix into an earlier commit | `git commit --fixup=<commit>` + `git rebase -i --autosquash` | ⚠ Yes |
| Take one fix into another branch | `git cherry-pick <commit>` | No (adds a new commit) |
| Push a rebased branch safely | `git push --force-with-lease` | ⚠ Replaces the remote branch |

## 1. `git add -p`: one change per commit

```bash
git add -p app.py
# Stage this hunk [y,n,q,a,d,s,e,?]?
#   y = stage   n = skip   s = split into smaller hunks   q = quit
```

When one file holds two unrelated changes, commit them separately. Reviewers read one idea at a time.

## 2. `git rebase -i`: squash before you share ⚠

```bash
git rebase -i HEAD~3
# In the editor:
#   pick   a1b2c3d Add login form
#   squash d4e5f6a fix typo        <- melds into the commit above
#   squash 0a9b8c7 fix bug 2
```

`squash` keeps both messages for you to edit, `fixup` drops the small commit's message, `reword` changes a message. Changed your mind mid-way? `git rebase --abort`.

## 3. `git commit --fixup` + `--autosquash`: fix an earlier commit

```bash
git add app.py
git commit --fixup=a1b2c3d            # makes "fixup! Add login form"
git rebase -i --autosquash main       # moves it under a1b2c3d and melds it
git config --global rebase.autoSquash true   # make --autosquash the default
```

No more "fix" commits in the history: the fix lands inside the commit it belongs to, with that commit's message.

## 4. `git cherry-pick`: one fix, another branch

```bash
git switch release
git cherry-pick a1b2c3d     # copy that one commit here as a new commit
git cherry-pick -x a1b2c3d  # -x notes the original hash in the message
```

Good for taking a hotfix into a release branch without merging unfinished work. On a conflict: fix the files, `git add`, then `git cherry-pick --continue` (or `--abort`).

## 5. `git push --force-with-lease`: overwrite only what you expect ⚠

```bash
git push --force-with-lease
git push --force-with-lease --force-if-includes   # extra guard
```

After a rebase your branch no longer matches the remote, so a normal push is refused. `--force` would overwrite anything, including a teammate's new commits. `--force-with-lease` only overwrites the remote branch if it is still where your last fetch saw it.

**Watch out:** a background `git fetch` (some editors run one) updates what "last saw" means and weakens the check; `--force-if-includes` adds a second check that you have actually integrated what was fetched. Never force-push `main` or other shared branches.

## Try it

In the playground from [`practice/setup.sh`](../practice/setup.sh), on the `feature` branch: squash its commits with `rebase -i`, make a `--fixup` for one and `--autosquash` it, then `cherry-pick` one commit onto `main`.

---

[All cheat sheets](../README.md) · ZIB TechSquare, [@zibtechsquare](https://www.youtube.com/@zibtechsquare)
