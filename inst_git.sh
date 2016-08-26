#!/bin/sh

# Fonction pour vérifier l'état de la commande précédente
check() {
    if [ $? = 0 ]
            then
                    echo "\nInstallation OK."
            else
                    echo "\nErreur lors de l'installation."
    fi
}

install_bash_git_prompt() {

echo "  - Installation en cours de bash-git-prompt..."
if [ ! -d /usr/local/scripts ] ; then
  sudo mkdir /usr/local/scripts/
fi

if [ ! -d /usr/local/scripts/.bash-git-prompt ] ; then
  sudo git clone https://github.com/magicmonty/bash-git-prompt.git /usr/local/scripts/.bash-git-prompt --depth=1
fi

sudo cp -r /usr/local/scripts/.bash-git-prompt /home/$USER/ \
&& sudo chown -R $USER:$USER /home/$USER/.bash-git-prompt

echo "  - Configuration du bashrc..."
if grep -Fxq "source ~/.bash-git-prompt/gitprompt.sh" /home/$USER/.bashrc ; then
  echo "    - Déjà configuré"
else
  echo "source ~/.bash-git-prompt/gitprompt.sh" >> /home/$USER/.bashrc
  echo "GIT_PROMPT_ONLY_IN_REPO=1" >> /home/$USER/.bashrc
fi

}


echo "\n[INFO] Installation de Git + Git-GUI..."
sudo apt-get install -y git git-gui gitg gitk 1> /dev/null
check

echo -n "\nDésirez-vous installer un prompt bash git? (y/n): "
read INSTALL
    case "$INSTALL" in
        y) install_bash_git_prompt ;;
        n) break ;;
        *) echo "\nRéponse non valide." >&2 ;;
    esac

exit 0
