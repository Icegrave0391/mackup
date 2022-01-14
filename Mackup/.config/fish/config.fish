# bobthefish theme settings
set -g theme_display_hostname no
set -g theme_display_user no
set -g theme_date_format "+%Y-%m-%d %H:%M:%S"
#set -g theme_title_display_path no
#set -g theme_title_display_user no
#set -g theme_newline_cursor yes
#set -g theme_newline_prompt '$ '

switch (uname)
    case Linux
        # conda
        source /home/jianing/miniconda3/etc/fish/conf.d/conda.fish
        # autojump
        source /usr/share/autojump/autojump.fish

    case Darwin
        # conda
        source /Users/jianing/opt/miniconda3/etc/fish/conf.d/conda.fish
        # autojump
        source /usr/local/share/autojump/autojump.fish
end

# rust
#source "$HOME/.cargo/env"
set PATH $HOME/.cargo/bin $PATH

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# wasmtime
set -gx WASMTIME_HOME "$HOME/.wasmtime"
string match -r ".wasmtime" "$PATH" > /dev/null; or set -gx PATH "$WASMTIME_HOME/bin" $PATH

# alias
alias n='nvim'
alias vi='nvim'
alias vim='nvim'
alias r='ranger'

