doskey afind=ack -il
doskey egrep=egrep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}
doskey fgrep=fgrep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}
doskey g=git
doskey ga=git add
doskey gaa=git add --all
doskey gam=git am
doskey gama=git am --abort
doskey gamc=git am --continue
doskey gams=git am --skip
doskey gamscp=git am --show-current-patch
doskey gap=git apply
doskey gapa=git add --patch
doskey gapt=git apply --3way
doskey gau=git add --update
doskey gav=git add --verbose
doskey gb=git branch
doskey gbD=git branch -D
doskey gba=git branch -a
doskey gbd=git branch -d
doskey gbda=git branch --no-color --merged | command grep -vE "^(\+|\*|\s*($(git_main_branch)|development|develop|devel|dev)\s*$)" | command xargs -n 1 git branch -d
doskey gbl=git blame -b -w
doskey gbnm=git branch --no-merged
doskey gbr=git branch --remote
doskey gbs=git bisect
doskey gbsb=git bisect bad
doskey gbsg=git bisect good
doskey gbsr=git bisect reset
doskey gbss=git bisect start
doskey gc=git commit -v
doskey gc!=git commit -v --amend
doskey gca=git commit -v -a
doskey gca!=git commit -v -a --amend
doskey gcam=git commit -a -m
doskey gcan!=git commit -v -a --no-edit --amend
doskey gcans!=git commit -v -a -s --no-edit --amend
doskey gcb=git checkout -b
doskey gcd=git checkout develop
doskey gcf=git config --list
doskey gcl=git clone --recurse-submodules
doskey gclean=git clean -id
doskey gcm=git checkout $(git_main_branch)
doskey gcmsg=git commit -m
doskey gcn!=git commit -v --no-edit --amend
doskey gco=git checkout
doskey gcount=git shortlog -sn
doskey gcp=git cherry-pick
doskey gcpa=git cherry-pick --abort
doskey gcpc=git cherry-pick --continue
doskey gcs=git commit -S
doskey gcsm=git commit -s -m
doskey gd=git diff
doskey gdca=git diff --cached
doskey gdct=git describe --tags $(git rev-list --tags --max-count=1)
doskey gdcw=git diff --cached --word-diff
doskey gds=git diff --staged
doskey gdt=git diff-tree --no-commit-id --name-only -r
doskey gdw=git diff --word-diff
doskey gf=git fetch
doskey gfa=git fetch --all --prune
doskey gfg=git ls-files | grep
doskey gfo=git fetch origin
doskey gg=git gui citool
doskey gga=git gui citool --amend
doskey ggpull=git pull origin "$(git_current_branch)"
doskey ggpur=ggu
doskey ggpush=git push origin "$(git_current_branch)"
doskey ggsup=git branch --set-upstream-to=origin/$(git_current_branch)
doskey ghh=git help
doskey gignore=git update-index --assume-unchanged
doskey gignored=git ls-files -v | grep "^[[:lower:]]"
doskey git-svn-dcommit-push=git svn dcommit && git push github $(git_main_branch):svntrunk
doskey gk=\gitk --all --branches
doskey gke=\gitk --all $(git log -g --pretty=%h)
doskey gl=git pull
doskey glg=git log --stat
doskey glgg=git log --graph
doskey glgga=git log --graph --decorate --all
doskey glgm=git log --graph --max-count=10
doskey glgp=git log --stat -p
doskey glo=git log --oneline --decorate
doskey globurl=noglob urlglobber
doskey glod=git log --graph --pretty=\%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset\
doskey glods=git log --graph --pretty=\%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset\ --date=short
doskey glog=git log --oneline --decorate --graph
doskey gloga=git log --oneline --decorate --graph --all
doskey glol=git log --graph --pretty=\%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset\
doskey glola=git log --graph --pretty=\%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset\ --all
doskey glols=git log --graph --pretty=\%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset\ --stat
doskey glp=_git_log_prettily
doskey glum=git pull upstream $(git_main_branch)
doskey gm=git merge
doskey gma=git merge --abort
doskey gmom=git merge origin/$(git_main_branch)
doskey gmt=git mergetool --no-prompt
doskey gmtvim=git mergetool --no-prompt --tool=vimdiff
doskey gmum=git merge upstream/$(git_main_branch)
doskey gp=git push
doskey gpd=git push --dry-run
doskey gpf=git push --force-with-lease
doskey gpf!=git push --force
doskey gpoat=git push origin --all && git push origin --tags
doskey gpristine=git reset --hard && git clean -dffx
doskey gpsup=git push --set-upstream origin $(git_current_branch)
doskey gpu=git push upstream
doskey gpv=git push -v
doskey gr=git remote
doskey gra=git remote add
doskey grb=git rebase
doskey grba=git rebase --abort
doskey grbc=git rebase --continue
doskey grbd=git rebase develop
doskey grbi=git rebase -i
doskey grbm=git rebase $(git_main_branch)
doskey grbo=git rebase --onto
doskey grbs=git rebase --skip
doskey grep=grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}
doskey grev=git revert
doskey grh=git reset
doskey grhh=git reset --hard
doskey grm=git rm
doskey grmc=git rm --cached
doskey grmv=git remote rename
doskey groh=git reset origin/$(git_current_branch) --hard
doskey grrm=git remote remove
doskey grs=git restore
doskey grset=git remote set-url
doskey grss=git restore --source
doskey grst=git restore --staged
doskey grt=cd "$(git rev-parse --show-toplevel || echo .)"
doskey gru=git reset --
doskey grup=git remote update
doskey grv=git remote -v
doskey gsb=git status -sb
doskey gsd=git svn dcommit
doskey gsh=git show
doskey gsi=git submodule init
doskey gsps=git show --pretty=short --show-signature
doskey gsr=git svn rebase
doskey gss=git status -s
doskey gst=git status
doskey gsta=git stash save
doskey gstaa=git stash apply
doskey gstall=git stash --all
doskey gstc=git stash clear
doskey gstd=git stash drop
doskey gstl=git stash list
doskey gstp=git stash pop
doskey gsts=git stash show --text
doskey gstu=git stash --include-untracked
doskey gsu=git submodule update
doskey gsw=git switch
doskey gswc=git switch -c
doskey gtl=gtl(){ git tag --sort=-v:refname -n -l "${1}*" }; noglob gtl
doskey gts=git tag -s
doskey gtv=git tag | sort -V
doskey gunignore=git update-index --no-assume-unchanged
doskey gunwip=git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1
doskey gup=git pull --rebase
doskey gupa=git pull --rebase --autostash
doskey gupav=git pull --rebase --autostash -v
doskey gupv=git pull --rebase -v
doskey gwch=git whatchanged -p --abbrev-commit --pretty=medium
doskey gwip=git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign -m "--wip-- [skip ci]"
doskey l=ls -lah
doskey la=ls -lAh
doskey ll=ls -lh
doskey ls=ls --color=auto
doskey lsa=ls -lah
doskey md=mkdir -p
doskey rd=rmdir
doskey which-command=whence

