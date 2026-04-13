
function gam() { "/Users/stevenswan/bin/gam/gam" "$@" ; }

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/stevenswan/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/stevenswan/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/stevenswan/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/stevenswan/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH="$(npm prefix -g)/bin:$PATH"
export PATH="/opt/homebrew/opt/node@22/bin:/usr/local/opt/node@22/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="/opt/homebrew/opt/node@22/bin:/opt/homebrew/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="/usr/local/share/google-cloud-sdk/bin:$PATH"
export PATH="/usr/local/share/google-cloud-sdk/bin:$PATH"
export GITHUB_PAT="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"
export VAULT_REPO="staffbotsteve/swan-vault"
alias swan-ops="cd ~/Documents/swan-ops"
