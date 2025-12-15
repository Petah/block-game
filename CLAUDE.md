# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a GameMaker Studio 2 project implementing a ball-shooting block game (similar to "Ballz"). The player aims and fires multiple balls that bounce around and damage blocks. The project uses GameMaker Studio 2024.14.2.212 and follows standard GameMaker project structure with GML (GameMaker Language) scripts.

## Game Architecture

### Core Objects
- **obj_game** - Game controller managing score, aiming, ball firing, game state, and UI rendering
- **obj_ball** - Projectile that bounces off walls and damages blocks on contact
- **obj_paddle** - (Unused) Legacy paddle object
- **obj_block** - Blocks with health that display their HP and get destroyed when health reaches 0

### Game Flow
1. **obj_game** initializes the scene in Create_0.gml by spawning a grid of blocks with varying health
2. Player aims by moving the mouse; a dotted line shows the trajectory
3. Player clicks to fire multiple balls in rapid succession
4. Balls bounce off walls/top and damage blocks (reducing health by 1 per hit)
5. Balls are destroyed when they fall off the bottom of the screen
6. Once all balls return, the player can aim again (ball count increases by 1 each turn)
7. Game ends when all blocks destroyed (win)

### Event Structure
Objects use standard GameMaker events:
- **Create_0.gml** - Initialization and variable setup
- **Step_0.gml** - Per-frame logic (movement, collision, input)
- **Draw_64.gml** - GUI rendering (obj_game only)

### Key Game Variables
- Ball count: Starts at 10, increases by 1 each turn
- Scoring: 10 points per block hit
- Block health: Varies by row (harder blocks at top)
- Game states: "aiming", "firing", "waiting"
- Ball physics: Speed-based movement with wall/block collision response

## Development Commands

GameMaker Studio projects are typically built and run through the GameMaker IDE. There are no standard command-line build tools for this project structure.

### SVG Asset Creation

Sprite assets are created as SVGs in the `svg/` folder and rendered to PNG using resvg:

```bash
/c/work/commands/resvg.exe "/c/Users/petah/GameMakerProjects/Block Game/svg/example.svg" "/c/Users/petah/GameMakerProjects/Block Game/svg/example.png"
```

SVG files use gradients and highlights for a polished look. See `svg/ball.svg` and `svg/block.svg` for examples.

## File Structure

- `Block Game.yyp` - Main project file (JSON format)
- `objects/` - Game object definitions and GML scripts
  - `obj_*/Create_0.gml` - Object initialization
  - `obj_*/Step_0.gml` - Per-frame update logic
  - `obj_*/Draw_64.gml` - GUI drawing (obj_game only)
- `sprites/` - Sprite assets (spr_ball, spr_paddle, spr_block)
- `svg/` - Source SVG files for sprites (rendered to PNG with resvg)
- `rooms/rm_game/` - Game room layout and settings
- Room size: 720x1280 pixels (9:16 portrait aspect ratio for mobile)

## Code Patterns

- Objects use `self.variable` for instance variables
- Collision detection uses `place_meeting()` and `instance_place()`
- Ball physics implemented with `hspeed`/`vspeed` built-in variables
- UI rendering uses `draw_text()` with alignment and color settings
- Input handling via `keyboard_check()` and `keyboard_check_pressed()`
- Object creation via `instance_create_layer()` targeting "Instances" layer

## Key Gameplay Mechanics

- Aiming: Mouse position determines launch angle (clamped to 20-160 degrees)
- Ball firing: Balls launch with delay between each (fire_interval frames)
- Block collision uses previous position checking to determine bounce direction
- Blocks display health number and are destroyed when health reaches 0
- Turn system: All balls must return before next turn begins