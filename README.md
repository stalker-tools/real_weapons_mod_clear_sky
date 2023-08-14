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

### Ammo parameters graphs analysis

Look at graphs how unrealistic the ammo characteristics looks :astonished: ...

Main ammo parameter is power impulse: `k_hit` coefficient, it expressed as `1 = 300 Joules`. `1 Joule = (m * v^2) / 2` SI unit of kinetic energy. So to get bullet kinetic energy we need know bullet speed and bullet mass. To get this manufacturer data sheet files or wiki used.

`Damage = hit_power * k_hit`, see below tactical parameters.

Ammo tactical parameters:
* `k_hit` - bullet power coef
* `k_ap` - bullet ability to break through armor
* `k_dist` - distance coef
* `k_disp` - dispersion coef
* `k_pierce` - armor decrease coef
* `impair` - weapon barrel wear for one shoot
* `buck_shot` - count of bullet parts (buckshot shots)
* `wm_size` - visual size of the bullet hole on the surface
* `k_air_resistance` - air resistance of bullet coef

Weapon tactical parameters:
* `hit_power` - weapon power coef: Novice, Stalker, Veteran, Master
* `hit_impulse` - bullet to aim impulse
* `hit_type` - damage type: fire_wound, explosion
* `ammo_class` - ammo type list
* `fire_dispersion_base` - base angle of dispersion, degrees
* `cam_relax_speed`, `cam_relax_speed_ai` - return speed for player and AI
* `cam_dispersion`, `cam_dispersion_inc` - each shoot dispersion increase, degree; `cam_dispersion` each shot increase
* `cam_dispersion_frac` - barrel up for: `cam_dispersion * cam_dispersion_frac ± cam_dispersion * (1 - cam_dispersion_frac)`
* `cam_max_angle` - max barrel vertical-up angle for shooting recoil
* `cam_max_angle_horz`, `cam_step_angle_horz` - max barrel horizontal angle; `cam_max_angle_horz` each shot increase
* `zoom_cam*` - like `cam_*` but for optical aiming and front sight
* `fire_dispersion_condition_factor` - dispersion increase on max wear, percent
* `misfire_probability` - probability of a misfire on max wear
* `misfire_condition_k` - misfire condition threshold
* `condition_shot_dec` - wear increase for each shot

Common xray game engine parameters:
* `class` - C++ class
* `$prefetch` - preloading queue
* `$spawn`, `$npc` - name and section for level disigner; option for level disigner
* `min_radius`, `max_radius` - AI: weapon NPC usage distance range
* `ef_main_weapon_type` - weapon main type: 0 pistol, 1 shotgun, 2 assault rifle, 3 rifle, 4 grenade launcher, 5 binocle
* `ef_weapon_type` - weapon subtype: 0 binocle, 1 knife/bolt/rat, zombie, 2 cat/dog/flesh/snork, 3 bloodsucker/chimera/giant/pseudodog,
  4 izlom, 5 pistol, 6 assault rifle, 7 rifle, 8 SVD/SVU/Gauss rifle/PKM machine gun, 9 grenade launcher, 10 grenade,
  11 controller, 12 burer/poltergeist, 13..19 anomaly, teleport
* `default_to_ruck` - false: weapon autoselect on free slot
* `sprint_allowed` - true: can run with weapon
* `control_inertion_factor` - weapon inertion
* `weapon_class` - weapon class: assault_rifle, sniper_rifle, heavy_weapon (grenade launcher), shotgun
* `holder_range_modifier`, `holder_fov_modifier` - AI: inrease eye_range/eye_fov for NPC for weapon in hands
* `zoom_dof` - depth of field change on front sight aiming
* `reload_dof` - depth of field change on reloading

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
