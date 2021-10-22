#!/bin/sh -e
# Ma_Sys.ma VIFM Extensions (Reduced) 1.0.1, Copyright (c) 2017, 2018, 2020 Ma_Sys.ma.
# For further info send an e-mail to Ma_Sys.ma@web.de.

mav_main() {
	opt="$1"
	shift
	case "$opt" in
	(new)    exec /usr/bin/ma_new_file;;
	(mount)  mav_mount;;
	(umount) exec /usr/bin/ma_mount dev -u "$(basename "$1")";;
	esac
}

mav_mount() {
	s0="$0"
	cprght="$(head -n 2 "$s0" | tail -n 1 | cut -c 3- | \
							sed 's/, Copyright//g')"
	# Deliberatly not do unique patterns because it is unnecessarily hard
	# to implement. WARNING: grep -o is not portable.
	pattern_files="$(grep -hoE 'sd[a-z]' /proc/mdstat /proc/self/mounts | \
						tr '\n' '|')"
	pattern_zfs="$(zpool status -LP | grep -oE 'sd[a-z]' | \
						tr '\n' '|' | head -c -1)"
	dialog_opt="$(find /dev -maxdepth 1 -name 'sd[a-z][0-9]' | sort | \
			grep -vE "$pattern_files$pattern_zfs" | \
			while read -r line; do \
				printf '"%s" "%s" ' \
					"$(printf "$line" | cut -d / -f 3)" \
					"$line"; \
			done)"

	dialog_conf="--backtitle \"$cprght\" --title Mount"
	dialog_conf="$dialog_conf --menu \"Select device to mount.\""
	dialog_conf="$dialog_conf 12 40 5"
	# http://linuxcommand.org/lc3_adv_dialog.php
	exec 3>&1
	eval "selection=\$(dialog $dialog_conf $dialog_opt \
				rel \"Refresh device list\" 2>&1 1>&3)"
	exec 3>&-
	if [ -n "$selection" ]; then
		if [ "$selection" = rel ]; then
			exec "$0" mount
		else
			exec ma_mount dev "$selection"
		fi
	fi
}

mav_main "$@" || exit "$?"
