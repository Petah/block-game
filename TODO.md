# TODO - Block Game

## Gameplay Features

- [x] Power-ups that fall from destroyed blocks
  - [x] Extra balls (+1)
  - [ ] Extra balls (+3, +5)
  - [x] Larger ball (bigger collision radius)
  - [x] Fireball (passes through blocks without bouncing)
  - [x] Split ball (ball splits into 2 on first bounce)
- [ ] Special block types
  - [ ] Explosive blocks (destroy adjacent blocks)
  - [ ] Steel blocks (indestructible, must clear around them)
  - [ ] Rainbow blocks (change color/health each turn)
- [x] Ball collection point moves to where first ball lands
- [ ] Combo system for hitting multiple blocks with one ball
- [x] Ball auto-death timer (8 seconds without hitting blocks)

## Visual Polish

- [ ] Block color based on health (green -> yellow -> orange -> red)
- [ ] Block damage/crack sprites as health decreases
- [x] Particle effects on block destruction
- [ ] Screen shake on big combos
- [x] Ball trail effect
- [ ] Smooth block movement (animate down instead of snap)
- [ ] Background gradient or pattern

## Audio

- [ ] Ball bounce sound
- [ ] Block hit sound
- [ ] Block destroy sound
- [ ] Power-up collect sound
- [ ] Game over jingle
- [ ] Background music

## UI/UX

- [ ] Main menu screen
- [ ] Pause menu
- [ ] High score system with local save
- [ ] Tutorial/first-time player hints
- [ ] Settings menu (sound volume, etc.)
- [ ] Touch controls for mobile (drag to aim)
- [x] Styled header bar with score/level/ball count
- [x] Level badge display
- [x] Danger zone indicator
- [x] Game over/win overlay panels
- [x] Debug UI toggle (press D)

## Technical

- [x] Remove unused obj_paddle
- [ ] Object pooling for balls (performance)
- [ ] Save/load game state
- [ ] Analytics tracking (levels reached, etc.)
- [x] Shooter sprite that rotates with aim
- [x] Realistic ball-block collision (surface normal reflection)
- [x] Test room with debug controls (T to switch, R to restart)

## Balance

- [ ] Tune block spawn chance curve
- [ ] Tune health scaling per level
- [ ] Adjust ball speed for feel
- [ ] Cap maximum ball count or add cooldown
- [x] Speed multiplier debug control (press F)

## Stretch Goals

- [ ] Daily challenge mode with seeded randomness
- [ ] Endless mode vs level-based campaign
- [ ] Boss blocks (large multi-cell blocks)
- [ ] Achievements system
- [ ] Leaderboards
