alias dpwd='docker run --rm -it -v "${PWD}":"${PWD}" -w "${PWD}"'
alias cat='bat'
alias ls='exa -la --icons'

alias l='exa --icons'
alias ll='exa -l --icons'
alias la='exa -la --icons'

alias vim=nvim

alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign -m "--wip-- [skip ci]"'
alias gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'
