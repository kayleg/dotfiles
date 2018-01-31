source ~/.bash/aliases
source ~/.bash/completions
source ~/.bash/paths
source ~/.bash/config

# use .localrc for settings specific to one system
if [ -f ~/.localrc ]; then
  source ~/.localrc
fi

PATH=$PATH:$HOME/.rbenv/bin:$HOME/.rbenv/shims # Add RVM to PATH for scripting

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# added by travis gem
[ -f /Users/kayle/.travis/travis.sh ] && source /Users/kayle/.travis/travis.sh

### Added by the Bluemix CLI
source /usr/local/Bluemix/bx/bash_autocomplete

export PATH="$HOME/.yarn/bin:$PATH"
