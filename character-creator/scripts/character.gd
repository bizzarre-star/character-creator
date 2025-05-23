extends CharacterBody3D

@onready var character_container: Node3D = $CharacterContainer
@onready var character_model: Node3D = $CharacterContainer/CharacterModel/char_create_base

var body_mesh: MeshInstance3D
var hair_mesh: MeshInstance3D
var shirt_mesh: MeshInstance3D
var jacket_mesh: MeshInstance3D
var pants_mesh: MeshInstance3D
var shoes_mesh: MeshInstance3D

const HAIR_MESH_NAME = "Short"

func _ready() -> void:
	_cache_materials()
	_connect_signals()
	_update_from_data()


func _cache_materials() -> void:
	for child in character_model.find_children("*", "MeshInstance3D"):
		var mesh := child as MeshInstance3D
		if not mesh or not mesh.mesh:
			continue
		
		var surface_count: int = mesh.mesh.get_surface_count()
		
		for surface_idx in range(surface_count):
			var material = mesh.get_active_material(surface_idx)
			if material and material is BaseMaterial3D:
				var unique_material := material.duplicate() as StandardMaterial3D
				
				match child.name:
					"Body":
						child.set_surface_override_material(surface_idx, unique_material)
						body_mesh = child
					HAIR_MESH_NAME:
						child.set_surface_override_material(surface_idx, unique_material)
						hair_mesh = child
					"Shirt1":
						child.set_surface_override_material(surface_idx, unique_material)
						shirt_mesh = child
					"Base_jacket":
						child.set_surface_override_material(surface_idx, unique_material)
						jacket_mesh = child
					"Pants1":
						child.set_surface_override_material(surface_idx, unique_material)
						pants_mesh = child
					"Base_shoes":
						child.set_surface_override_material(surface_idx, unique_material)
						shoes_mesh = child


func _connect_signals() -> void:
	if not CustomizationManager.color_updated.is_connected(_on_color_updated):
		CustomizationManager.color_updated.connect(_on_color_updated)
	if not CustomizationManager.customization_updated.is_connected(_on_customization_updated):
		CustomizationManager.customization_updated.connect(_on_customization_updated)


func _on_color_updated(part: CharacterData.BodyPart, color: Color) -> void:
	match part:
		CharacterData.BodyPart.BASE:
			_update_shirt_color(color)
		#CharacterData.BodyPart.HAIR:
			#_update_hair_color(color)
		CharacterData.BodyPart.SHIRT:
			_update_shirt_color(color)
		#CharacterData.BodyPart.JACKET:
			#_update_jacket_color(color)
		CharacterData.BodyPart.PANTS:
			_update_pants_color(color)
		#CharacterData.BodyPart.SHOES:
			#_update_shoes_color(color)


func _on_customization_updated() -> void:
	_update_from_data()


func _update_from_data() -> void:
	var data = CustomizationManager.character_data
	_update_skin_color(data.skin_color)
	#_update_hair_color(data.hair_color)
	_update_shirt_color(data.shirt_color)
	#_update_jacket_color(data.jacket_color)
	_update_pants_color(data.pants_color)
	#_update_shoes_color(data.shoes_color)
	#_update_hair_visibility(data.selected_hair)
	#_update_clothing_visiblity(data)


func _update_hair_visibility(selected_hair: CharacterData.Hairstyle) -> void:
	if hair_mesh:
		hair_mesh.visible = selected_hair == CharacterData.Hairstyle.Short


func _update_clothing_visiblity(data: CharacterData) -> void:
	if jacket_mesh:
		jacket_mesh.visible = data.jacket_visible
	
	if shoes_mesh:
		shoes_mesh.visible = data.shoes_visible


func _update_skin_color(color: Color) -> void:
	body_mesh.material_override.albedo_color = color


func _update_hair_color(color: Color) -> void:
	hair_mesh.material_override.albedo_color = color
	hair_mesh.material_override.roughness = 0.7
	hair_mesh.material_override.metallic = 0.3


func _update_shirt_color(color: Color) -> void:
	shirt_mesh.material_override.albedo_color = color


func _update_jacket_color(color: Color) -> void:
	jacket_mesh.material_override.albedo_color = color


func _update_pants_color(color: Color) -> void:
	pants_mesh.material_override.albedo_color = color


func _update_shoes_color(color: Color) -> void:
	shoes_mesh.material_override.albedo_color = color
