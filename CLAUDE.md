# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a GameMaker Studio 2 project implementing a ball-shooting block game (similar to "Ballz"). The player aims and fires multiple balls that bounce around and damage blocks. The project uses GameMaker Studio 2024.14.2.212 and follows standard GameMaker project structure with GML (GameMaker Language) scripts.

## Game Architecture

### Core Objects
- **obj_game** - Game controller managing score, aiming, ball firing, game state, particles, lives, and UI rendering
- **obj_ball** - Physics-based projectile that bounces off walls and damages blocks on contact
- **obj_block** - Blocks with health that display their HP and get destroyed when health reaches 0
- **obj_wall** - Physics wall objects for boundaries (left, right, top)
- **obj_danger_zone** - Visual indicator for the danger zone where blocks cost lives
- **obj_power_up** - Collectible power-ups (extra ball, fireball, split, big ball)
- **obj_shooter** - Visual indicator showing launch point and aim direction
- **obj_main_menu** - Scrollable level select with 109 levels
- **obj_button** - Reusable UI button with 9-slice support
- **obj_level_complete** - Overlay shown when level is completed
- **obj_game_over** - Overlay shown when player loses all lives
- **obj_debug** - Debug overlay with grid, aim preview, and controls (hidden by default, press D)

### Game Flow
1. **obj_main_menu** displays scrollable level select grid (109 levels)
2. Player selects a level, **obj_game** initializes the scene with level layout from **scr_levels**
3. Player drags back to aim (slingshot style), release fires all available balls in burst
4. Balls bounce off physics walls and damage blocks (reducing health by 1 per hit)
5. Balls return to available pool when they fall off bottom
6. Player can fire again while balls are still in play
7. Level complete when all non-steel blocks destroyed (fireworks celebration)
8. Blocks reaching danger zone cost 1 life; game over at 0 lives

### Event Structure
Objects use standard GameMaker events:
- **Create_0.gml** - Initialization and variable setup
- **Step_0.gml** - Per-frame logic (movement, collision, input)
- **Draw_0.gml** - World-space rendering
- **Draw_64.gml** - GUI rendering (obj_game, obj_main_menu)

### Key Game Variables
- Ball count: Defined per level in scr_levels
- Lives: 3 lives, lose 1 when block reaches danger zone
- Scoring: 10 points per block hit, combo multipliers
- Block health: Defined in level layouts (1-8+)
- Game states: "playing", "firing", "waiting"
- Ball physics: Box2D physics with impulse-based movement

## Development Commands

GameMaker Studio projects are typically built and run through the GameMaker IDE. There are no standard command-line build tools for this project structure.

### SVG Asset Creation

Sprite assets are created as SVGs in the `svg/` folder and rendered to PNG using resvg:

```bash
/c/work/commands/resvg.exe "/c/Users/petah/GameMakerProjects/Block Game/svg/example.svg" "/c/Users/petah/GameMakerProjects/Block Game/svg/rendered/example.png"
```

SVG files use gradients and highlights for a polished look. See `svg/ball.svg` and `svg/block.svg` for examples.

## File Structure

- `Block Game.yyp` - Main project file (JSON format)
- `objects/` - Game object definitions and GML scripts
  - `obj_*/Create_0.gml` - Object initialization
  - `obj_*/Step_0.gml` - Per-frame update logic
  - `obj_*/Draw_0.gml` - World-space drawing
  - `obj_*/Draw_64.gml` - GUI drawing
- `scripts/` - Reusable functions
  - `scr_levels/` - Level definitions (109 levels with layouts)
  - `scr_progress/` - Save/load progress and star ratings
  - `scr_spawn_block/` - Block creation helper
  - `scr_draw_text/` - Styled text rendering helper
- `sprites/` - Sprite assets (spr_ball, spr_block, spr_heart, spr_button, etc.)
- `svg/` - Source SVG files for sprites (rendered to PNG with resvg)
  - `svg/rendered/` - Rendered PNG outputs
  - `splash.svg` - Splash screen with full logo
  - `menu_bg.svg` - Menu background with header/footer (transparent center)
- `rooms/`
  - `rm_main_menu/` - Level select screen
  - `rm_game/` - Main gameplay room
- Room size: 720x1280 pixels (9:16 portrait aspect ratio for mobile)

## Code Patterns

- **One function per script file** - Each script in `scripts/` should contain a single function matching the script name
- Objects use `self.variable` for instance variables
- Collision detection uses `place_meeting()` and `instance_place()`
- Ball physics implemented with `hspeed`/`vspeed` built-in variables
- UI rendering uses `draw_text()` with alignment and color settings
- Input handling via `keyboard_check()` and `keyboard_check_pressed()`
- Object creation via `instance_create_layer()` targeting "Instances" layer
- **Do not use `instance_exists(obj_game)`** - obj_game is always present in the room and can be accessed directly

## Key Gameplay Mechanics

- **Slingshot Aiming**: Drag back to aim (like Angry Birds), angle clamped to 20-160 degrees
- **Burst Firing**: All available balls fire in rapid succession on release
- **Continuous Play**: Can fire again before all balls return
- **Physics Collision**: Box2D physics handles ball-wall and ball-block collisions
- **Block Types**: Normal, explosive (chain reaction), steel (indestructible), rainbow (regenerates health)
- **Lives System**: 3 lives, blocks passing danger zone cost 1 life
- **Level Progression**: 109 hand-crafted levels with increasing difficulty
- **Turn Counting**: Used for star rating on level complete