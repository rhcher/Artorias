#!/usr/bin/env bash

CONFIG=$HOME/.config/nvim
rm -rf $CONFIG/lua
nvim +"au User PackerComplete qa" +PackerSync # +"silent TSUpdateSync"
