extends Control

@onready var skin_color_picker: ColorPickerButton = $MarginContainer/ScrollContainer/VBoxContainer/SkinColorSection/SkinColorPicker

@onready var hair_color_picker: ColorPickerButton = $MarginContainer/ScrollContainer/VBoxContainer/HairSection/HairColorPicker
@onready var hair_style_option: OptionButton = $MarginContainer/ScrollContainer/VBoxContainer/HairSection/HairStyleOption

@onready var shirt_color_picker: ColorPickerButton = $MarginContainer/ScrollContainer/VBoxContainer/ShirtSection/ShirtColorPicker
@onready var shirt_style_option: OptionButton = $MarginContainer/ScrollContainer/VBoxContainer/ShirtSection/ShirtStyleOption

@onready var jacket_color_picker: ColorPickerButton = $MarginContainer/ScrollContainer/VBoxContainer/JacketSection/JacketColorPicker
@onready var jacket_style_option: OptionButton = $MarginContainer/ScrollContainer/VBoxContainer/JacketSection/JacketStyleOption

@onready var pants_color_picker: ColorPickerButton = $MarginContainer/ScrollContainer/VBoxContainer/PantsSection/PantsColorPicker
@onready var pants_style_option: OptionButton = $MarginContainer/ScrollContainer/VBoxContainer/PantsSection/PantsStyleOption

@onready var shoes_color_picker: ColorPickerButton = $MarginContainer/ScrollContainer/VBoxContainer/ShoesSection/ShoesColorPicker
@onready var shoes_style_option: OptionButton = $MarginContainer/ScrollContainer/VBoxContainer/ShoesSection/ShoesStyleOption

@onready var zoom_slider: HSlider = $MarginContainer/ScrollContainer/VBoxContainer/ZoomSection/ZoomSlider
@onready var randomize_button: Button = $MarginContainer/ScrollContainer/VBoxContainer/HboxContainer/RandomizeButton
@onready var reset_button: Button = $MarginContainer/ScrollContainer/VBoxContainer/HboxContainer/ResetButton

func _ready() -> void:
	_setup_options()
	CustomizationManager.customization_updated.connect(_update_ui_from_data)
	_update_ui_from_data()


func _setup_options() -> void:
	hair_style_option.clear()
	hair_style_option.add_item("Bald", CharacterData.Hairstyle.Bald)
	hair_style_option.add_item("Short Hair", CharacterData.Hairstyle.Short)
	hair_style_option.add_item("Long Hair", CharacterData.Hairstyle.Long)
	
	var data = CustomizationManager.character_data
	skin_color_picker.color = data.skin_color
	hair_color_picker.color = data.hair_color
	shirt_color_picker.color = data.shirt_color
	jacket_color_picker.color = data.jacket_color
	pants_color_picker.color = data.pants_color
	shoes_color_picker.color = data.shoes_color


func _update_ui_from_data() -> void:
	var data = CustomizationManager.character_data
	
	skin_color_picker.color = data.skin_color
	hair_color_picker.color = data.hair_color
	shirt_color_picker.color = data.shirt_color
	jacket_color_picker.color = data.jacket_color
	pants_color_picker.color = data.pants_color
	shoes_color_picker.color = data.shoes_color
	
	for i in hair_style_option.item_count:
		if hair_style_option.get_item_id(i) == data.selected_hair:
			hair_style_option.select(i)
			break


func _on_skin_color_picker_color_changed(color: Color) -> void:
	CustomizationManager.update_color(CharacterData.BodyPart.BASE, color)


func _on_hair_color_picker_color_changed(color: Color) -> void:
	CustomizationManager.update_color(CharacterData.BodyPart.HAIR, color)


func _on_hair_style_option_item_selected(index: int) -> void:
	var style_id = hair_style_option.get_item_id(index)
	CustomizationManager.update_part(CharacterData.BodyPart.HAIR, style_id)


func _on_shirt_color_picker_color_changed(color: Color) -> void:
	CustomizationManager.update_color(CharacterData.BodyPart.SHIRT, color)


func _on_shirt_style_option_item_selected(index: int) -> void:
	var style_id = shirt_style_option.get_item_id(index)
	CustomizationManager.update_part(CharacterData.BodyPart.SHIRT, style_id)


func _on_jacket_color_picker_color_changed(color: Color) -> void:
	CustomizationManager.update_color(CharacterData.BodyPart.JACKET, color)


func _on_jacket_style_option_item_selected(index: int) -> void:
	var style_id = jacket_style_option.get_item_id(index)
	CustomizationManager.update_part(CharacterData.BodyPart.JACKET, style_id)


func _on_pants_color_picker_color_changed(color: Color) -> void:
	CustomizationManager.update_color(CharacterData.BodyPart.PANTS, color)


func _on_pants_style_option_item_selected(index: int) -> void:
	var style_id = pants_style_option.get_item_id(index)
	CustomizationManager.update_part(CharacterData.BodyPart.PANTS, style_id)


func _on_shoes_color_picker_color_changed(color: Color) -> void:
	CustomizationManager.update_color(CharacterData.BodyPart.SHOES, color)


func _on_shoes_style_option_item_selected(index: int) -> void:
	var style_id = shoes_style_option.get_item_id(index)
	CustomizationManager.update_part(CharacterData.BodyPart.SHOES, style_id)


func _on_randomize_button_pressed() -> void:
	CustomizationManager.randomize_character()


func _on_reset_button_pressed() -> void:
	CustomizationManager.reset_character()


func _on_zoom_slider_value_changed(value: float) -> void:
	var camera = get_tree().get_first_node_in_group("main_camera")
	if camera:
		camera.set_zoom(value)
