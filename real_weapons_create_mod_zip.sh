#!/usr/bin/env bash

PATCH_FILE_PATH="real_weapons.patch"
SOURCE_GAMEDATA_PATH="$HOME/.wine/drive_c/Program Files (x86)/clear_sky/gamedata/"
MOD_PATH="gamedata/"
MOD_ZIP_FILE_NAME="${PATCH_FILE_PATH%.*}".zip

REAL_MOD_PATH=$(realpath "$MOD_PATH")
REAL_PATCH_FILE_PATH=$(realpath "$PATCH_FILE_PATH")

# check old mod path
if [ -d "$REAL_MOD_PATH" ]; then
	echo "Mod path exist: $REAL_MOD_PATH"
	read -r -p "Remove this mod ? ('y' - yes, else - no): " answer
	case $answer in
		[Yy]* ) echo ""; echo "Remove old path $REAL_MOD_PATH"; rm -rfv "$REAL_MOD_PATH"; break;;
		* ) echo "Abort."; exit;;
	esac
fi

mkdir -v $MOD_PATH

# copy files to mod path
SAVED_PWD=$(pwd)
cd "$SOURCE_GAMEDATA_PATH"
echo ""; echo "Copy $SOURCE_GAMEDATA_PATH -> $REAL_MOD_PATH"
for i in $(lsdiff $REAL_PATCH_FILE_PATH ); do
	cp -v --parents "$i" "$REAL_MOD_PATH" ;
done;
cd "$SAVED_PWD"

# zip mod path
echo ""
echo "Zip mod files to $MOD_ZIP_FILE_NAME"
rm "$MOD_ZIP_FILE_NAME"
zip -r "$MOD_ZIP_FILE_NAME" "$MOD_PATH"
