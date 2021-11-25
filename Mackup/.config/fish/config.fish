# bobthefish theme settings
set -g theme_display_hostname no
set -g theme_display_user no
set -g theme_date_format "+%Y-%m-%d %H:%M:%S"
#set -g theme_title_display_path no
#set -g theme_title_display_user no
#set -g theme_newline_cursor yes
#set -g theme_newline_prompt '$ '

# conda
source /home/jianing/miniconda3/etc/fish/conf.d/conda.fish

if status is-interactive
    # Commands to run in interactive sessions can go here
end

