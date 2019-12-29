extends Node

signal transition(to)

export(PackedScene) var transition_screen_

enum LoadingState {LOADING, PLAYING, TRANS_IN, TRANS_OUT}

var loading_state = LoadingState.PLAYING
var loading_screen: String
var current_screen

onready var main_container: = get_tree().current_scene.get_path()
onready var resource_queue: = load("res://src/utils/resource_queue.gd")
onready var animation = $AnimationPlayer
onready var canvas = $CanvasLayer

func _ready() -> void:
	connect("transition", self, "on_ScreenManager_transition")
	resource_queue.start()
	var transition_screen = transition_screen_.instance()
	canvas.add_child(transition_screen)
	pass

func on_ScreenManager_transition(to: String) -> void:
	loading_screen = to
	resource_queue.queue_resource(loading_screen)
	loading_state = LoadingState.TRANS_IN
	pass

func _process(delta: float) -> void:
	if loading_state == LoadingState.LOADING:
		var new_screen = resource_queue.get_resource(loading_screen)
		if new_screen:
			current_screen = new_screen.instance()
			loading_state = LoadingState.TRANS_OUT
			set_process(false)
