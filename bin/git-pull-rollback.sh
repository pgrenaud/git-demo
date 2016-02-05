#!/bin/bash

# git-pull-rollback.sh

# Completly rollback a git-pull operation by:
# * Reseting the master branch and moving back the origin/master to their previous locations (you need to provide the commit hash)
# * Explicitly expiring all reflog and pruning all unreachable objects that were fetched during the git-pull operation
# By doing so, your commit history is restored to the state is was before and all commits that were downloaded are deleted.

git reset --hard "$1"
git update-ref refs/remotes/origin/master "$1"
git reflog expire --expire-unreachable=now --all
git gc --prune=now

# Backup strats:
#    git fsck --no-reflogs
#    git -c gc.reflogExpire=0 -c gc.reflogExpireUnreachable=0 -c gc.rerereResolved=0 -c gc.rerereUnresolved=0 -c gc.pruneExpire=now gc

# Sources:
# * http://stackoverflow.com/a/4528593
# * http://stackoverflow.com/a/14728706
# * https://git-scm.com/docs/git-gc
# * https://git-scm.com/docs/git-prune
# * https://git-scm.com/docs/git-fsck
