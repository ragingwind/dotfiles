# NODE
node_clean() {
  find . ! -name node_modules -delete
}

nps() {
  npm version ${1:-patch} && npm publish && git push --follow-tags
}
