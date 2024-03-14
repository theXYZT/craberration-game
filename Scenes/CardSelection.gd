extends Node2D

var card_scene: PackedScene = load("res://Scenes/UI/Card.tscn")
var left_card: Card
var right_card: Card

const left_card_position := Vector2(480, 350)
const right_card_position := Vector2(660, 350)

var mutation_num: int

var LEFT_CARD_DICT: Dictionary = {
	0: {
		"title": "Hyper-Active",
		"desc": "Move 20% faster, and energy usage is 30% higher.",
		"bg_color": Color.from_hsv(0.6, 1.0, 0.4),
		"fg_color": Color.from_hsv(0.50, 1.0, 1.0),
		"effect": func(): (%Crab as Crab).become_athletic()
	},
	1: {
		"title": "South Claw",
		"desc": "Left Claw is 50% bigger!",
		"bg_color": Color.from_hsv(0.0, 0.0, 0.0),
		"fg_color": Color.GOLD,
		"effect": func(): (%Crab as Crab).big_left_claw()
	},
	2: {
		"title": "Dash!",
		"desc": "You can now dash quickly to the other side.",
		"bg_color": Color.from_hsv(0.6, 1.0, 0.4),
		"fg_color": Color.from_hsv(0.50, 1.0, 1.0),
		"effect": func(): (%Crab as Crab).get_dash_move()
	},
	3: {
		"title": "Inefficient Digestion",
		"desc": "Eating baby crabs now gives -50% energy.",
		"bg_color": Color.from_hsv(0.6, 1.0, 0.4),
		"fg_color": Color.from_hsv(0.50, 1.0, 1.0),
		"effect": func(): %BabySpawner.get_indigestion()
	}
}

var RIGHT_CARD_DICT: Dictionary = {
	0: {
		"title": "Lazy Crab",
		"desc": "Move 20% slower, and energy usage is 25% lower.",
		"bg_color": Color.DEEP_PINK,
		"fg_color": Color.WHITE,
		"effect": func(): (%Crab as Crab).become_lazy()
	},
	1: {
		"title": "Big Right Claw",
		"desc": "Right Claw is 50% bigger!",
		"bg_color": Color(0.549, 0, 0),
		"fg_color": Color(1, 0.8431, 0.2275),
		"effect": func(): (%Crab as Crab).big_right_claw()
	},
	2: {
		"title": "Sand Quake",
		"desc": "You can push back and slow down baby crabs near you.",
		"bg_color": Color(0.549, 0, 0),
		"fg_color": Color(1, 0.8431, 0.2275),
		"effect": func(): (%Crab as Crab).get_sand_move()
	},
	3: {
		"title": "Aggressive Babies",
		"desc": "Mutant babies now take energy to eat.",
		"bg_color": Color(0.549, 0, 0),
		"fg_color": Color(1, 0.8431, 0.2275),
		"effect": func(): %BabySpawner.get_angry_mutants()
	}   
}

func _ready():
	mutation_num = -1

func mutate():
	mutation_num += 1
	left_card = card_scene.instantiate()
	left_card.card_clicked.connect(on_picked_left)
	setup_card(left_card, left_card_position, LEFT_CARD_DICT[mutation_num])

	right_card = card_scene.instantiate()
	right_card.card_clicked.connect(on_picked_right)
	setup_card(right_card, right_card_position, RIGHT_CARD_DICT[mutation_num])

func setup_card(card: Card, pos: Vector2, dict: Dictionary):
	card.global_position = pos
	card.title = dict["title"]
	card.description = dict["desc"]
	card.bg_color = dict["bg_color"]
	card.fg_color = dict["fg_color"]
	add_child(card)

func on_picked_left():
	resolve_choice(left_card, right_card, LEFT_CARD_DICT[mutation_num]["effect"])

func on_picked_right():
	resolve_choice(right_card, left_card, RIGHT_CARD_DICT[mutation_num]["effect"])

func resolve_choice(picked: Card, discard: Card, effect: Callable):
	discard.make_disappear()
	await get_tree().create_timer(0.2).timeout
	remove_child(picked)
	picked.make_dormant()
	$"../CardHolder".add_child(picked)
	$"../CardsLabel".visible = true
	effect.call()
	visible = false
	get_tree().paused = false
