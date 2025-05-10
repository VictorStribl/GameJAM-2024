extends Control

@export var Enemy : Resource = null

@onready var actions_button = $ActionsPanel/Acoes/acoes as Button
@onready var itens_button = $ActionsPanel/Acoes/Itens as Button
@onready var fase_3 = load("res://Mundos/mundoDuque.tscn") as PackedScene
@onready var main_menu = load("res://MenuPrincipal/main_menu.tscn") as PackedScene

var current_enemy_health = 0
var current_enemy_max_health = 0

signal textbox_closed

func _ready():
	Enemy = ResourceLoader.load("res://Personagens/Scripts Enemies/EmpregadaB.tres")
	set_health($VBoxContainer/ProgressBar, Enemy.health, Enemy.max_health)
	current_enemy_health = Enemy.get("health")
	current_enemy_max_health = Enemy.get("max_health")

	$TextBox.hide()
	$ActionsPanel.hide()
	handle_connecting_signals()
	
	display_text("Empregada:\nQue susto! Eu não havia o visto aí.")
	await textbox_closed
	display_text("Empregada:\nVocê me parece um bobo da corte, vestido assim...")
	await textbox_closed
	display_text("Empregada:\nSabe o que eu adoro, quando os bobos que vem ao castelo\nfazem aquele barulho engraçado de fomfom, sempre me\nfaz cair na gargalhada.")
	await textbox_closed
	display_text("Empregada:\nSerá que você consegue fazer isso para mim?")
	await textbox_closed
	$ActionsPanel.show()

func set_health(Progress_Bar, health, max_health):
	Progress_Bar.value = health
	Progress_Bar.max_value = max_health
	Progress_Bar.get_node("Label").text = "%d/%d" % [health, max_health]

func _input(_event):
	if (Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)) and $TextBox.visible:
		$TextBox.hide()
		emit_signal("textbox_closed")

func display_text(text):
	$TextBox.show()
	$TextBox/Label.text = text

func _on_correr_pressed():
	display_text("Você fica com medo, e decide sair correndo.\nÉ uma pena, Voski.")
	await textbox_closed
	await get_tree().create_timer(.25).timeout
	get_tree().change_scene_to_file("res://MenuPrincipal/main_menu.tscn")

func handle_connecting_signals() -> void:
	pass

func _on_acoes_pressed():
	if not $Menu_acoes.visible:
		$Menu_acoes.visible = true
	else:
		$Menu_acoes.visible = false

func _on_itens_pressed():
	if not $Menu_itens.visible:
		$Menu_itens.visible = true
	else:
		$Menu_itens.visible = false

func _on_piadas_adultas_pressed():
	display_text("Você conta a piada mais adulta que conhece.")
	await textbox_closed
	display_text("%s:\nAh.. Sem graça.." % Enemy.name)
	if not $Guarda/Bravo_sprite.visible:
		$Guarda/Bravo_sprite.visible = true
		$Guarda/Normal_sprite.visible = false
	else:
		$Guarda/Bravo_sprite.visible = false
	await textbox_closed
	
	current_enemy_health = max(0, current_enemy_health - 1)
	set_health($VBoxContainer/ProgressBar, current_enemy_health, Enemy.get("max_health"))

	if current_enemy_health == 0:
		display_text("%s:\nEu esperava mais de você.\nSaia daqui antes que alguém o execute." % Enemy.name)
		if not $Guarda/Bravo_sprite.visible:
			$Guarda/Bravo_sprite.visible = true
			$Guarda/Normal_sprite.visible = false
		await textbox_closed
		await get_tree().create_timer(.25).timeout
		get_tree().change_scene_to_file("res://MenuPrincipal/main_menu.tscn")

