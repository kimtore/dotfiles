# vi: se ft=zsh:

LANG="en_US.UTF-8"

if [ "$(uname)" = "Darwin" ]; then
    LC_NUMERIC="no_NO.UTF-8"
    LC_COLLATE="no_NO.UTF-8"
    LC_MONETARY="no_NO.UTF-8"
    LC_PAPER="no_NO.UTF-8"
    LC_NAME="no_NO.UTF-8"
    LC_ADDRESS="no_NO.UTF-8"
    LC_TELEPHONE="no_NO.UTF-8"
    LC_MEASUREMENT="no_NO.UTF-8"
    LC_IDENTIFICATION="no_NO.UTF-8"
else
    LC_NUMERIC="nb_NO.UTF-8"
    LC_COLLATE="nb_NO.UTF-8"
    LC_MONETARY="nb_NO.UTF-8"
    LC_PAPER="nb_NO.UTF-8"
    LC_NAME="nb_NO.UTF-8"
    LC_ADDRESS="nb_NO.UTF-8"
    LC_TELEPHONE="nb_NO.UTF-8"
    LC_MEASUREMENT="nb_NO.UTF-8"
    LC_IDENTIFICATION="nb_NO.UTF-8"

    # Solarized theme for real consoles
    source ~/dotfiles/contrib/tty-solarized/tty-solarized-dark.sh
fi

export LANG LC_NUMERIC LC_COLLATE LC_MONETARY LC_PAPER LC_NAME LC_ADDRESS LC_TELEPHONE LC_MEASUREMENT LC_IDENTIFICATION
