#
# extend any tool with additional commands
#

export PATH="$(dirname $0):$PATH"
export __EXT_DIR=${HOME}/.dotfiles/shell/ext

# enable tab completion for aliased commands
setopt COMPLETE_ALIASES

# load all of the custom commands in bash/ext/
for ext in $(find $__EXT_DIR -maxdepth 1 -type d -and -not -name '.*'); do
    if [ "$ext" != "$__EXT_DIR" ] && [ "$ext" != "$__EXT_DIR/cmd" ]; then
        # alias the command to the __ext_cmd wrapper method
        alias $(basename $ext)="__didyoumean __ext_cmd $(basename $ext)"
        source $ext/init.sh
    fi
done
