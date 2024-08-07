# Jump support
if [ -x "$(command -v "jump")" ]; then
    eval "$(jump shell zsh)"
else
    printf  "Jump is not installed."
fi

# direnv support
eval "$(direnv hook zsh)"

# Golang
export GOPATH=$HOME/go
export PATH="$HOME/go/bin:$PATH"
