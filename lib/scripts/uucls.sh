#! /usr/bin/env bash

# Written in 2023 by J. Korbmacher (j.korbmacher@uu.nl) with contributions by
# Ty Mees (t.d.mees@uu.nl).

# To the extent possible under law, the author(s) have dedicated all copyright
# and related and neighboring rights to this software to the public domain
# worldwide. This software is distributed without any warranty.

# You should have received a copy of the CC0 Public Domain Dedication along
# with this software. If not, see
# <http://creativecommons.org/publicdomain/zero/1.0/>.

set -euo pipefail

# Catch command

COMMAND=${1:-""}

# Global variables

INST_STATE=0
UPDATE_STATE=0
PANDOC_STATE=0

INST_PATH=""

MANIFEST=".uucls"

SCRIPT_REPO="lib/scripts/uucls.sh"
SCRIPT_LOCAL="/usr/local/bin/uucls"

REMOTE="https://github.com/UtrechtUniversity/uucls.git"

_check_for_dependencies_() {

	if [[ ! $(command -v kpsewhich) ]]; then
		echo "Kpathsea not found in PATH. Is LaTeX installed?"
		exit 1
	elif [[ ! $(command -v git) ]]; then
		echo "Git not found in PATH. Is it installed?"
		exit 1
	elif [[ ! $(kpsewhich -var-value TEXMFHOME) ]]; then
		echo "The variable TEXMFHOME is not properly set."
		echo "Are you sure you're using texlive/MacTex?"
		exit 1
	fi

}

_determine_installation_state_() {

	if [[ $(kpsewhich $MANIFEST) ]]; then
		INST_STATE=1
	else
		INST_STATE=0
	fi

}

_warning_() {

	_determine_installation_state_

	if [[ $INST_STATE == 0 ]]; then
		cat <<EOF
You're about to run a script from the internet(tm). Please take a moment to
inspect it under:

        $REMOTE/lib/scripts/uucls.sh

Don't just blindly run scripts from the internet!

Note that there's no warranty of any kind.

EOF
		while true; do
			read -p "Did you inspect the script and are OK with running it? (Y/n)" yn
			case $yn in
			"" | [Yy]*)
				echo "Cool, cool, cool!"
				break
				;;
			[Nn]*)
				echo "Alrighty, have a good one!"
				exit 0
				;;
			*)
				echo "Please answer Y/y or N/n."
				;;
			esac
		done

	fi
}

_determine_installation_path_() {

	local TEXMFPATH=""

	if [[ $INST_STATE == 1 ]]; then
		INST_PATH=$(dirname $(kpsewhich $MANIFEST))
	elif [[ $INST_STATE == 0 ]]; then
		TEXMFPATH=$(kpsewhich -var-value TEXMFHOME)
		INST_PATH=${TEXMFPATH}/tex/latex/uucls
	fi

}

_determine_update_state_() {

	git -C $INST_PATH remote update &>/dev/null

	local LOCAL=$(git -C $INST_PATH rev-parse @)
	local REMOTE=$(git -C $INST_PATH rev-parse @{u})
	local BASE=$(git -C $INST_PATH merge-base @ @{u})

	if [ $LOCAL = $REMOTE ]; then
		# Up-to-date
		UPDATE_STATE=0
	elif [ $LOCAL = $BASE ]; then
		# Updates available
		UPDATE_STATE=1
	else
		# Unpushed changes, forked, or whatever
		UPDATE_STATE=2
	fi
}

_install_updates_() {

	echo "Installing updates..."
	echo "> Step 1. Updating the packages..."
	git -C $INST_PATH reset --hard --quiet
	git -C $INST_PATH pull --quiet
	echo "> Step 2. Reinstalling command line utility..."
	echo "          Note: This requires root access."
	SCRIPT=$INST_PATH/$SCRIPT_REPO
	sudo install $SCRIPT $SCRIPT_LOCAL
}

