#!/bin/bash
if [[ -f `pwd`/sharedfuncs ]]; then
  source sharedfuncs
else
  echo "missing file: sharedfuncs"
  exit 1
fi

    #BASHRC {{{
    print_title "BASHRC - https://wiki.archlinux.org/index.php/Bashrc"
    bashrc_list=("Default" "Vanilla" "Get from github");
    PS3="$prompt1"
    echo -e "Choose your .bashrc\n"
    select OPT in "${bashrc_list[@]}"; do
      case "$REPLY" in
        1)
          package_install "git"
          git clone https://github.com/helmuthdu/dotfiles
          cp dotfiles/.bashrc dotfiles/.dircolors dotfiles/.dircolors_256 dotfiles/.nanorc dotfiles/.yaourtrc ~/
          cp dotfiles/.bashrc dotfiles/.dircolors dotfiles/.dircolors_256 dotfiles/.nanorc dotfiles/.yaourtrc /home/${username}/
          rm -fr dotfiles
          ;;
        2)
          cp /etc/skel/.bashrc /home/${username}
          ;;
        3)
          package_install "git"
          read -p "Enter your github username [ex: helmuthdu]: " GITHUB_USER
          read -p "Enter your github repository [ex: aui]: " GITHUB_REPO
          git clone https://github.com/$GITHUB_USER/$GITHUB_REPO
          cp -R $GITHUB_REPO/.* /home/${username}/
          rm -fr $GITHUB_REPO
          ;;
        *)
          invalid_option
          ;;
      esac
      [[ -n $OPT
 ]] && break
    done
    #}}}
