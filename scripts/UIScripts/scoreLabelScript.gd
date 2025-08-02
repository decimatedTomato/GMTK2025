extends Control

var full_screen = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().get_root().size_changed.connect(window_resized)
	full_screen = DisplayServer.window_get_mode()
	call_deferred("set_children", self.get_children())

func _physics_process(_delta: float) -> void:
	if full_screen != DisplayServer.window_get_mode():
		full_screen = DisplayServer.window_get_mode()
		call_deferred("window_resized")

func window_resized():
	check_children(self.get_children())

func set_children(children):
	if children == null:
		return
	if len(children) == 0:
		return

	for child in children:
		set_children(child.get_children())

		if child is Label or child is TextEdit or child is Button or child is LineEdit or child is RichTextLabel:
			print(child)
			save_font_size(child, child.get_parent())

func check_children(children):
	if children == null:
		return
	if len(children) == 0:
		return

	for child in children:
		check_children(child.get_children())

		if child is Label or child is TextEdit or child is Button or child is LineEdit or child is RichTextLabel:
			fix_font_size(child, child.get_parent())

func fix_font_size(text_element, parent):
	if text_element.has_meta("fsize"):
		var font_override_default = text_element.get_meta("fsize")
		var parent_width_default = text_element.get_meta("pwidth")
		var parent_current_width = text_element.size.x

		if text_element is Label:
			parent_current_width = parent.size.x

		var difference = parent_current_width / parent_width_default
		var scale = int(font_override_default * difference)

		if text_element is RichTextLabel:
			text_element.add_theme_font_size_override("normal_font_size", scale)
			return 

		text_element.add_theme_font_size_override("font_size", scale)

func save_font_size(text_element, parent):
	if text_element == null:
		return
	if text_element.has_meta("fsize") == false:
		var font_override_default = 0
		if text_element is RichTextLabel:
			if text_element["theme_override_font_sizes/normal_font_size"] != null:
				font_override_default = text_element["theme_override_font_sizes/normal_font_size"]
			else:
				font_override_default = 16
		else:
			if text_element["theme_override_font_sizes/font_size"] != null:
				font_override_default = text_element["theme_override_font_sizes/font_size"]
			else:
				font_override_default = 16
			
		var parent_current_width = text_element.size.x

		if text_element is Label:
			parent_current_width = parent.size.x

		(text_element).set_meta("fsize", font_override_default)
		(text_element).set_meta("pwidth", parent_current_width)
