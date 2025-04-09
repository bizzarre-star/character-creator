extends Node

signal color_updated(part: CharacterData.BodyPart, color: Color)
signal customization_updated

var character_data: CharacterData


func _ready() -> void:
	character_data = CharacterData.new()


func update_color(part: CharacterData.BodyPart, color: Color) -> void:
	match part:
		CharacterData.BodyPart.BASE:
			character_data.skin_color = color
		CharacterData.BodyPart.HAIR:
			character_data.hair_color = color
		CharacterData.BodyPart.SHIRT:
			character_data.shirt_color = color
		CharacterData.BodyPart.JACKET:
			character_data.jacket_color = color
		CharacterData.BodyPart.PANTS:
			character_data.pants_color = color
		CharacterData.BodyPart.SHOES:
			character_data.shoes_color = color
	color_updated.emit(part, color)
	customization_updated.emit()


func reset_character() -> void:
	character_data = CharacterData.new()
	customization_updated.emit()


func randomize_character() -> void:
	character_data.skin_color = Color(randf_range(0.5, 1.0), 
	randf_range(0.4, 0.9), randf_range(0.3, 0.8), 1.0)
	
	character_data.hair_color = Color(randf_range(0, 1.0), 
	randf_range(0, 1.0), randf_range(0, 1.0), 1.0)
	
	character_data.shirt_color = Color(randf_range(0, 1.0), 
	randf_range(0, 1.0), randf_range(0, 1.0), 1.0)
	
	character_data.jacket_color = Color(randf_range(0, 1.0), 
	randf_range(0, 1.0), randf_range(0, 1.0), 1.0)
	
	character_data.pants_color = Color(randf_range(0, 1.0), 
	randf_range(0, 1.0), randf_range(0, 1.0), 1.0)
	
	character_data.shoes_color = Color(randf_range(0, 1.0), 
	randf_range(0, 1.0), randf_range(0, 1.0), 1.0)
	
	character_data.selected_hair = randi_range(0, 
	CharacterData.Hairstyle.values().size())
	
	character_data.jacket_visible = false
	character_data.shoes_visible = false
	
	customization_updated.emit()


func update_part(part: CharacterData.BodyPart, index: int) -> void:
	match part:
		CharacterData.BodyPart.HAIR:
			character_data.selected_hair = index
	
	customization_updated.emit()
