class_name Card
extends Control

var tween: Tween
const dull: Color = Color(0.75, 0.75, 0.75)
const bright: Color = Color(1.25, 1.25, 1.25)
var HOVERING: bool = false
signal card_clicked
var normal_pos_y

@export_multiline var title: String = "Card Name"
@export_multiline var description: String = "Body text describing card's effects"
@export var bg_color: Color = Color.from_hsv(0.6, 1.0, 0.4)
@export var fg_color: Color = Color.from_hsv(0.50, 1.0, 1.0)

func make_stylebox():
	var stylebox := StyleBoxFlat.new()
	stylebox.bg_color = bg_color
	stylebox.border_color = fg_color
	stylebox.border_width_left = 4
	stylebox.border_width_bottom = 4
	stylebox.border_width_right = 4
	stylebox.border_width_top = 4
	stylebox.corner_radius_bottom_left = 10
	stylebox.corner_radius_bottom_right = 10
	stylebox.corner_radius_top_left = 10
	stylebox.corner_radius_top_right = 10
	stylebox.shadow_size = 5
	stylebox.shadow_color = Color(0, 0, 0, 0.3)
	return stylebox

func _ready():
	$CardTitle.text = title
	$CardDesc.text = description
	normal_pos_y = position.y
	stylize()

func stylize():
	modulate = dull
	$CardTitle.add_theme_color_override("font_color", fg_color)
	($Background as Panel).add_theme_stylebox_override("panel", make_stylebox())

func make_dormant():
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	modulate = Color.WHITE
	scale = Vector2.ONE
	
func make_disappear():
	if tween:
		tween.kill()
	tween = create_tween().set_parallel(true).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "modulate", Color.TRANSPARENT, 0.1).from_current()
	tween.tween_property(self, "scale", Vector2(0.5, 0.5), 0.1).from_current()
	tween.chain().tween_callback(queue_free)

func _on_mouse_entered():
	if tween:
		tween.kill()
	tween = create_tween().set_parallel(true).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position:y", normal_pos_y - 20, 0.6).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(self, "modulate", bright, 0.1)
	HOVERING = true

func _on_mouse_exited():
	if tween:
		tween.kill()
	tween = create_tween().set_parallel(true).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position:y", normal_pos_y, 0.5).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(self, "modulate", dull, 0.2)
	tween.tween_property(self, "scale", Vector2.ONE, 0.1)
	HOVERING = false

func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == 1 and HOVERING:
		if event.pressed:
			on_press()
		else:
			on_click()

func on_press():
	if tween:
		tween.kill()
	tween = create_tween().set_parallel(true).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", Vector2(1.1, 1.1), 0.1).set_trans(Tween.TRANS_BACK)

func on_click():
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	card_clicked.emit()

	if tween:
		tween.kill()
	tween = create_tween().set_parallel(true).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", Vector2(1.1, 1.1), 0.1).set_trans(Tween.TRANS_BACK)
	tween.tween_property(self, "modulate", bright, 0.1)
