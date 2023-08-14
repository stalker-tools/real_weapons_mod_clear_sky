# Real Weapons mod for Clear Sky

Main purposes of this mod: weapons and ammos has real power, calculated from real manufacturer data sheets.

## Analysis

Unpack game files to gamedata folder. See tools repo.
Copy original gamedata to `gamedata_orig`, for example. It used later to create .patch file.

### Generate NPC and weapons analysis html file
Use .ltx files analysis tools.
```sh
python graph_tool.py -f "$HOME/.wine/drive_c/Program Files (x86)/clear_sky/gamedata" --head "NPC and weapons" > NPC_and_weapons.htm
```
Result: see media/NPC_and_weapons.htm

## Create Real Weapons mod

### Create patch file `real_weapons.patch`:
```sh
diff -bur "$HOME/.wine/drive_c/Program Files (x86)/clear_sky/gamedata_orig" "$HOME/.wine/drive_c/Program Files (x86)/clear_sky/gamedata" > real_weapons.patch
```

To apply patch file `real_weapons.patch` to gamedata folder:
```sh
patch --verbose --directory=./gamedata/ --strip=1 < real_weapons.patch
```

### Create mod zip file
```sh
real_weapons_create_mod_zip.sh
```