func _on_buzina_pressed():
	display_text("Você toca a buzina.")
	await textbox_closed
	display_text("%s:\nHahaha, adorei." % Enemy.name)
	if not $Guarda/Feliz_sprite.visible:
		$Guarda/Feliz_sprite.visible = true
		$Guarda/Normal_sprite.visible = false
	else:
		$Guarda/Feliz_sprite.visible = false
	await textbox_closed
	
	current_enemy_health = max(0, current_enemy_health + 1)
	set_health($VBoxContainer/ProgressBar, current_enemy_health, Enemy.get("max_health"))

	if current_enemy_health == 2:
		display_text("%s:\nAh, você deveria ir ver o rei não é?\nBom, acho melhor você ir indo então." % Enemy.name)
		if not $Guarda/Feliz_sprite.visible:
			$Guarda/Feliz_sprite.visible = true
			$Guarda/Normal_sprite.visible = false
		await textbox_closed
		await get_tree().create_timer(.25).timeout
		get_tree().change_scene_to_file("res://Mundos/mundoDuque.tscn")

func _on_piadas_complexas_pressed():
	display_text("Você conta a melhor piada complexa que conhece.")
	await textbox_closed
	display_text("%s:\nChata." % Enemy.name)
	if not $Guarda/Bravo_sprite.visible:
		$Guarda/Bravo_sprite.visible = true
		$Guarda/Normal_sprite.visible = false
	else:
		$Guarda/Bravo_sprite.visible = false
	await textbox_closed
	
	current_enemy_health = max(0, current_enemy_health - 1)
	set_health($VBoxContainer/ProgressBar, current_enemy_health, Enemy.get("max_health"))
	
	if current_enemy_health == 0:
		display_text("%s:\nEu esperava mais de você.\nSaia daqui antes que alguém o execute." % Enemy.name)
		if not $Guarda/Bravo_sprite.visible:
			$Guarda/Bravo_sprite.visible = true
			$Guarda/Normal_sprite.visible = false
		await textbox_closed
		await get_tree().create_timer(.25).timeout
		get_tree().change_scene_to_file("res://MenuPrincipal/main_menu.tscn")

func _on_piadas_bobas_pressed():
	display_text("Você conta a melhor piada boba que conhece.")
	await textbox_closed
	display_text("%s:\nNão gostei." % Enemy.name)
	if not $Guarda/Bravo_sprite.visible:
		$Guarda/Bravo_sprite.visible = true
		$Guarda/Normal_sprite.visible = false
	else:
		$Guarda/Bravo_sprite.visible = false
	await textbox_closed
	
	current_enemy_health = max(0, current_enemy_health - 1)
	set_health($VBoxContainer/ProgressBar, current_enemy_health, Enemy.get("max_health"))
	
	if current_enemy_health == 0:
		display_text("%s:\nEu esperava mais de você.\nSaia daqui antes que alguém o execute." %Enemy.name)
		if not $Guarda/Bravo_sprite.visible:
			$Guarda/Bravo_sprite.visible = true
			$Guarda/Normal_sprite.visible = false
		await textbox_closed
		await get_tree().create_timer(.25).timeout
		get_tree().change_scene_to_file("res://MenuPrincipal/main_menu.tscn")

func _on_imitações_pressed():
	display_text("Você imita as reações da Empregada.")
	await textbox_closed
	display_text("%s:\nPreferia nunca ter visto isso." % Enemy.name)
	if not $Guarda/Bravo_sprite.visible:
		$Guarda/Bravo_sprite.visible = true
		$Guarda/Normal_sprite.visible = false
	else:
		$Guarda/Bravo_sprite.visible = false
	await textbox_closed
	
	current_enemy_health = max(0, current_enemy_health - 1)
	set_health($VBoxContainer/ProgressBar, current_enemy_health, Enemy.get("max_health"))
	
	if current_enemy_health == 0:
		display_text("%s:\nEu esperava mais de você.\nSaia daqui antes que alguém o execute." % Enemy.name)
		if not $Guarda/Bravo_sprite.visible:
			$Guarda/Bravo_sprite.visible = true
			$Guarda/Normal_sprite.visible = false
		await textbox_closed
		await get_tree().create_timer(.25).timeout
		get_tree().change_scene_to_file("res://MenuPrincipal/main_menu.tscn")

