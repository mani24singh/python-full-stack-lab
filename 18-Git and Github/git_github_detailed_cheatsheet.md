# Git & GitHub — Detailed Cheatsheet (Basics → Advanced)
This guide is designed as a practical reference: **concepts → commands → workflows → recovery**.

## 1) Core Concepts (must-know)

- **Git** = distributed version control system (every developer has full history locally).

- **GitHub** = hosting + collaboration layer (PRs, issues, CI, code review, permissions).

Key ideas:
- **Working Directory** = what you edit
- **Staging Area (Index)** = what you plan to commit
- **Commit** = saved snapshot
- **Remote (origin)** = where you share snapshots

Important Git terms
1. Repository (repo): A project tracked by Git (contains .git/ and full history).
2. Working Directory: Your normal files/folders on disk — where you edit code.
3. Staging Area (Index): Prep zone: you select changes that will go into the next commit.
4. Commit: Snapshot of staged changes with message + metadata.
5. Branch: Pointer to a line of commits (e.g., main, feature/login).
6. Merge: Combine branches; may create a merge commit.
7. Rebase: Replay commits onto a new base for a linear history.
8. HEAD: Pointer to the current checked-out commit/branch.
9. Remote: A Named server repo reference (usually origin).
10. Upstream: The remote branch your branch tracks by default.(eg.origin/main)

## 2) Install + Initial Setup

1. Configure identity (appears in commit history):
    - Sets your author identity for commits.
