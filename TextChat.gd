extends Control

onready var gamification_players = get_tree().get_root().get_node("World/MenuChat").gamification_players
onready var insignias_players = get_tree().get_root().get_node("World/MenuChat").insignias_players
var rooms_chat

func _ready():
	rooms_chat = get_tree().get_root().get_node("World/MenuChat").rooms_chat

remote func receive_message_server(id_user, room_chat, msg):
	if room_chat == rooms_chat.GAMIFICACION:
		for player in gamification_players:
			rpc_id(player["id"],"receive_msg_server", id_user, msg)
	if room_chat == rooms_chat.INSIGNIAS:
		for player in insignias_players:
			rpc_id(player["id"],"receive_msg_server", id_user, msg)

remote func receive_private_message_server(id_user, msg, id_receiver):
	var id_send = [id_user, id_receiver]
	for id in id_send:
		rpc_id(id, "receive_msg_server", id_user, msg)	
