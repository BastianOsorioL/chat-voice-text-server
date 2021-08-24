extends Node
class_name VoiceInstance

signal received_voice_data
signal sent_voice_data

export var custom_voice_audio_stream_player: NodePath
export var recording: bool = false
export var listen: bool = false
export(float, 0.0, 1.0) var input_threshold: = 0.005

var _mic: VoiceMic
var _voice
var _effect_capture: AudioEffectCapture
var _playback: AudioStreamGeneratorPlayback
var _receive_buffer := PoolRealArray()
var _prev_frame_recording = false

onready var rooms_chat = get_tree().get_root().get_node("World/MenuChat").rooms_chat
onready var gamification_players = get_tree().get_root().get_node("World/MenuChat").gamification_players
onready var insignias_players = get_tree().get_root().get_node("World/MenuChat").insignias_players	

remote func _speak(sample_data: PoolRealArray, id: int, room_chat):
	
	if room_chat == rooms_chat.GAMIFICACION:
		for player in gamification_players:
			if player["id"] != id:
				rpc_unreliable_id(player["id"], "_speak", sample_data, id)
	elif room_chat == rooms_chat.INSIGNIAS:
		for player in insignias_players:
			if player["id"] != id:
				rpc_unreliable_id(player["id"], "_speak", sample_data, id)

remote func receive_private_audio(sample_data: PoolRealArray, id: int, id_receiver):
	rpc_id(id_receiver, "_speak", sample_data, id)
