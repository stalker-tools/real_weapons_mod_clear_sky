# Real Weapons mod for Clear Sky

Main purposes of this mod: weapons and ammos has real power, calculated from real manufacturer data sheets.

Clear Sky version: **1.5.10**

## Mod details

* The Actor and NPC are roughly equal at the Master game level. But If you have gameplay problems - set game level to _Novice_ and back to you favorite game level after.
* Weapons and ammos has real power, calculated from real manufacturer data sheets.

## Analysis

At first unpack origional _gamedata_ folder:
* Unpack game files to gamedata folder. See [Unpack gamedata](https://github.com/stalker-tools/tools/blob/main/analysis_cs.md) page.
* Copy original gamedata to `gamedata_orig`, for example. It used later to create .patch file.

### Generate NPC and weapons analysis html file
Use .ltx files analysis tools.
```sh
python graph_tool.py -f "$HOME/.wine/drive_c/Program Files (x86)/clear_sky/gamedata" --head "NPC and weapons" > NPC_and_weapons.htm
```
Result: file NPC_and_weapons.htm (for example see _media/NPC_and_weapons.htm_ file).

Look at graphs how unrealistic the ammo characteristics looks. Main ammo parameter is power impulse: `k_hit` coefficient it expressed as `1 = 300 Joules`. `1 Joule = (m * v^2) / 2` SI unit of kinetic energy. So to get bullet kinetic energy we need know bullet speed and bullet mass. To get this manufacturer data sheet files or wiki used.

## Create Real Weapons mod

### Edit .ltx files

Use python tools from **tools** repo.

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
