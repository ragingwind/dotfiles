alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias glog2="git log --graph --pretty=format:'%s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias ga='git add'
alias gpush='git push origin $2'
alias gpull='git pull origin $2'
alias gpu='git fetch upstream -v; git merge upstream/master; git rebase upstream/master'
alias gpa='git push origin master --tags'
alias gru='git pull --rebase upstream master'
alias gaa='git add -A .;git commit -a -m '$2''
alias gpom='git pull origin master'
alias gs='git status -sb'
alias gc='git commit'
alias gca='git commit -a -m '$2''
alias gct='git commit -a -m '$2' --date"$(theday after)"'
alias gcy='git commit -a -m '$2' --date"$(theday before)"'
alias gac='git add -A;git commit -a -m '$2''
alias gch='git checkout'
alias gb='git branch'
alias gd='git diff'
alias greset='git reset --hard HEAD~1'
alias grv='git remote -v'
alias gst='git status'
alias gdiff='git vimdiff'
alias merge-to="!f() { git checkout $1 && echo git merge $2 && echo git checkout -; }; f"
alias gundo='git reset HEAD@{1}'
alias gbsort='git branch --sort=-committerdate'
alias gh-remove='git push origin `git subtree split --prefix out master`:gh-pages --force'

git-init() {
    git init
    touch README.md
    git add readme.md
    git commit -m "add readme doc"
    git remote add origin "$@"
    git push -u origin master
}

git-touch-commit() {
    now=$(date)
    if ! [ -z "$@" ]; then
        now="$@"
    fi
    echo $now
    git commit --amend --date="$now"
}

git-push-all() {
    git push origin master --tags
}

git-remote-tag() {
    git tag -d $@
    git push origin :refs/tags/$@
}

git-remove-systemfile() {
    find . -name .DS_Store -print0 | xargs -0 git rm --ignore-unmatch
}

git-commit-before() {
  git commit $@ --date "$(theday before)"
}
