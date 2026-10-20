# Git Tutorials

Git cheat sheets and practice exercises from the **ZIB TechSquare** *Dev Hints* Shorts on YouTube: [@zibtechsquare](https://www.youtube.com/@zibtechsquare).

Each Short shows five commands in under a minute. Each cheat sheet here explains them properly, with examples, what to watch out for and how to undo them.

## Cheat sheets

| # | Topic | Commands | Video |
|---|-------|----------|-------|
| 1 | [Disaster recovery](cheatsheets/01-disaster-recovery.md) | `restore`, `reset --soft`, `revert`, `reflog`, `bisect` | coming 2026-10-24 |
| 2 | [Everyday workflow](cheatsheets/02-everyday-workflow.md) | `switch -c`, `stash`, `diff --staged`, `commit --amend`, `log --graph` | coming 2026-10-31 |
| 3 | [Clean commit history](cheatsheets/03-clean-history.md) | `add -p`, `rebase -i`, `commit --fixup`, `cherry-pick`, `push --force-with-lease` | coming 2026-11-07 |

## Practise safely

Never try a new Git command on real work first. [`practice/setup.sh`](practice/setup.sh) builds a throwaway repository with a few commits, a branch and an uncommitted change, so you can try every command here and break nothing:

```bash
bash practice/setup.sh          # creates ./git-playground
cd git-playground
git log --oneline --graph --all
```

Delete the `git-playground` folder when you're done, and run the script again for a fresh start.

## Golden rule

Commands that **rewrite history** (`reset`, `commit --amend`, `rebase`) are safe on commits only you have. Once a commit is pushed and others may have it, undo it with `git revert` instead. Each cheat sheet marks these commands with ⚠.

## Questions and fixes

Found a mistake, or want a topic covered? [Open an issue](https://github.com/ZIB-TechSquare/git-tutorials/issues), or comment on the video.

---

**ZIB TechSquare** — technology built around you. Work with us: zibtechsquare@gmail.com · [github.com/ZIB-TechSquare](https://github.com/ZIB-TechSquare)

Released under [CC0 1.0](LICENSE): free to copy, share and adapt for any purpose. Credit to ZIB TechSquare is welcome but not required.