func _on_musica_pressed():
	display_text("Você pega um trompete e começa a \n tocar.")
	await textbox_closed
	display_text("%s:\nNunca gostei de música." % Enemy.name)
	if not $Guarda/Bravo_sprite.visible:
		$Guarda/Bravo_sprite.visible = true
		$Guarda/Normal_sprite.visible = false
	else:
		$Guarda/Bravo_sprite.visible = false
	await textbox_closed
	
	current_enemy_health = max(0, current_enemy_health - 1)
	set_health($VBoxContainer/ProgressBar, current_enemy_health, Enemy.get("max_health"))
	
	if current_enemy_health == 0:
		display_text("%s:\nEu esperava mais de você.\nSaia daqui antes que alguém o execute." % Enemy.name)
		if not $Guarda/Bravo_sprite.visible:
			$Guarda/Bravo_sprite.visible = true
			$Guarda/Normal_sprite.visible = false
		await textbox_closed
		await get_tree().create_timer(.25).timeout
		get_tree().change_scene_to_file("res://MenuPrincipal/main_menu.tscn")

func _on_fantoche_pressed():
	display_text("Você pega um fantoche e começa a interagir com a empregada \n como se fosse o fantache.")
	await textbox_closed
	display_text("%s:\nQue horror, tenho medo dessas coisas." % Enemy.name)
	if not $Guarda/Bravo_sprite.visible:
		$Guarda/Bravo_sprite.visible = true
		$Guarda/Normal_sprite.visible = false
	else:
		$Guarda/Bravo_sprite.visible = false
	await textbox_closed
	
	current_enemy_health = max(0, current_enemy_health - 1)
	set_health($VBoxContainer/ProgressBar, current_enemy_health, Enemy.get("max_health"))
	
	if current_enemy_health == 0:
		display_text("%s:\nEu esperava mais de você.\nSaia daqui antes que alguém o execute." % Enemy.name)
		if not $Guarda/Bravo_sprite.visible:
			$Guarda/Bravo_sprite.visible = true
			$Guarda/Normal_sprite.visible = false
		await textbox_closed
		await get_tree().create_timer(.25).timeout
		get_tree().change_scene_to_file("res://MenuPrincipal/main_menu.tscn")

func _on_pena_pressed():
	display_text("Você pega uma pena e vê a expressão da empregada mudar\n")
	await textbox_closed
	display_text("%s:\nNem pense nisso..." % Enemy.name)
	if not $Guarda/Bravo_sprite.visible:
		$Guarda/Bravo_sprite.visible = true
		$Guarda/Normal_sprite.visible = false
	else:
		$Guarda/Bravo_sprite.visible = false
	await textbox_closed
	
	current_enemy_health = max(0, current_enemy_health - 1)
	set_health($VBoxContainer/ProgressBar, current_enemy_health, Enemy.get("max_health"))
	
	if current_enemy_health == 0:
		display_text("%s:\nEu esperava mais de você.\nSaia daqui antes que alguém o execute." % Enemy.name)
		if not $Guarda/Bravo_sprite.visible:
			$Guarda/Bravo_sprite.visible = true
			$Guarda/Normal_sprite.visible = false
		await textbox_closed
		await get_tree().create_timer(.25).timeout
		get_tree().change_scene_to_file("res://MenuPrincipal/main_menu.tscn")

func _on_bichinho_de_balão_pressed():
	display_text("Você pega um bicho de balão e começa a brincar com a \n empregada.")
	await textbox_closed
	display_text("%s:\nUm balão?" % Enemy.name)
	if not $Guarda/Bravo_sprite.visible:
		$Guarda/Bravo_sprite.visible = true
		$Guarda/Normal_sprite.visible = false
	else:
		$Guarda/Bravo_sprite.visible = false
	await textbox_closed
	
	current_enemy_health = max(0, current_enemy_health - 1)
	set_health($VBoxContainer/ProgressBar, current_enemy_health, Enemy.get("max_health"))
	
	if current_enemy_health == 0:
		display_text("%s:\nEu esperava mais de você.\nSaia daqui antes que alguém o execute." % Enemy.name)
		if not $Guarda/Bravo_sprite.visible:
			$Guarda/Bravo_sprite.visible = true
			$Guarda/Normal_sprite.visible = false
		await textbox_closed
		await get_tree().create_timer(.25).timeout
		get_tree().change_scene_to_file("res://MenuPrincipal/main_menu.tscn")
