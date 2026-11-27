extends Node3D

const DEBUG = true

@export var commands: Node3D
@export var bulletSmoke: Node3D
@export var audioStreamPlayerBGM: AudioStreamPlayer
@export var audioStreamPlayerSoundEffect: AudioStreamPlayer
@export var audioStreamPlayer_Cowbell: AudioStreamPlayer
@export var preloadVoice: Node3D

const scenes = {
	"logo": preload("res://scene/logo.tscn"),
	"splash": preload("res://scene/splash.tscn"),
	"mainMenu2": preload("res://scene/main_menu_2.tscn"),
	"apartment": preload("res://scene/apartment.tscn"),
	"underwater": preload("res://scene/underwater.tscn"),
	"helicopter": preload("res://scene/helicopter.tscn"),
	"beach": preload("res://scene/beach.tscn"),
	"beachParty": preload("res://scene/beach_party.tscn"),
	"greenDay": preload("res://scene/green_day.tscn"),
	"trainingShoot": preload("res://scene/training_shoot.tscn"),
	"obstacleCourse": preload("res://scene/obstacle_course.tscn"),
	"tacSim": preload("res://scene/tac_sim.tscn"),
	"freelancer": preload("res://scene/freelancer.tscn"),
	"island": preload("res://scene/island.tscn"),
	"credits": preload("res://scene/credits.tscn"),
}

const musicTracks = {
	"example_music": preload("res://audio/tracks/example_music.mp3"),
	"example_music_long": preload("res://audio/tracks/example_music_long.mp3"),
	"skate": preload("res://audio/tracks/skate.mp3"),
	"camping": preload("res://audio/tracks/camping.mp3"),
	"island": preload("res://audio/tracks/island.mp3")
}

const bgmMusic = {
	"apartment": preload("res://audio/bgm/bgm_apartment.mp3"),
	"bubbles": preload("res://audio/bgm/loop_bubbles.mp3"),
	"helicopter": preload("res://audio/bgm/helicopter.mp3"),
	"waves": preload("res://audio/bgm/loop_waves.mp3"),
	"greenday": preload("res://audio/bgm/bgm_greenday_jeep.mp3"),
	"obstacle": preload("res://audio/bgm/bgm_shooting_obstacle.mp3"),
	"tacsim": preload("res://audio/bgm/bgm_mi6.mp3"),
	"freelancer": preload("res://audio/bgm/bgm_freelancer.mp3"),
	"outsideclub": preload("res://audio/bgm/bgm_outside_club.mp3"),
	"insideclub": preload("res://audio/bgm/bgm_inside_club.mp3")
}

const soundEffect = {
	"air_plane_off": preload("res://audio/soundEffect/air_plane_off.mp3"),
	"boat_engine": preload("res://audio/soundEffect/boat_engine.mp3"),
	"bullet_wood": preload("res://audio/soundEffect/bullet_wood.mp3"),
	"car_start": preload("res://audio/soundEffect/car_start.mp3"),
	"cowbell": preload("res://audio/soundEffect/cowbell.mp3"),
	"door_lock": preload("res://audio/soundEffect/door_lock.mp3"),
	"door_open": preload("res://audio/soundEffect/door_open.mp3"),
	"elevator_close": preload("res://audio/soundEffect/elevator_close.mp3"),
	"elevator_open": preload("res://audio/soundEffect/elevator_open.mp3"),
	"explode": preload("res://audio/soundEffect/explode.mp3"),
	"flag_flap": preload("res://audio/soundEffect/flag_flap.mp3"),
	"garage_door": preload("res://audio/soundEffect/garage_door.mp3"),
	"gear_spin": preload("res://audio/soundEffect/gear_spin.mp3"),
	"glass_break": preload("res://audio/soundEffect/glass_break.mp3"),
	"gun_shot": preload("res://audio/soundEffect/gun_shot.mp3"),
	"item_collect": preload("res://audio/soundEffect/item_collect.mp3"),
	"jeep_hit": preload("res://audio/soundEffect/jeep_hit.mp3"),
	"jump": preload("res://audio/soundEffect/jump.mp3"),
	"low_battery": preload("res://audio/soundEffect/low_battery.mp3"),
	"rocket_fly_explode": preload("res://audio/soundEffect/rocket_fly_explode.mp3"),
	"small_debris": preload("res://audio/soundEffect/small_debris.mp3"),
	"success": preload("res://audio/soundEffect/success.mp3"),
	"tac_sim_start": preload("res://audio/soundEffect/tac_sim_start.mp3"),
	"tattoo_needle": preload("res://audio/soundEffect/tatto_needle.mp3"),
	"wind": preload("res://audio/soundEffect/wind.mp3"),
	"wood_door_smash": preload("res://audio/soundEffect/wood_door_smash.mp3"),
	"meow": preload("res://audio/soundEffect/meow.mp3")
}

# commandLookup populated by Commands child node 
var commandLookup = {}
# If command is not present, checks sceneCommandLookup which is populated by scene
var sceneCommandLookup = {}

var animationPlayer
var dialogInProgress = false # Set when dialog is in progress
var playerCanMove = false

