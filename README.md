---
section: 32
x-masysma-name: vifm-ext
title:  MDVL VIFM Extension Scripts
date: 2020/09/02 02:33:48
lang: en-US
author: ["Linux-Fan, Ma_Sys.ma (Ma_Sys.ma@web.de)"]
keywords: ["package", "mdvl", "vifm", "script", "shell"]
x-masysma-version: 1.0.0
x-masysma-repository: https://www.github.com/m7a/lp-vifm-ext
x-masysma-website: https://masysma.lima-city.de/32/vifm-ext.xhtml
x-masysma-owned: 1
x-masysma-copyright: |
  Copyright (c) 2020 Ma_Sys.ma.
  For further info send an e-mail to Ma_Sys.ma@web.de.
---
Description
===========

This package provides scripts to extend the capabilities of the VIFM file
manager (or any configurable console-based file manager) by a mounting faciltiy.
It is intended to be used togehter with the configuration provided in package
`mdvl-conf-cli`.

WARNING: Sudo Configuration Included
====================================

This package includes a sudoers configuration allowing user `linux-fan` to
run the `ma_mount` command which makes the `mount` command available to a
user with restricted permissions.

Script `mavifmext_reduced.sh`
=============================

This script creates a dialog-based selection menu of devices available for
mounting. It filters out any device that is either in `/proc/mdstat` or already
mounted as a safety measure against accidentally mounting a system volume.

_TODO SCREENSHOT_

After obtaining the device selection from the user, the script invokes
`ma_mount` for the actual mount process.

Script `ma_mount`
=================

Most Desktop Environments provide convenient means to mount any device.
Unfortunately, when using a window manager only, this feature is sometimes
unreliable due to missing session or background daemons. In the past, release
updates repreatedly “destroyed” what was before a working `mount` command to be
used by regular users.

Due to that situation, script `ma_mount` was created to solve the issue by the
“sledgehammer approach” of allowing users to mount devices with `sudo`.

Instead of giving users access to `mount` via sudo directly, the script has some
additional sanity checks to avoid malicious bind mounts that could effectively
give users root access. Note that these measures are most likely insufficient
against a sophisticated adversary who analzes the script.

Note: The documentation here is incomplete on purpose. Users are highly
encouraged to find an alternative solution for their needs.