```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

2. Check Config:
    - Shows active config values (global + local).
```bash
git config --list
git config user.name
git config user.email
```

3. Set default branch name to main (recommended):
    - New repos created by git init will use main.
```bash
git config --global init.defaultBranch main
```

4. Helpful defaults:
    - core.editor: sets your commit-message editor.
    - pull.rebase false: controls whether pull merges or rebases by default.
    - fetch.prune true: cleans deleted remote branches locally during fetch.
```bash
git config --global core.editor "code --wait"
git config --global pull.rebase false
git config --global fetch.prune true
```

## 3) Creating a Repo (Local → GitHub)

Typical first-time setup for a new project:

1. Start repo:
   - Creates .git/ folder and starts tracking.
```bash
git init
```

2. Check status:
    - Shows changed files + what’s staged vs not staged.
```bash
git status
```

3. Stage files:
    - Moves changes into staaging area (selected for next commit).
```bash
git add file.py
git add .
```

4. Commit staged changes:
    - Creates a snapshot (commit) from staged changes.
```bash
git commit -m "Initial commit"
```

5. Rename branch to main:
    - Force-renames current branch to main (safe standard).
```bash
git branch -M main
```

6. Connect to GitHub remote and push
    - remote add: saves remote as origin.
    - push: uploads commits to GitHub.
    - -u: sets upstream so later you can just git push.
```bash
git remote add origin <repo_url>
git push -u origin main
```

Important commands: (Reference)
- **git add** = select changes for next snapshot
- **git commit** = create a snapshot locally
- **git push** = share snapshots to GitHub

## 4) Cloning an Existing Repo
    - Downloads the full repo + history locally and sets origin.
```bash
git clone <repo_url>
```
- Variants:
    - Shallow clone (faster, limited history) — useful for big repos.
```bash
git clone --depth 1 <repo_url>
```

## 5) Daily Workflow (most common)
A safe everyday loop:
    - Use **git diff** before staging to confirm what you’re committing.
    - Pull before push to reduce conflicts.
    - Commit small meaningful changes (easier review + rollback).

- Inspect state
    - status: what’s modified/staged/untracked.
    - diff: shows unstaged changes line-by-line.
```bash
git status
git diff
```

- Stage + commit
    - Stage everything and commit.
```bash
git add <file>    # or: git add .
git commit -m "Describe what changed"
```
- Sync with remote before pushing
    - Fetches + integrates remote changes into your current branch.
```bash
git pull
```

- Push your commits
    - Uploads your local commits to remote.
```bash
git push
```

## 6) Understanding add / commit / push (clear mental model)

- **git add** = “I want *these* changes in the next snapshot” (staging)
- **git commit** = “Create the snapshot locally”
- **git push** = “Upload my snapshots to GitHub”

## 7) Branching (real industry flow)

Branch commands you’ll use daily:

- View branches
    - branch: local branches
    - -a: local + remote branches
```bash
git branch
git branch -a
```

- Create branch
    - Creates branch pointer (doesn’t switch to it).
```bash
git branch feature/auth        
```
    
- Switch branch
    - Moves HEAD and working directory to that branch.
```bash
git checkout feature/auth
# or modern:
git switch feature/auth
```

- Create + switch in one command
    - New branch and immediately start working on it.
```bash
git switch -c feature/payments 
# or: 
git checkout -b feature/payments
```

- Delete branch
    - -d: delete only if merged (safe)
    - -D: force delete (dangerous)
```bash
git branch -d feature/auth    
git branch -D feature/auth    
```

## 8) Remote branches & tracking

- See remotes
    - Lists remotes with fetch/push URLs.
```bash
git remote -v
```

- Fetch remote updates without merging
    - Downloads remote commits/branches but doesn’t change your branch.
```bash
git fetch
```

- Set upstream (tracking)
    - Pushes branch and sets tracking so future git push works.
```bash
git push -u origin feature/payments
```

**Notes:**
- **fetch** downloads remote commits/refs without merging into your branch.
- **pull** fetches and integrates into your current branch.
- **-u** sets upstream tracking so future pushes can be plain *git push*.

## 9) Merging (standard collaboration)

Merge a feature branch into main:
    - Applies feature commits into main (creates merge commit if needed).
```bash
git switch main
git pull
git merge feature/payments
```

**Notes:**
- A **fast-forward** merge happens when main hasn’t moved since the branch diverged (no merge commit needed).

## 10) Rebase (clean history, use carefully)

Rebase your feature branch onto the latest main:

- Rebase feature onto latest main
    - Replays your commits on top of the latest main (linear history).
    - Rule: Don’t rebase commits that others already pulled (shared branch), unless team explicitly allows.
```bash
git switch feature/payments
git fetch origin
git rebase origin/main
```

- Interactive rebase (rewrite history)
    - Edit last 5 commits (squash, reorder, rename messages).
```bash
git rebase -i HEAD~5
```

Common actions inside interactive rebase:
- pick keep commit
- reword change message
- squash combine commits
- drop remove commit

## 11) Undo & Recovery (most important advanced basics)

Use the right tool depending on whether commits are pushed/shared:

1. Discard local unstaged changes (danger)
    - Resets file to last commited state (loses local edits)
```bash
git restore <file>             
git restore file.py     # Example
```

2. Unstage (keep changes in file)
    - Removes from staging but keeps modifications.
```bash
git restore --staged <file>         
```

3. Amend last commit (change message or include more files)
    - Rewrites the last commit with new staged content.
```bash
git add .
git commit --amend                
```

4. Undo last commit but keep changes (soft reset)
    - Removes last commit, keeps changes staged.
```bash
git reset --soft HEAD~1             
```

5. Undo last commit and unstage changes (mixed reset default)
    - Removes last commit, keeps changes unstaged.
```bash
git reset HEAD~1                    
```

6. Undo last commit and delete changes (hard reset — very dangerous)
    - Deletes commit AND local changes permanently (unless recoverable via reflog).
```bash
git reset --hard HEAD~1            
```

7. Safe undo for shared history: revert
    - Creates a NEW commit that reverses the target commit (safe for pushed commits).
```bash
git revert <commit_hash>            
```

8. Recover “lost” commits: reflog (lifesaver)
    - Shows HEAD movements even after resets; helps recover commits.
```bash
git reflog                         
git checkout <old_hash>
```

**Notes:**
- **reset** rewrites history; use carefully on shared branches.
- **revert** is safe for shared history because it adds a new commit.
- **reflog** is your emergency recovery tool.


## 12) Logs & inspection (debugging)

1. Basic log
    - Shows history; the second view is best for understanding branches.
```bash
git log
git log --oneline --graph --decorate --all
```

2. Show commit details
    - Shows patch + metadata for that commit.
```bash
git show <commit_hash>
```

3. Compare changes
    - diff: unstaged changes
    - --staged: staged changes
    - main..feature: differences between branches
```bash
git diff
git diff --staged  # shows what you’re about to commit.
git diff main..feature/payments
```

4. Find who changed a line
    - Shows last commit and author for each line.
```bash
git blame <file>  # answers: “who changed this line and when?”
```

## 13) Stashing (temporary save/shelf)

1. Stash Changes
    - Stores uncommited changes and cleans working directory 
```bash
git stash
git stash push -m "WIP: pipeline refactor"
```

2. Apply stash
    - pop: apply + delete stash
    - apply: apply without deleting
```bash
git stash pop
git stash apply
```

3. List $ drop stash
    - Manage multiple stashes
```bash
git stash list
git stash drop stash@{0}
```

**Notes:**
- Stash is perfect when you must switch branches quickly without committing WIP.

## 14) Cherry-pick (copy a specific commit)
- Applies a commit from another branch onto current branch (useful for hotfix).
```bash
git cherry-pick <commit_hash>
```

**Notes:**
- Use when you need one fix from another branch (common in hotfix workflows).

## 15) Tags (releases)

1. Create tag
    - Marks a commit as a release point (lightweight vs annotated).
```bash
git tag v1.0.0
git tag -a v1.0.0 -m "First stable release"
```

2. Push tags
    - Upload tags to Github
```bash
git push origin v1.0.0
git push --tags
```

## 16) .gitignore (don’t track junk)

1. Create .gitignore and add patterns:
    - Prevents new files matching patterns from being tracked.
Example .gitignore:
```
__pycache__/
.env
*.log
node_modules/
dist/
```

2. Important: If file already tracked, .gitignore won’t remove it automatically.
    - Untracks file but keeps it locally.
```bash
git rm --cached .env
```

## 17) Merge conflicts (why + how to resolve)

1. Conflicts occur when two branches change the same lines and Git can’t auto-merge.
2. Conflict markers look like:
    - Open the conflicted file, choose the correct final code, remove markers.
    - Stage resolved files, then commit (or continue rebase).
    - Abort if you need to stop and return to the previous state.
3. Commands:
- Marks conflict as resolved and finalizes merge/rebase.
```bash
git status
git add <resolved_files>
git commit
```
- If you want to abort use following commands, which Cancels the operation and restores previous state.
```bash
git merge --abort
git rebase --abort
```

## 18) GitHub Pull Request (PR) flow

A **Pull Request (PR)** is a request to merge your branch into another branch (usually **main**).

Typical PR flow:
- Create a feature branch locally
- Commit changes
- Push branch: **git push -u origin feature/x**
- Open PR on GitHub (base = main)
- Code review + CI checks
- Merge after approval (merge commit / squash / rebase merge — team preference)

Useful:
- Fork workflow (open-source): you fork → PR to upstream.
- Branch protection: require reviews, CI, prevent direct pushes to main.

**Notes:**
- PRs enable discussion, quality gates, audit history, and safer production releases.

## 19) Authentication (HTTPS vs SSH)

SSH is recommended long-term for convenience and security.
- Create SSH Key
- Add public key to Github
- Use SSH remote URL: git@github.com:user/repo.git
- Following Command: Verifies SSH auth to GitHub.
```bash
ssh -T git@github.com
```

**Notes:**
- If configured properly, GitHub confirms authentication.

## 20) Power tools (advanced, used by seniors)

1. Clean untracked files (careful)
    - Deletes untracked files and directories (dangerous).
```bash
git clean -fdn                 # dry-run: show what would be deleted
git clean -fd                  # delete untracked files/dirs (danger)
```

2. Bisect (find bug-introducing commit)'
    - Binary-search through commits to locate where bug started.
```bash
git bisect start               # start binary search for bug commit
git bisect bad
git bisect good <hash>
```

3. Worktrees (multiple branches in separate folders)
    - Check out another branch in a different directory without switching.
```bash
git worktree add ../hotfix hotfix/urgent  # another branch in another folder
```

**Notes:**
- Always run **git clean -n** first to avoid accidental deletion.
- **bisect** helps locate the commit that introduced a bug.

## 21) Conventional commit messages (clean history)
- Makes changes searchable and release-friendly.
- Examples:
    - feat: add trip score normalization
    - fix: handle null charging sessions
    - refactor: split scoring logic into modules
    - docs: update README
    - test: add unit tests for aggregation

**Notes:**
- This makes history readable and helps automate changelogs/releases.

## 22) Quick “What should I use?” guide

| Situation | Use this | Meaning / Why |
| --- | --- | --- |
| Undo local file edits (unstaged) | git restore <file> | Discard local edits and return to last committed state. |
| Unstage a file (keep edits) | git restore --staged <file> | Remove from staging while keeping local edits. |
| Undo last commit, keep changes staged | git reset --soft HEAD~1 | Moves HEAD back; changes remain staged. |
| Undo last commit, keep changes unstaged | git reset HEAD~1 | Moves HEAD back; changes remain in working directory. |
| Undo last commit and delete changes | git reset --hard HEAD~1 | Danger: removes commit and deletes local changes. |
| Undo a pushed commit safely | git revert <hash> | Adds a new commit that reverses the earlier commit. |
| Update feature branch cleanly | git rebase origin/main | Replays your commits onto latest main for linear history. |
| Pick one commit from another branch | git cherry-pick <hash> | Applies that commit on current branch (great for hotfix). |
| Recover commits after mistakes | git reflog | Find old HEAD positions and recover commits. |

## 23) Mini command dictionary (fast lookup)

| Command | What it does (meaning) |
| --- | --- |
| git init | Start a new repository in the current directory. |
| git clone <url> | Copy a remote repo (with history) locally. |
| git status | Show current state: staged/unstaged/untracked, branch info. |
| git add <file.py>| stage changes| Stage changes for next commit. |
| git commit -m "msg" | Create a commit (snapshot) from staged changes. |
| git log | Show commit history. |
| git diff | Show changes between states (working tree/stage/commits). |
| git branch | List/create/delete branches. |
| git switch/checkout | Move between branches/commits. |
| git merge <branch> | Combine another branch into current branch. |
| git rebase <base> | Replay commits onto a new base (linear history). |
| git fetch | Download remote data without integrating. |
| git pull | Fetch + integrate into current branch. |
| git push | Upload commits to remote. |
| git stash | Temporarily store uncommitted changes. |
| git reset | Move HEAD pointer (can rewrite history). |
| git revert <hash> | Undo via a new commit (safe for shared history). |
| git reflog | Recover old commits/HEAD positions after mistakes. |

## Golden Rules

**Git is not about memorizing commands.** It’s about confidence to change code without fear.

- Pull before push to reduce conflicts.
- Never commit secrets (use .env + secret managers).
- Small commits > big commits.
- Use feature branches + PR review.
- Prefer revert for shared history; use reset carefully.


---
<p align="right"><b>Happy Learning 🚀</b><br/> — Mani</p>