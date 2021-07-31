#!/bin/sh

#
# usage: ./deploy.sh                   # moves all files and installs
#    or: ./deploy.sh <program> <stage> # does a specific step for a specific program
#

d_init() {
    cfg_dir="${XDG_CONFIG_DIR:-$HOME/.config}"
    if [ ! -d "$cfg_dir" ]; then
        echo "no config dir, creating at $cfg_dir..."
        mkdir -p $cfg_dir
    fi
}

d_neovim() {
    case "$1" in
        "move")
            echo "copying neovim files..."
            cp -r nvim $cfg_dir
            echo "downloading vim-plug"
            curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
                https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
            ;;
        "install")
            echo "installing neovim plugins..."
            nvim -c 'PlugInstall | qa!'
            ;;
        "clean")
            echo "clearing neovim config..."
            rm -rfI "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim ${cfg_dir}/nvim
            ;;
        *) echo "unknown command" && exit 1;;
    esac
}

d_openbox() {
    case "$1" in
        "move")
            if [ ! -d "$cfg_dir"/openbox ]; then
                echo "creating openbox config folder..."
                mkdir "$cfg_dir"/openbox
            fi
            cp openbox/rc.xml "$cfg_dir"/openbox
            ;;
        "clean")
            rm -rfI "$cfg_dir"/openbox
            ;;
        *) echo "unknown command" && exit 1;;
    esac
}

d_wallpaper() {
    case "$1" in
        "move") cp wall.png "$cfg_dir"/wall.png;;
        *) echo "unknown command" && exit 1;;
    esac
}

# main #

d_init

if [ $# -lt 2 ]; then
    d_neovim move && d_neovim install && echo "neovim done"
    d_openbox move && echo "openbox done"
    d_wallpaper move && echo "wallpaper done"
fi

case "$1" in
    "n"|"d_neovim")
        case "$2" in
            "m"|"move")    d_neovim move;;
            "i"|"install") d_neovim install;;
            "c"|"clean")   d_neovim clean;;
            *) echo "unknown command" && exit 1;;
        esac;;
    "o"|"openbox")
        case "$2" in
            "m"|"move")  d_openbox move;;
            "c"|"clean") d_openbox clean;;
            *) echo "unknown command" && exit 1;;
        esac;;
    "w"|"wallpaper")
        case "$2" in
            "m"|"move")  d_wallpaper move;;
            "c"|"clean") d_wallpaper clean;;
            *) echo "unknown command" && exit 1;;
        esac;;
    *) echo "unknown command" && exit 1;;
esac

echo "done!"
