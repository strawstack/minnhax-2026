# MinnHax 2026

Godot project files for the MinnHax 2026 Game Jam.

# Todo

- Add CrabPalace rap to beach.

- Add CrabPalace club loop to club scene.

- Link to CrabPalace Youtube/Spotify.

- Take itch project live.

- IMPORTANT: Submit game to jam and confirm it's in submissions.

- Announce game on Discord after submission.

# Done

- You can fly into the chimny

- If you turn off skating on the long stairs freelancer, you drop through map

- Remove "louder" from diaog line when LeBooBoo reacts to me saying I'm his voice actor.

- Remove the "(be good have fun..." line from Yu's final interview dialog.

- Remove "(pause)" from voice mail dialog.

- Fix line "... now lets see about this door" text is not same as audio.

- Targets if shot more than once go down more than once

- Put roof to prevent flying too high in obstacle course
- Block top stairs has no collider
- Limit jumps because it banks up speed and goes through floor
  - Player allowed three jumps every four seconds
- Missing stair at top of freelancer stairs to second floor
- "good luck on stage" during club performance does not match line. Char name should be MoneyPony to get correct avatar
- Delete a few more bake files to make room for rap and beat from CrabPalace (assume 15Mb)
  - Remove water and large surfaces from freelancer (global illumunatin disable)
- Swap bump map for texture on greenday level
- Second obj for if you do interview it should just say "find drummer"
- If you press e at any time it triggers the last seen logo
- Cowbell: Ability to play cowbell during final performance
- use dirt crumble to hide shimmy
- show driving controls top right
- await tacsim sound effect before fading into freelancer
- play door opening sound in freelancer house for doors
- garage door does not play sound in freelancer
- remove top bar of finishline
- open shooting tape exit sooner
- hide window shards at club so window clear before cutscene
- a sign that says "fire access only, or if you can't skate"
- window and tattoo needle need to be louder
- web doesn't support chinese characters, so switch back to "(speaking chinese)"
  - This line guest-voice-acted by Yu's Friend!
- "Why would I deceve you" line does not play over audio
- remove one couch collider from club
  - to prevent stuck in corner
- door close in club plays driving sound?
- "play cowbell with spacebar" label on screen during rap
- reset watch look in case player plays a second time
- update objective once you are out of the jeep
- its dark in the freelancer hallway
- collider on shooting exit door
- add bgm to exit and credits?
- place collider on fridge
- yu char model might be a bit underground
- Before apartment show loading: this may take a minute
- blue bin floor bedroom remove physics
- low battery sound should await to prevent deamp by voice line on chopper
- the unknown people say crab top right over and over
- my dialog after beach tape is under the fade
  - place a fade behind the dialog and call it from beach_party
- jeep can drive through walls during greenday training
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

- There's a split second lag at the start of beach.
  - Maybe related to lights. Could I take these out?

- stop boat sound on scene change

- there's no collider on the glass tank in main room of freelancer house

- show loading before main menu

- You can spam jump when in skate mode (does this break anything if not don't fix?)

- Lable on wall near studio door saying
  - "Controls: Spacebar to jump, WASD to move, mouse to look."

- Consider closing my office door when dialog is active?

- Add 3D letters to the title screen texture the walls and couch