# Controls if player looks at watch when underwater scene plays
var lookWatchUnderwater = false

# CharacterName to mouthNode lookup
var mouthLookup = {}

# ref
var audioStreamPlayerVoice: AudioStreamPlayer
var audioStreamPlayerMusicTrack: AudioStreamPlayer

func _ready() -> void:
	animationPlayer = $AnimationPlayer
	audioStreamPlayerVoice = $Audio/AudioStreamPlayerVoice
	audioStreamPlayerMusicTrack = $Audio/AudioStreamPlayerMusicTrack
	hideInteract()
	showCrossHairs(false)
	hideObjective()
	hideRecording()
	if DEBUG:
		loadScene("greenDay")
	else:
		# Show and Hide these just to make sure
		$CanvasLayer_Fade.set_visible(true) 
		$CanvasLayer_MusicDialog.set_visible(false)
		$CanvasLayer_BeachFade.set_visible(false)
		loadScene("logo") # Calls "logoSceneEnds" on completion

func beachFadeVisible():
	$CanvasLayer_BeachFade.set_visible(true)

func beachFadeIn():
	$CanvasLayer_BeachFade/AnimationPlayer.play("localFadeIn")

func setObjectiveLetter(letter: String):
	$CanvasLayer_Objective.setObjectiveLetter(letter)

func showRecording():
	$CanvasLayer_Recording.set_visible(true)

func hideRecording():
	$CanvasLayer_Recording.set_visible(false)

func stopBGM():
	audioStreamPlayerBGM.stop()

func playBGM(trackName: String):
	audioStreamPlayerBGM.stop()
	if trackName in bgmMusic:
		audioStreamPlayerBGM.stream = bgmMusic[trackName]
		audioStreamPlayerBGM.play()
	else:
		print("MISSING: " + trackName)

func playSoundEffect(effectName: String):
	if not audioStreamPlayerSoundEffect.is_playing():
		if effectName in soundEffect:
			audioStreamPlayerSoundEffect.stream = soundEffect[effectName]
			audioStreamPlayerSoundEffect.play()
		else:
			print("MISSING: " + effectName)

func playSoundEffectAwait(effectName: String):
	if audioStreamPlayerSoundEffect.is_playing():
		audioStreamPlayerSoundEffect.stop()
	if effectName in soundEffect:
		audioStreamPlayerSoundEffect.stream = soundEffect[effectName]
		audioStreamPlayerSoundEffect.play()
		await audioStreamPlayerSoundEffect.finished
	else:
		print("MISSING: " + effectName)

func targetHit():
	$Audio/AudioStreamPlayer_TargetHit.play()

func gunShoot():
	$Audio/AudioStreamPlayer_Shoot.play()

func hideDialog():
	$CanvasLayer_Dialog.set_visible(false)

func showCrossHairs(value):
	$CanvasLayer_Interact/TextureRect.set_visible(value)

func setPlayerCanMove(value):
	playerCanMove = value

func hideObjective():
	$CanvasLayer_Objective.set_visible(false)

func showObjective():
	$CanvasLayer_Objective.set_visible(true)

func endAwaitDialog():
	$CanvasLayer_Dialog.endAwait()

func fadeIn():
	animationPlayer.play("fadeIn")
	await animationPlayer.animation_finished

func fadeOut():
	animationPlayer.play("fadeOut")
	await animationPlayer.animation_finished

func showInteract(msg):
	$CanvasLayer_Interact/PanelContainer/Label.set_text(msg)
	$CanvasLayer_Interact/PanelContainer.set_visible(true)

func hideInteract():
	$CanvasLayer_Interact/PanelContainer.set_visible(false)

func registerMouth(characterName, mouthNode):
	if characterName in mouthLookup:
		mouthLookup[characterName].push_back(mouthNode)
	else:
		mouthLookup[characterName] = [mouthNode]

func playVoice(voiceFile: String):
	if voiceFile != "":
		var audio = null
		if voiceFile in preloadVoice.preloadLookup:
			audio = preloadVoice.preloadLookup[voiceFile]
		else:
			audio = load("res://dialog/vocal/" + voiceFile + ".mp3")
		if audio:
			audioStreamPlayerVoice.stream = audio
			audioStreamPlayerVoice.play()
		else:
			print("MISSING: " + voiceFile)

func playMusic(track):
	stopBGM()
	if track in musicTracks:
		audioStreamPlayerMusicTrack.stream = musicTracks[track]
		audioStreamPlayerMusicTrack.play() # Calls _on_audio_stream_player_music_track_finished when finished
	else:
		print("MISSING music: " + track)

func stopMusic():
	if audioStreamPlayerMusicTrack.is_playing():
		hideMusicUI()
		audioStreamPlayerMusicTrack.stop()
		endAwaitDialog()

func setMusicDialogAvatar(texture: Texture2D):
	$CanvasLayer_MusicDialog/TextureRect_Avatar.set_texture(texture)

func setMusicDialogCharacterName(name: String):
	$CanvasLayer_MusicDialog/Label_CharacterName.set_text(name)

