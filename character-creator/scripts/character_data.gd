class_name CharacterData extends Resource

enum BodyPart {BASE, HAIR, SHIRT, JACKET, PANTS, SHOES}
enum Hairstyle {Bald = 0, Short = 1, Long = 2}

@export var skin_color: Color = Color(1.0, 1.0, 1.0, 1.0)
@export var hair_color: Color = Color(.5, .5, .5, 1.0)
@export var selected_hair: Hairstyle = Hairstyle.Bald
@export var shirt_color: Color = Color(0, 0, 0, 1.0)
@export var jacket_color: Color = Color(0, 0, 0, 1.0)
@export var pants_color: Color = Color(0, 0, 0, 1.0)
@export var shoes_color: Color = Color(0, 0, 0, 1.0)
@export var jacket_visible: bool = false
@export var shoes_visible: bool = false
