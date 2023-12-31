export PATH="$(dirname $0):$PATH"

# extend any tool with additional commands
export __EXT_DIR=${HOME}/.dotfiles/shell/ext

# load all of the custom commands in bash/ext/
for ext in $(find $__EXT_DIR -maxdepth 1 -type d -and -not -name '.*'); do
    if [ "$ext" != "$__EXT_DIR" ] && [ "$ext" != "$__EXT_DIR/cmd" ]; then
        # alias the command to the __ext_cmd wrapper method
        alias $(basename $ext)="__didyoumean __ext_cmd $(basename $ext)"
        source $ext/init.sh
        # for cmd in $(find $ext -maxdepth 1 -type f); do
        #     # source files and export custom functions
        #     # function names must match '__ext_[command]_[custom command or override]'
        #     source $ext/$(basename $cmd)
        #     if [ "function" = "$(type -t "__ext_$(basename $ext)_$(basename $cmd)")" ]; then
        #         export -f "__ext_$(basename $ext)_$(basename $cmd)"
        #     fi
        # done
    fi
done
