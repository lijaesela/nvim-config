#!/bin/sh

#
# usage: ./deploy.sh                   # moves all files and installs
#    or: ./deploy.sh <program> <stage> # does a specific step for a specific program
# examples: ./deploy.sh neovim deps  # installs OS dependencies for neovim
#           ./deploy.sh openbox move # moves the openbox config files
#

set -e

[ -n "${distro+1}" ] || distro="$(lsb_release -is)"
cfg_dir="${XDG_CONFIG_DIR:-$HOME/.config}"
pkg_dir="$HOME/pkg"
rootcmd="sudo"

supported_distros="Arch"

d_info() {
    printf "[32m[./deploy.sh][m "
    echo "$@"
}

d_init() {
    if [ ! -d "$cfg_dir" ]; then
        d_info "no config dir, creating at $cfg_dir..."
        mkdir -p $cfg_dir
    fi
    if [ ! -d "$pkg_dir" ]; then
        d_info "no pkg dir, creating at $pkg_dir..."
        mkdir -p $pkg_dir
    fi
    case "$distro" in
        "Arch")
            pacman="pacman -S"
            pkgs_neovim="neovim python-pynvim nodejs npm ccls"
            pkgs_openbox="xorg-server xorg-xinit openbox obconf dmenu feh"
            ;;
        "") d_info "distro is blank. does your system have 'lsb_release'?" && exit 1;;
        *)
            d_info "unsupported distro '$distro'"
            d_info "supported distros are: $supported_distros"
            exit 1
            ;;
    esac
    d_info "detected distro '$distro'"
}

d_neovim() {
    case "$1" in
        "deps")
            d_info "installing neovim dependencies..."
            $rootcmd $pacman $pkgs_neovim
            ;;
        "move")
            d_info "copying neovim files..."
            cp -r nvim $cfg_dir
            d_info "downloading vim-plug"
            curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
                https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
            ;;
        "install")
            d_info "installing neovim plugins..."
            nvim -c 'PlugInstall | qa!'
            ;;
        "clean")
            d_info "clearing neovim config..."
            rm -rfI "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim ${cfg_dir}/nvim
            ;;
        *) d_info "unknown command" && exit 1;;
    esac
}

d_openbox() {
    case "$1" in
        "deps")
            $rootcmd $pacman $pkgs_openbox
            ;;
        "move")
            cp openbox "$cfg_dir"
            cp wall.png "$cfg_dir"/wall.png
            ;;
        "clean")
            rm -rfI "$cfg_dir"/openbox
            ;;
        *) d_info "unknown command" && exit 1;;
    esac
}

d_st() { # UNFINISHED: do not add to program
    case "$1" in
        "deps")
            $rootcmd $pacman $pkgs_st
            ;;
        "move") cp st "$pkg_dir";;
        "install")
            cd "$pkg_dir"/st &&
                make &&
                $rootcmd make install
            ;;
        *) d_info "unknown command" && exit 1;;
    esac
}

d_lf() { # UNFINISHED: do not add to program
    case "$1" in
        "move") cp lf "$cfg_dir"/lf;;
        *) d_info "unknown command" && exit 1;;
    esac
}

# main #

d_init

if [ $# -lt 2 ]; then
    d_info "you have not given an action. install everything? [y/n]"

    read reply
    case "$reply" in "Y"|"y");; *) exit 1;; esac

    d_neovim deps  && d_neovim move  && d_neovim install &&
        d_info "neovim done"
    d_openbox deps && d_openbox move &&
        d_info "openbox done"
fi

case "$1" in
    "n"|"d_neovim")
        case "$2" in
            "d"|"deps")    d_neovim deps;;
            "m"|"move")    d_neovim move;;
            "i"|"install") d_neovim install;;
            "c"|"clean")   d_neovim clean;;
            *) d_info "unknown command" && exit 1;;
        esac;;
    "o"|"openbox")
        case "$2" in
            "d"|"deps")  d_openbox deps;;
            "m"|"move")  d_openbox move;;
            "c"|"clean") d_openbox clean;;
            *) d_info "unknown command" && exit 1;;
        esac;;
    *) d_info "unknown command" && exit 1;;
esac

d_info "done!"
