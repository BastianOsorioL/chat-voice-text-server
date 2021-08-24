extends Node

var playersLog = []
var players_private = []

func _ready():
	pass

func sendIdNewPlayer(playerId):
	rpc_unreliable_id(playerId, "receiverPlayerId", playerId)

func sendPlayers(playerId, players):
	rpc_unreliable_id(playerId, "receivePlayers", players)

remote func receive_private_chat_player(player_id):
	players_private.append(player_id)
	for player in players_private:
		rpc_id(player, "receive_player_private", players_private)