_update_() {

	_determine_installation_state_

	if [[ $INST_STATE == 0 ]]; then
		echo "Package not installed properly."
		echo "Install it and try again."
		exit 1
	fi

	_determine_installation_path_
	_determine_update_state_

	if [[ $UPDATE_STATE == 0 ]]; then
		echo "Packages already up-to-date."
	elif [[ $UPDATE_STATE == 1 ]]; then
		echo "There are updates available."
		while true; do
			read -p "Would you like to install them? (Y/n)" yn
			case $yn in
			"" | [Yy]*)
				_install_updates_
				break
				;;
			[Nn]*)
				echo "Warning: Outdated packages are not supported."
				exit 0
				;;
			*)
				echo "Please answer Y/y or N/n."
				;;
			esac
		done
	elif [[ $UPDATE_STATE == 2 ]]; then
		echo "It looks like you changed/added files."
		echo "Continuing will delete those change/additions."
		while true; do
			read -p "Do it anyways? (Y/n)" yn
			case $yn in
			"" | [Yy]*)
				echo "Aaaaand they're gone!"
				$UPDATE_STATE=1
				_determine_installation_path_
				_install_updates_
				break
				;;
			[Nn]*)
				echo "Alright! Maybe try backing up and then updating?"
				exit 0
				;;
			*)
				echo "> Please answer Y/y or N/n."
				;;
			esac
		done
	fi

	_determine_update_state_

	if [[ $UPDATE_STATE == 0 ]]; then
		echo "Success!"
	elif [[ $UPDATE_STATE == 1 ]]; then
		echo "Hmm... that's weird! It didn't work"
		echo "Maybe no internet connection?"
		exit 1
	fi

}

_install_() {

	# Install routine

	if [[ $INST_STATE == 1 ]]; then
		echo "The package is already installed."
		exit 0
	elif [[ $INST_STATE == 0 ]]; then
		_determine_installation_path_
		echo "Installing the packages..."
		echo "> Cloning repository..."
		git clone $REMOTE $INST_PATH
		echo "> Installing command line utility..."
		echo "Note: This requires root access."
		SCRIPT=$INST_PATH/$SCRIPT_REPO
		sudo install $SCRIPT $SCRIPT_LOCAL
	fi

	# Check for success

	_determine_installation_state_

	if [[ $INST_STATE == 1 ]]; then
		echo "Success!"
		exit 0
	elif [[ $INST_STATE == 0 ]]; then
		echo "Hmm... that's odd!"
		echo "I wasn't able to install successfully :("
		exit 1
	fi

}

_purge_() {

	echo "Deleting packages from TDS..."
	rm -rf $INST_PATH
	if [[ -f $SCRIPT_LOCAL ]]; then
		echo "Uninstalling command line utility..."
		echo "Note: This requires root access."
		sudo rm $SCRIPT_LOCAL
	fi

}

_uninstall_() {

	_determine_installation_state_

	echo "Uninstalling uuclasses ..."
	if [[ $INST_STATE == 0 ]]; then
		echo "No installation of uuclasses found."
		exit 1
	elif [[ $INST_STATE == 1 ]]; then
		echo "Continuing will purge uuclases your system"
		while true; do
			read -p "Do you wish to continue? (Y/n)" yn
			case $yn in
			"" | [Yy]*)
				_determine_installation_path_
				_purge_
				break
				;;
			[Nn]*)
				echo "Ok! UUclasses will remain on your system."
				exit 0
				;;
			*)
				echo "Please answer Y/y or N/n."
				;;
			esac
		done
	fi

	_determine_installation_state_

	if [[ $INST_STATE == 0 ]]; then
		echo "Success!"
	elif [[ $INST_STATE == 1 ]]; then
		echo "Hmm... that's odd!"
		echo "The packages are still installed :("
		exit 1
	fi

}

_usage_() {

	cat <<EOF

Usage: uuclasses <command>

----------------------------------------------------------------------

There are 3 commands:

install: installs the packages by cloning them from GitHub into your
         TDS

uninstall: removes the packages from your computer

update: updates the packages by pulling from GitHub

EOF

}

_main_() {

	if ! [[ $COMMAND == "script" ]]; then
		_warning_
	fi

	echo "uuclasses - latex classes for the UU house style"
	echo "Written in 2023 by J. Korbmacher, j.korbmacher@uu.nl"

	if [[ $COMMAND == "install" ]] || [[ $COMMAND == "script" ]]; then
		_check_for_dependencies_
		_install_
	elif [[ $COMMAND == "update" ]]; then
		_check_for_dependencies_
		_update_
	elif [[ $COMMAND == "uninstall" ]]; then
		_uninstall_
	else
		_usage_
	fi

}

_main_
