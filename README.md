# MinnHax 2026

Godot project files for the MinnHax 2026 Game Jam.

# Todo

- CONFIRM: Cowbell: Ability to play cowbell during final performance

- Submit game on itch io
  - Game description
  - Screenshots
  - Controls
  - Credits: Richard, Yu, CrabPalace
  - Links to Youtube music
  - Music credits: AudioLibrary
  - No AI statement

- Upload tracks to Youtube

# Done

- Show player cursor after dialogs in apartment

- GreenDay jeep vanishes after exit jeep cutscene and should stay around as you walk up the stairs
- During "...going to cinnabon" line I think I saw the player in the left side of shot. Make sure play is hidden for this scene
- Crosshairs missing in greenday training (fix throughout)
- Radio dissappear from rock on beach once taken
  - Add emmission to radio
  - Add radio sound effect
- make sure BGM not playing during music rap
- Beach ground and all walls are labeled as invisible:
  - The camera can go into them they should be labeled as "wall" to help camera physics
  - Applies to all rocks except barrier in the water
  - Confirm when player can and can't skate/shoot throughout
  - Make sure glass break and tattoo needle sound play over correct bus
- images on monitors
  - PC in my office
  - Stream PC
- Metal door opening sound effect for greenday training (gears)
- Balance audio to avoid any loud noises
  - Assume all play at full volume
  - So play at 75% in Audacity and then dip tracks accordingly
  - Directly overwright files in Godot folder to adjust

- AUDIO:
  - 13 01 a Agent: When I woke, my plane had landed, and it was time to meet my instructor.
  - 06 03 Rich: Okay, doors open. You can head down now.

- Low battery not showing low battery screen when character says "uh oh..."

- Three second pause after rocket explosion before loading beach
- One second pause after rolling before monroll comments on it
- Hide dialog when activating tacSim
- Add grass to grey wall in skate park
- Patch grind rail close to wall in skate park to prevent glitch out of wall
- Can we "load cameras" in advance of apartment to help?

- Place images throughout the game
  - CrabPalace in my office
  - Dev images of Yu and I recording
  - Nevi sleeping on my desk
  - A community meet-up screenshot with label

- Gun doesn't shoot exactly at center dot in screen
  - Maybe just move the dot a bit I think ray is centered

- Food on stove

- Remove "..." from all in game text it delays the dialog box too long so audio plays before text shows

- Remove objective notice during interview scene

- Stop nevi from meowing once the studio door is opened

- Review screenshots for more fixes (for example, placing images on monitors in apartment)

- Objectives: Wire up objectives to make sure they show hide and reflect the correct info

- Dialog: Missing dialog "first though lets get this stream started"

- For mac track pad, maybe allow "hold R" to aim (in addition to right click) left mouse to shoot

- Nevi should meow when he moves (maybe not could be annoying?)

- Studio stairs door. Make is colored to be more apparent

- Flip the studio wall art when interview starts

- Place greenday near flag in obstacle course level

- Add Avatars to dialog box for each character

- Record patch audio

- Add background music

- Add sound effects

- Top step of stairs to basement clips with floor - lower visible step a bit

- add lilboo

- add voice mail phone

- Show Nevi on the desk at the correct time

- Remove from in game text "It's all in good fun though, and..." this is not in audio file by choice

- Physics boundaries in beach level to ensure radio, and dialog before squeeze

- Make skate stairs fix to Freelancer level in Blender

- Wire dialog files throughout the game
  - Get to the club, so we can confirm that the ending works
  - Build out credits scene
  - Find music tracks for following
    - Apartment
    - GreenDay training (and use same for all training)
    - Background office for TacSim maybe
    - Freelancer house
    - Outside the club
  - Continue with fixes below

- Make it so a rap can't be skipped and shows only a "tape playing" icon during play
- Nevi should not be able to move until the initial apartment dialog is done
- Wire up dialog files to logos
- Finish up Richard draft audio
  - Export clips, review story, record patches
  - Edit diana's file
  - Name and export clips

# Cancel

- You can spam jump when in skate mode (does this break anything if not don't fix?)

- Lable on wall near studio door saying
  - "Controls: Spacebar to jump, WASD to move, mouse to look."

- Consider closing my office door when dialog is active?

- Add 3D letters to the title screen texture the walls and couch
