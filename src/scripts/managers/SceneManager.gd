extends Node

enum GameScreen {
	MAIN_MENU,
	LEVEL
}

const MAIN_MENU_SCENE = preload("res://scenes/menus/MainMenu.tscn")

const LEVEL_SCENES: Array[PackedScene] = [
	preload("res://scenes/levels/stage1/Level1.tscn"),
	preload("res://scenes/levels/stage1/Level2.tscn"),
	preload("res://scenes/levels/stage1/Level3.tscn"),
	preload("res://scenes/levels/stage2/Level1.tscn"),
	preload("res://scenes/levels/stage2/Level2.tscn"),
	preload("res://scenes/levels/stage2/Level3.tscn"),
	preload("res://scenes/levels/stage3/Level1.tscn"),
	#preload("res://scenes/levels/stage3/Level2.tscn"),
	#preload("res://scenes/levels/stage3/Level3.tscn")
]

var game_screen: GameScreen = GameScreen.MAIN_MENU

var level_index: int = 0

var main_menu: MainMenu = null
var current_level: Level = null
var screen_transition: ScreenTransition

func start_game(p_screen_transition: ScreenTransition) -> void:
	screen_transition = p_screen_transition
	_change_screen()
	
func _get_next_screen() -> GameScreen:
	match game_screen:
		GameScreen.MAIN_MENU:
			return GameScreen.LEVEL
		GameScreen.LEVEL:
			return GameScreen.MAIN_MENU
		_:
			return GameScreen.MAIN_MENU
			
func _change_screen():
	await screen_transition.fade_out()
	
	if main_menu:
		main_menu.queue_free()
		
	if current_level:
		current_level.queue_free()
		
	match game_screen:
		GameScreen.MAIN_MENU:
			main_menu = MAIN_MENU_SCENE.instantiate()
			main_menu.started.connect(_on_game_started, CONNECT_ONE_SHOT)
			get_tree().current_scene.add_child(main_menu)
		GameScreen.LEVEL:
			_start_next_level()
	
	await screen_transition.fade_in()

func _start_next_level() -> void:
	if level_index >= LEVEL_SCENES.size():
		return
	
	current_level = LEVEL_SCENES[level_index].instantiate()
	level_index += 1
	
	call_deferred("_add_level")

func _add_level() -> void:
	current_level.completed.connect(_on_level_completed, CONNECT_ONE_SHOT)
	get_tree().current_scene.add_child(current_level)
	
func _on_game_started() -> void:
	game_screen = _get_next_screen()
	_change_screen()
	
func _on_level_completed() -> void:
	_change_screen()