func showMusicUI():
	$CanvasLayer_Dialog.set_visible(false)
	$CanvasLayer_MusicDialog.set_visible(true)

func hideMusicUI():
	$CanvasLayer_Dialog.set_visible(true)
	$CanvasLayer_MusicDialog.set_visible(false)

func stopVoice():
	audioStreamPlayerVoice.stop()

func playGlassBreak():
	$Audio/AudioStreamPlayer_Glass.play()

func playGlassBreakAwait():
	$Audio/AudioStreamPlayer_Glass.play()
	await $Audio/AudioStreamPlayer_Glass.finished
	endAwaitDialog()

func playTattooNeedleAwait():
	$Audio/AudioStreamPlayer_Tattoo.play()
	await $Audio/AudioStreamPlayer_Tattoo.finished
	endAwaitDialog()

func logoSceneEnds():
	await fadeOut()
	await get_tree().create_timer(1.0).timeout
	loadScene("splash")
	await fadeIn()
	await get_tree().create_timer(4.0).timeout
	await fadeOut()
	playBGM("tacsim")
	loadScene("mainMenu2") # Calls "mainMenuStartPress" on completion

func showGameLoading(extraText: bool):
	if extraText:
		$CanvasLayer_Loading/Label_Extra.set_visible(true)
	$CanvasLayer_Loading.set_visible(true)

func hideGameLoading():
	$CanvasLayer_Loading.set_visible(false)
	$CanvasLayer_Loading/Label_Extra.set_visible(false)

func mainMenuStartPress():
	await fadeOut()
	stopBGM()
	showGameLoading(true)
	await get_tree().create_timer(0.5).timeout
	loadScene("apartment")

func playDialogFile(fileStr: String):
	var json = JSON.parse_string(FileAccess.get_file_as_string(fileStr))
	if json:
		dialogInProgress = true
		$CanvasLayer_Dialog.playDialog(json)

func triggerCommand(command: String):
	if command in commandLookup:
		commandLookup[command].call()
	elif command in sceneCommandLookup:
		sceneCommandLookup[command].call()
	else:
		print("TODO: Command not found: " + command)

func setMouth(name: String):
	for characterName in mouthLookup:
		for mouth in mouthLookup[characterName]:
			if mouth:
				mouth.setIsSpeaking(characterName == name)

# Called when a dialog ends indicating a new one can be started
func dialogEnds():
	dialogInProgress = false

func _process(_delta: float) -> void:
	pass

func loadScene(sceneName: String):
	for child in $Scene.get_children():
		$Scene.remove_child(child)
		child.queue_free()
	var instance = scenes[sceneName].instantiate()
	$Scene.add_child(instance)

func _input(event):
	# Capture mouse on left click
	if event.is_action_pressed("left_click"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	# Free mouse on esc
	if event.is_action_pressed("esc"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func playCowbell():
	audioStreamPlayer_Cowbell.play()

func draw_thick_line(from: Vector3, to: Vector3):
	bulletSmoke.draw_thick_line(from, to)

# Called by interacting with Control Room 2 prompt after morning voice mail
func startGameStream():
	await fadeOut()
	playBGM("bubbles")
	mouthLookup.clear()
	lookWatchUnderwater = true
	showCrossHairs(false)
	sceneCommandLookup.clear()
	loadScene("underwater")

func sceneHelicopter():
	await fadeOut()
	playBGM("helicopter")
	mouthLookup.clear()
	lookWatchUnderwater = false
	loadScene("helicopter")

func loadBeachScene():
	playerCanMove = false
	await fadeOut()
	playBGM("waves")
	playSoundEffect("wind")
	mouthLookup.clear()
	loadScene("beach")

func loadBeachParty():
	playerCanMove = false
	await fadeOut()
	beachFadeVisible()
	mouthLookup.clear()
	loadScene("beachParty")

func loadGreenDayTraining():
	playerCanMove = false
	await fadeOut()
	playBGM("greenday")
	playSoundEffect("air_plane_off")
	mouthLookup.clear()
	loadScene("greenDay")

func loadTrainingShoot():
	playerCanMove = false
	await fadeOut()
	playBGM("obstacle")
	mouthLookup.clear()
	loadScene("trainingShoot")

func loadObstacleCourse():
	playerCanMove = false
	await fadeOut()
	mouthLookup.clear()
	loadScene("obstacleCourse")

func loadTacSim():
	playerCanMove = false
	await fadeOut()
	playBGM("tacsim")
	mouthLookup.clear()
	loadScene("tacSim")

func loadFreelancer():
	playerCanMove = false
	await fadeOut()
	playBGM("freelancer")
	mouthLookup.clear()
	loadScene("freelancer")

func loadIsland():
	playerCanMove = false
	await fadeOut()
	playBGM("outsideclub")
	mouthLookup.clear()
	loadScene("island")

func loadCredits():
	playerCanMove = false
	await fadeOut()
	mouthLookup.clear()
	loadScene("credits")

# Music Track finishes playing
func _on_audio_stream_player_music_track_finished() -> void:
	hideMusicUI()
	endAwaitDialog()
