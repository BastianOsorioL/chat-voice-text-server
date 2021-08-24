extends Node2D

var gamification_players = []
var insignias_players = []

enum rooms_chat {GAMIFICACION, INSIGNIAS, MICRO, STACKBIO}


func _ready():
	pass # Replace with function body.

remote func receive_chat_players(user_id, room_chat):
	if room_chat == rooms_chat.GAMIFICACION:
		gamification_players.append({"id": user_id, "type_chat": room_chat})
	elif room_chat == rooms_chat.INSIGNIAS:
		insignias_players.append({"id": user_id, "type_chat": room_chat})
