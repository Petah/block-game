# TODO - Block Game

## Gameplay Features

- [ ] Power-ups that fall from destroyed blocks
  - [ ] Extra balls (+1, +3, +5)
  - [ ] Larger ball (bigger collision radius)
  - [ ] Fireball (passes through blocks without bouncing)
  - [ ] Split ball (ball splits into 2 on first bounce)
- [ ] Special block types
  - [ ] Explosive blocks (destroy adjacent blocks)
  - [ ] Steel blocks (indestructible, must clear around them)
  - [ ] Rainbow blocks (change color/health each turn)
- [ ] Ball collection point moves to where first ball lands
- [ ] Combo system for hitting multiple blocks with one ball

## Visual Polish

- [ ] Block color based on health (green -> yellow -> orange -> red)
- [ ] Block damage/crack sprites as health decreases
- [ ] Particle effects on block destruction
- [ ] Screen shake on big combos
- [ ] Ball trail effect
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

## Technical

- [ ] Remove unused obj_paddle
- [ ] Object pooling for balls (performance)
- [ ] Save/load game state
- [ ] Analytics tracking (levels reached, etc.)

## Balance

- [ ] Tune block spawn chance curve
- [ ] Tune health scaling per level
- [ ] Adjust ball speed for feel
- [ ] Cap maximum ball count or add cooldown

## Stretch Goals

- [ ] Daily challenge mode with seeded randomness
- [ ] Endless mode vs level-based campaign
- [ ] Boss blocks (large multi-cell blocks)
- [ ] Achievements system
- [ ] Leaderboards
