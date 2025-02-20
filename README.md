# Real Weapons mod for Clear Sky

Main purposes of this mod: weapons and ammos has real power, calculated from real manufacturer data sheets (see [Edit .ltx files](https://github.com/stalker-tools/real_weapons_mod_clear_sky#create-real-weapons-mod) section) for _Ammo_ and _Armor_ parameters with manufacturer data sheets links.

Clear Sky version: **1.5.10**

[Run Clear Sky on Linux](https://github.com/stalker-tools/tools/blob/main/run_cs.md)

## Mod details

* The Actor and NPC are roughly equal at the Master game level. But If you have gameplay problems - set game level to _Novice_ and back to you favorite game level after.
* Weapons and ammos has real power, calculated from real manufacturer data sheets.

## Analysis

At first unpack original _gamedata_ folder:
* Unpack game files to gamedata folder. See [Unpack gamedata](https://github.com/stalker-tools/tools/blob/main/analysis_cs.md) page.
* Copy original gamedata to `gamedata_orig`, for example. It used later to create .patch file.

### Generate NPC and weapons analysis html file
Use [.ltx files analysis tools](https://github.com/stalker-tools/tools)
```sh
python graph_tool.py -f "$HOME/.wine/drive_c/Program Files (x86)/clear_sky/gamedata" --head "NPC and weapons" > NPC_and_weapons.htm
```
Result: NPC_and_weapons.htm multi-graph analysis file (for example see [Clear Sky + SGM 3.10 + Real Weapons.html](https://html-preview.github.io/?url=https://github.com/stalker-tools/real_weapons_mod_clear_sky/blob/main/media/Clear%20Sky%20%2B%20SGM%203.10%20%2B%20Real%20Weapons.html)).

### Ammo parameters graphs analysis

Look at graphs how unrealistic the ammo characteristics looks :astonished: ...
5.45x39 and 5.56x45 ammo power five times less than real !

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
* `fire_distance`, `silencer_fire_distance` - max fire distance
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
* `$spawn`, `$npc` - name and section for level designer; option for level designer
* `min_radius`, `max_radius` - AI: weapon NPC usage distance range
* `ef_main_weapon_type` - 0 pistol, 1 shotgun, 2 assault rifle, 3 rifle, 4 grenade launcher, 5 binocle
* `ef_weapon_type` - weapon subtype: 0 binocle, 1 knife/bolt/rat, zombie, 2 cat/dog/flesh/snork, 3 bloodsucker/chimera/giant/pseudodog,
  4 izlom, 5 pistol, 6 assault rifle, 7 rifle, 8 SVD/SVU/Gauss rifle/PKM machine gun, 9 grenade launcher, 10 grenade,
  11 controller, 12 burer/poltergeist, 13..19 anomaly, teleport
* `default_to_ruck` - false: weapon autoselect on free slot
* `sprint_allowed` - true: can run with weapon
* `control_inertion_factor` - weapon inertion
* `weapon_class` - assault_rifle, sniper_rifle, heavy_weapon (grenade launcher), shotgun
* `holder_range_modifier`, `holder_fov_modifier` - AI: inrease eye_range/eye_fov for NPC for weapon in hands
* `zoom_dof` - depth of field change on front sight aiming
* `reload_dof` - depth of field change on reloading

## Create Real Weapons mod

### Edit .ltx files

Use python tools from **tools** repo to analyze and edit .ltx files. Manufacturer site datasheet (see links) used or wiki. Calculate kinetic energy and set `k_hit` for ammo.

### **Ammo `k_hit` calculations with references:**
Wikipedia used if no datasheet link.

Abbreviations:

‣ APB - armor-piercing bullet

‣ FMJ - full metal jacket

‣ HPB - high penetration bullet

‣ JHP - jacketed hollow point

‣ SCB - steel core bullet


* #### 5.45x39

‣ [7N10](http://roe.ru/catalog/sukhoputnye-vosyka/strelkovoe-oruzhie/boepripasy-k-strelkovomu-oruzhiyu/7n10/) HPB
`880 m/s x 3.62 g = 1402 J = 4.67`

Bullet speed at range 25 m.
Dispersion radius at 200 m (R50): 6 cm.
Weight: 10.6 g.

‣ 7N22 APB
`890 m/s x 3.67 g = 1454 J = 4.85`

‣ _AKS74U_ riffle
`hit_power = 735 m/s x 3.62 g = 978 J / 1402 J = 0.7`

* #### 5.56x45

‣ [556B (civil)](https://magtechammunition.com/products/ammunition/5-56x45mm-62gr-fmj/) FMJ
`940 m/s x 4 g = 1767 J = 5.89`

| Range |  Speed  | Energy | Trajectory |
|-------|---------|--------|------------|
| 100 m | 846 m/s | 1431 J |     0 cm   |
| 200 m | 758 m/s | 1149 J | -13.8 cm   |
| 300 m | 676 m/s |  914 J | -44.7 cm   |

Test barrel lenght: 50.8 cm.

‣ [RS 101](http://roe.ru/catalog/sukhoputnye-vosyka/strelkovoe-oruzhie/boepripasy-k-strelkovomu-oruzhiyu/rs-101/) HPB
`920 m/s x 3.9 g = 1650 J = 5.5`

Bullet speed at range 25 m.
Dispersion radius at 200 m (R50): 6 cm.
Armor-piercing for St3 steel 16 mm at 100 m: 60 %.
Weight: 11.0 g.

* #### 7.62x25

‣ [57-N-134](https://www.kalashnikov.ru/medialibrary/6c0/24_30.pdf)
`440 m/s x 5.5 g = 532 J = 1.78`

Dispersion at 25 m (R50): 2.5 cm.
Weight: 10.6 g.
Barrel pressure: 2060 bar.

* #### 7.62x39

‣ 57-N-231
`720 m/s x 7.9 g = 2048 J = 6.83`

Weight: 16.5 g.

‣ 7N23 APB
`735 m/s x 7.9 g = 2134 J = 7.1`

Armor-piercing for 2P steel armor type 5 mm at 200 m: 100 %.
Weight: 16.3 g.

* #### 7.62x51

‣ [762A](https://magtechammunition.com/products/ammunition/7-62x51mm-ball-mil-std/)
`835 m/s x 9.52 g = 3319 J = 11.1`

| Range |  Speed  | Energy | Trajectory |
|-------|---------|--------|------------|
| 100 m | 760 m/s | 2749 J |   0 cm     |
| 200 m | 689 m/s | 2260 J | -17 cm     |
| 300 m | 622 m/s | 1842 J | -54.8 cm   |

Test barrel lenght: 56.2 cm.

‣ [.308 Win (civil)](https://tulammo.ru/production/vintovochnye-patrony/ceriya-okhota-308-win-7-62kh51-s-puley-fmj-bt-195-gr-12-6-g-s-latunnoy-obolochkoy-i-latunnoy-gilzoy/) FMJ BT
`750 m/s x 12.63 g = 3551 J = 11.84`

Speed at range 25 m: 735 m/s.
Dispersion at 100 m: 4.5 cm.
Weight: 28.04 g.
Barrel pressure: 4150 bar.

* #### 7.62x54

‣ [7N1](http://roe.ru/catalog/sukhoputnye-vosyka/strelkovoe-oruzhie/boepripasy-k-strelkovomu-oruzhiyu/7n1/)
`820 m/s x 9.9 g = 3352 J = 11.17`

Bullet speed at range 25 m.
Dispersion radius at 300 m (R100): 8 cm.
Weight: 23.2 g.
Barrel pressure: 2845 bar.

‣ [7N14](http://roe.ru/catalog/sukhoputnye-vosyka/strelkovoe-oruzhie/boepripasy-k-strelkovomu-oruzhiyu/7n14/) APB
`820 m/s x 9.9 g = 3352 J = 11.17`

Bullet speed at range 25 m.
Armor-piercing for 2P steel armor type 5 mm at 300 m: 80 %.
Weight: 23.2 g.
Barrel pressure: 3040 bar.

* #### 9x18

‣ [57-N-181](https://www.kalashnikov.ru/medialibrary/6c0/24_30.pdf)
`303 m/s x 6.1 g = 280 J = 0.93`

Dispersion radius at 25 m (R50): 3 cm.
Weight: 9.325 g.
Barrel pressure: 1177 bar.

‣ [7N25](http://roe.ru/catalog/sukhoputnye-vosyka/strelkovoe-oruzhie/boepripasy-k-strelkovomu-oruzhiyu/7n25/) APB
`480 m/s x 3.6 g = 415 J = 1.38`

Bullet speed at range 10 m.
Armor-piercing for St3 steel 5 mm at 10 m: 100 %.
Weight: 7.5 g.
Barrel pressure: 1422 bar.

‣ [7N21](http://roe.ru/catalog/sukhoputnye-vosyka/strelkovoe-oruzhie/boepripasy-k-strelkovomu-oruzhiyu/7n21/) SCB
`455 m/s x 5.4 g = 559 J = 1.86`

Bullet speed at range 10 m.
Dispersion radius at 25 m (R50): 3 cm.
Armor-piercing for St3 steel 4 mm at 55 m: 80 %.
Armor-piercing for St3 steel 5 mm at 35 m: 80 %.
Weight: 9.65 g.
Barrel pressure: 2746 bar.

‣ [9 mm Makarov (civil)](https://tulammo.ru/production/pistoletnye-patrony/9-mm-makarov-9kh18-s-puley-fmj-92-gr-5-92-g-s-bimetallicheskoy-obolochkoy-i-stalnoy-gilzoy/) FMJ
`315 m/s x 5.95 g = 295 J = 0.98`

Speed at 10 m: 303 m/s.
Dispersion at 25 m: 8.5 cm.
Weight: 9.665 g.
Barrel pressure: 1177 bar.

‣ _PB_ pistol
`hit_power = 290 m/s x 6.1 g = 257 J / 280 J = 0.92`

* #### 9x19

‣ [9A (civil)](https://magtechammunition.com/products/ammunition/9mm-luger-115gr-fmj-2/) FMJ
`346 m/s x 7.45 g = 446 J = 1.49`

| Range |  Speed  | Energy | Trajectory |
|-------|---------|--------|------------|
| 50 m  | 313 m/s | 365 J  | -5.7 cm    |
| 100 m | 290 m/s | 313 J  | -36.3 cm   |

Test barrel lenght: 10.2 cm.

‣ [7N31](http://roe.ru/catalog/spetsialnye-sredstva/pistolety-pulemety/7n31/?ysclid=lka3r1txjf753431711) APB
`575 m/s x 4.2 g = 694 J = 2.31`

Bullet speed at range 10 m.
Dispersion radius at 25 m (R50): 3 cm.
Armor-piercing for St3 steel 8 mm at 10 m: 100 %.
Weight: 8.2 g.
Barrel pressure: 2746 bar.

‣ [9 mm Luger (civil)](https://tulammo.ru/production/pistoletnye-patrony/9-mm-luger-9x19-s-puley-fmj-145-gr-9-3-g-s-bimetallicheskoy-obolochkoy-i-stalnoy-gilzoy/) FMJ
`320 m/s x 9.33 g = 478 J = 1.59`

Speed at range 10 m: 310 m/s.
Dispersion at 25 m: 5 cm.
Weight: 13.185 g.
Barrel pressure: 2350 bar.

‣ [9 mm Luger (civil)](https://tulammo.ru/production/pistoletnye-patrony/patron-9x19-9-mm-luger-fmj-7-5-g-115-gr-bimetallicheskaya-obolochka-stalnaya-gilza/) FMJ
`385 m/s x 7.46 g = 553 J = 1.84`

Speed at range 10 m: 370 m/s.
Dispersion at 25 m: 5 cm.
Weight: 11.33 g.
Barrel pressure: 2350 bar.

‣ _MP5SD_ (with silencer)
`silencer_hit_power = 285 m/s x 7.5 g = 305 J / 500 J = 0.61`

* #### 9x39

‣ [SP-5](http://roe.ru/catalog/spetsialnye-sredstva/avtomaty2/as/) SCB
`295 m/s x 16 g = 696 J = 2.32`

‣ PAB-9 APB
`310 m/s x 17 g = 817 J = 2.72`

‣ [9х39 (civil)](https://tulammo.ru/production/vintovochnye-patrony/9x39/) FMJ
`320 m/s x 16 g = 819 J = 2.73`

Speed at 10 m: 310 m/s.
Dispersion at 100 m: 7.5 cm.
Weight: 23.325 g.
Barrel pressure: 2600 bar.

Surprize ! 9x39 is almost half power of 5.45x39. But it still better in buildings - no ricochets.

* #### 11.43x23 / .45 ACP

‣ [45A (civil)](https://magtechammunition.com/products/ammunition/45-auto-230gr-fmj-2/) FMJ
`255 m/s x 14.9 g = 485 J = 1.62`

| Range |  Speed  | Energy | Trajectory |
|-------|---------|--------|------------|
| 50 m  | 245 m/s | 448 J  |  -9.4 cm   |
| 100 m | 236 m/s | 415 J  | -59.5 cm   |

Test barrel lenght: 12.7 cm.

‣ [GG45B (civil)](https://magtechammunition.com/products/ammunition/45-autop-230gr-jhp-guardian-gold/) JHP
`350 m/s x 14.91 g = 913 J = 3.0`

| Range |  Speed  | Energy | Trajectory |
|-------|---------|--------|------------|
| 50 m  | 316 m/s | 744 J  |  -5.4 cm   |
| 100 m | 293 m/s | 640 J  | -35.1 cm   |

Test barrel lenght: 12.7 cm.

Note, `11.43x23 hydro` is not real.

* #### 12x70

‣ [Express Kupra buckshot 6.5 мм 34 g (civil)](https://techcrim.ru/?page_id=16396) Copper-plated shot

`430 m/s x 1.26 g = 117 J = 0.39`
`buck_shot = 34 g / 1.26 g = 27`
Barrel pressure: 740 bar.

‣ [Express Kupra buckshot 8.0 мм 33 g (civil)](https://techcrim.ru/?page_id=16396) Copper-plated shot

`430 m/s x 3.2 g = 296 J = 0.99`
`buck_shot = 33 g / 3.2 g = 10`
Barrel pressure: 740 bar.

‣ [UNO 40 bullet (civil)](https://techcrim.ru/?page_id=16396) lead

`390 m/s x 40 g = 3042 J = 10.14`

Test barrel lenght: 70 cm.
Dispersion at 50 m: 6.0 cm.

‣ [L-2 Leningradka sub-caliber bullet (civil)](https://techcrim.ru/?page_id=16396) steel

`465 m/s x 26 g = 2811 J = 9.37`

| Range |  Speed  | Energy | Trajectory |
|-------|---------|--------|------------|
|  50 m | 365 m/s | 1732 J |  -8.0 cm   |
| 100 m | 281 m/s | 1027 J | -32.0 cm   |

Test barrel lenght: 70 cm.
Dispersion at 50 m: 4.5 cm.
Barrel pressure: 1320 bar.

‣ _rifles_ fire_distance: 35 m (buckshot) `k_dist = 0.7`, 50 m (bullet) `k_dist = 1`.

### Armor parameters

Bullet (knife) proof classification according GOST 34286-2017:

| Class | Bullet power, kJ | Bullet core |
|-------|-----------|-------------|
| S     |0.05 (kick)| (Knife)     |
| Br 1  | 0.33      | Steel       |
| Br 2  | 0.6       | Lead        |
| Br 3  | 0.59      | Steel heat-strengthened |
| Br 4  | 1.4..2.0  | ↑ |
| Br 5  | 3.2..3.4  | ↑ |
| Br 6  | 16.5      | ↑ |

* #### Body armor

| Model     | Class | Weight steel | Weight ceramic | Price | Notes |
|-----------|-------|--------------|----------------|-------|-------|
| Fagor-1   | Br1   | 4.2 | 2.2 | 12 | |
| Fagor-2   | Br2   | 4.3 | -   | 13 | |
| Fagor-3   | Br3   | 6   | -   | 20 | |
| Fagor-4   | Br4   | 12  | 10  | 95 | Assault |
| Fagor-5   | Br5   | -   | 12  |118 | Assault |
| Plitnik-4 | Br4   | 9   | 7.5 | 80 | Lightweight: chest and back |
| Plitnik-5 | Br5   | -   | 8   | 95 | Lightweight: chest and back |

* #### Head armor

| Model     | Class | Weight | Price | Notes |
|-----------|-------|--------|-------|-------|
| ShPU-OS   | S     | 1.2 | 31 | "Ops-Core" Carbon |
| Beret     | Br1   | 1.9 | 33 | Kevlar |
| ShBM2-M   | Br2   | 1.9 | 70 | Kevlar |
| Tor-2     | Br2   | 2.5 |127 | Assault, Kevlar |

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
