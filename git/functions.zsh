git-init() {
    git init
    touch readme.md
    git add readme.md
    git commit -m "first commit"
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
