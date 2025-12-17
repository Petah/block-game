# TODO - Block Game

## Gameplay Features

- [x] Power-ups that fall from destroyed blocks
  - [x] Extra balls (+1)
  - [ ] Extra balls (+3, +5)
  - [x] Larger ball (bigger collision radius)
  - [x] Fireball (passes through blocks without bouncing)
  - [x] Split ball (ball splits into 2 on first bounce)
    - [x] Prevent chain splitting (bonus balls can't split)
- [x] Special block types
  - [x] Explosive blocks (destroy adjacent blocks)
  - [x] Steel blocks (indestructible, must clear around them)
  - [x] Rainbow blocks (regenerate health over time)
- [x] Ball collection point moves to where first ball lands
- [ ] Combo system for hitting multiple blocks with one ball
- [x] Ball auto-death timer (12 seconds without hitting blocks)
- [x] Lives system (3 lives, lose life when blocks reach danger zone)
- [x] Slingshot aiming (drag back to aim, release to fire)
- [x] Burst firing (all balls fire on release)
- [x] Continuous play (can fire before all balls return)
- [x] 109 hand-crafted levels with varied patterns

## Visual Polish

- [x] Block color based on health (blue -> green -> yellow -> orange -> red -> purple -> pink)
- [ ] Block damage/crack sprites as health decreases
- [x] Particle effects on block destruction
- [x] Screen shake on big combos
- [x] Ball trail effect
- [ ] Smooth block movement (animate down instead of snap)
- [x] Background gradient or pattern
- [x] Multiple shooter sprite styles (cannon, spring, slingshot)

## Audio

- [ ] Ball bounce sound
- [ ] Block hit sound
- [ ] Block destroy sound
- [ ] Power-up collect sound
- [ ] Level complete jingle
- [ ] Game over jingle
- [ ] Background music
- [ ] Sound effects volume control

## UI/UX

- [x] Main menu screen
- [x] Scrollable level select (109 levels, 5 columns)
- [x] Splash screen SVG with logo
- [x] Menu background SVG with transparent button area
- [ ] Pause menu
- [x] High score system with local save
- [ ] Tutorial/first-time player hints
- [ ] Settings menu (sound volume, shooter style, etc.)
- [x] Touch controls for mobile (drag to aim - slingshot style)
- [x] Styled header bar with score/level/ball count
- [x] Lives display with heart icons
- [x] Level badge display
- [x] Danger zone indicator
- [x] Game over overlay (separate object)
- [x] Level complete overlay (separate object) with fireworks
- [x] Back button to return to main menu
- [x] Debug UI toggle (press D)
- [x] 9-slice pill UI component

## Technical

- [x] Remove unused obj_paddle
- [x] Physics-based walls (obj_wall with Box2D fixtures)
- [x] Physics-based ball movement (impulse-based)
- [ ] Object pooling for balls (performance)
- [x] Save/load game state (INI file persistence)
- [ ] Analytics tracking (levels reached, etc.)
- [x] Shooter sprite that rotates with aim
- [x] Realistic ball-block collision (surface normal reflection)
- [x] Test level with debug controls (T to toggle, R to restart)
- [x] One function per script file convention
- [x] Level data system (scr_levels with 109 layouts)

## Balance

- [ ] Tune block spawn chance curve
- [ ] Tune health scaling per level
- [ ] Adjust ball speed for feel
- [ ] Cap maximum ball count or add cooldown
- [x] Speed multiplier debug control (press F)

---

## Android Release Requirements

### Touch Controls
- [x] Drag anywhere to aim (slingshot style in danger zone)
- [x] Visual aim indicator (dotted line trajectory)
- [x] Release to fire (burst fires all balls)
- [ ] Tap to speed up balls (2x speed while held)
- [x] Prevent accidental fires (minimum drag distance threshold)

### Screen & Display
- [ ] Lock to portrait orientation
- [ ] Support multiple aspect ratios (16:9, 18:9, 19.5:9, 20:9)
- [ ] Safe area handling for notches/cutouts
- [ ] Consistent UI scaling across screen sizes
- [ ] 60 FPS target with frame rate cap

### Android Integration
- [ ] Back button handling (pause menu / confirm exit)
- [ ] App lifecycle handling (pause on minimize)
- [ ] Proper app icon (multiple resolutions)
- [ ] Splash screen / loading screen
- [ ] Handle orientation changes gracefully

### Performance & Battery
- [ ] Object pooling for balls and particles
- [ ] Texture atlas optimization
- [ ] Limit particle counts on lower-end devices
- [ ] Battery-efficient idle state
- [ ] Memory usage optimization

### Monetization (Optional)
- [ ] Rewarded ads (continue after game over, bonus balls)
- [ ] Interstitial ads (between levels, limited frequency)
- [ ] Remove ads IAP
- [ ] Cosmetic IAPs (shooter skins, ball skins, themes)

### Store Requirements
- [ ] Privacy policy URL
- [ ] App store description
- [ ] Feature graphic (1024x500)
- [ ] Screenshots (phone and tablet)
- [ ] App icon (512x512)
- [ ] Content rating questionnaire
- [ ] Target API level compliance (API 33+)

### Quality & Testing
- [ ] Crash reporting integration (Firebase Crashlytics)
- [ ] Test on multiple Android versions (API 24+)
- [ ] Test on different screen sizes
- [ ] Test on low-end devices
- [ ] Beta testing via Google Play
- [ ] Fix any ANR (Application Not Responding) issues

### Polish for Release
- [ ] Haptic feedback on ball fire and block destroy
- [ ] Localization (at minimum: English)
- [ ] Accessibility considerations (colorblind mode?)
- [ ] Rate app prompt (after X levels completed)
- [ ] Share score functionality
- [ ] Offline functionality (no internet required to play)

---

## Stretch Goals

- [ ] Daily challenge mode with seeded randomness
- [ ] Endless mode vs level-based campaign
- [ ] Boss blocks (large multi-cell blocks)
- [ ] Achievements system (Google Play Games)
- [ ] Leaderboards (Google Play Games)
- [ ] Cloud save (Google Play Games)
- [ ] Multiple themes/skins
- [ ] Level editor
