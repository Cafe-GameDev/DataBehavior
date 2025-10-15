@tool
extends EditorPlugin

const AUTOLOAD_NAME = "DataBehavior"
const AUTOLOAD_PATH = "res://addons/data_behavior/components/data_behavior.gd"
const GROUP_SCENE_PATH = "res://addons/data_behavior/panel/data_panel.tscn"
const BOTTOM_PANEL_SCENE_PATH = "res://addons/data_behavior/panel/data_bottom_panel.tscn"

var plugin_panel: ScrollContainer
var group_panel: VBoxContainer
var bottom_panel_instance: Control

const RESOURCE_EDITOR_AUTOLOAD_NAME = "ResourceEditor"
const RESOURCE_EDITOR_GITHUB_URL = "https://github.com/CafeGameDev/CafeEngine"

func _enable_plugin() -> void:
	if not ProjectSettings.has_setting("autoload/" + AUTOLOAD_NAME):
		add_autoload_singleton(AUTOLOAD_NAME, AUTOLOAD_PATH)

func _disable_plugin() -> void:
	if ProjectSettings.has_setting("autoload/" + AUTOLOAD_NAME):
		remove_autoload_singleton(AUTOLOAD_NAME)

func _enter_tree():
	if not ProjectSettings.has_setting("autoload/" + RESOURCE_EDITOR_AUTOLOAD_NAME):
		var error_message = "O plugin DataBehavior requer o plugin ResourceEditor para funcionar corretamente. " \
							+ "Por favor, certifique-se de que o ResourceEditor está instalado e configurado como um Autoload com o nome '" + RESOURCE_EDITOR_AUTOLOAD_NAME + "'. " \
							+ "Você pode encontrar o ResourceEditor em: " + RESOURCE_EDITOR_GITHUB_URL
		push_error(error_message)
		print("ERRO: " + error_message)
		return
	
	# Aguarda o CafeSidePanel ser instanciado pelo ResourceEditor
	await get_tree().create_timer(0.1).timeout
	while not ResourceEditor.CafeSidePanel:
		await get_tree().create_timer(0.1).timeout
	
	_create_plugin_panel()

	# Adiciona o painel inferior
	var bottom_panel_scene = load(BOTTOM_PANEL_SCENE_PATH)
	if bottom_panel_scene and bottom_panel_scene is PackedScene:
		bottom_panel_instance = bottom_panel_scene.instantiate()
		add_control_to_bottom_panel(bottom_panel_instance, "DataBehavior")
	else:
		push_error("Could not load DataBehavior bottom panel scene.")

	_register_custom_types()

func _exit_tree():
	if is_instance_valid(group_panel):
		group_panel.free()

	if is_instance_valid(bottom_panel_instance):
		remove_control_from_bottom_panel(bottom_panel_instance)
		bottom_panel_instance.free()
	
	_unregister_custom_types()

func _create_plugin_panel():
	plugin_panel = get_editor_interface().get_base_control().find_child("CafeSidePanel", true, false)
	if plugin_panel:
		_ensure_group("DataBehavior")
		return

func _ensure_group(group_name: String) -> VBoxContainer:
	if not plugin_panel:
		push_error("Main panel 'CafeEngine' reference not found.")
		return null

	var content_container = plugin_panel.get_node_or_null("VBoxContainer")
	if not content_container:
		push_error("The 'CafeEngine' panel does not contain the expected 'VBoxContainer'.")
		return null

	group_panel = content_container.find_child(group_name, false)
	if group_panel:
		const DATA_CONFIG_PATH = "res://addons/data_behavior/resources/data_config.tres"
		var data_config_res = ResourceLoader.load(DATA_CONFIG_PATH)
		if not data_config_res:
			data_config_res = preload("res://addons/data_behavior/scripts/data_config.gd").new()
			var dir = DATA_CONFIG_PATH.get_base_dir()
			if not DirAccess.dir_exists_absolute(ProjectSettings.globalize_path(dir)):
				DirAccess.make_dir_recursive_absolute(ProjectSettings.globalize_path(dir))
			
			var error = ResourceSaver.save(data_config_res, DATA_CONFIG_PATH)
			if error != OK:
				push_error("Failed to create and save a new DataConfig resource: %s" % error)
		group_panel.set_data_config(data_config_res)
		return group_panel

	var group_scene = load(GROUP_SCENE_PATH)
	if group_scene and group_scene is PackedScene:
		group_panel = group_scene.instantiate()
		content_container.add_child(group_panel)
		group_panel.name = group_name

		const DATA_CONFIG_PATH = "res://addons/data_behavior/resources/data_config.tres"
		var data_config_res = ResourceLoader.load(DATA_CONFIG_PATH)

		if not data_config_res:
			data_config_res = preload("res://addons/data_behavior/scripts/data_config.gd").new()
			var dir = DATA_CONFIG_PATH.get_base_dir()
			if not DirAccess.dir_exists_absolute(ProjectSettings.globalize_path(dir)):
				DirAccess.make_dir_recursive_absolute(ProjectSettings.globalize_path(dir))
			
			var error = ResourceSaver.save(data_config_res, DATA_CONFIG_PATH)
			if error != OK:
				push_error("Failed to create and save a new DataConfig resource: %s" % error)
		
		group_panel.set_data_config(data_config_res)

		return group_panel
	
	push_error("Could not load group scene: " + group_name)
	return null

func _register_custom_types():
	pass

func _unregister_custom_types():
	pass
