extends Node
#@onready var areabox = $sword

var playerBody = CharacterBody2D

var player_damage_zone : Area2D
var playerDamageAmount : int
var playerHitBox: Area2D

var kalabanDamageZone :Area2D
var frogDamage : int
#
#func _ready():
	#player_damage_zone = areabox
