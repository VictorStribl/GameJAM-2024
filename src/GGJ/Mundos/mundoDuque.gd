extends Control

@export var Enemy : Resource = null

@onready var actions_button = $ActionsPanel/Acoes/acoes as Button
@onready var itens_button = $ActionsPanel/Acoes/Itens as Button
@onready var fase_4 = load("res://Mundos/mundoPrincipe.tscn") as PackedScene
@onready var main_menu = load("res://MenuPrincipal/main_menu.tscn") as PackedScene

var current_enemy_health = 0
var current_enemy_max_health = 0

signal textbox_closed

func _ready():
	Enemy = ResourceLoader.load("res://Personagens/Scripts Enemies/DuqueB.tres")
	set_health($VBoxContainer/ProgressBar, Enemy.health, Enemy.max_health)
	current_enemy_health = Enemy.get("health")
	current_enemy_max_health = Enemy.get("max_health")

	$TextBox.hide()
	$ActionsPanel.hide()
	handle_connecting_signals()
	
	display_text("Duque:\nHmn Voski eu suponho... me parece que você está atrasado.")
	await textbox_closed
	display_text("Duque:\nNão entendo a serventia de seu cargo, acredito que\nqualquer um é capaz de fazer o outro rir.")
	await textbox_closed
	display_text("Duque:\nApesar de alguns colegas me dizerem que tenho riso frouxo,\nmas eu não acredito que seja minha culpa ser agraciado\npor qualquer comédia apresentada.")
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

var piadas_adultas_count = 1
var max_piadas_adultas_count = 1
func _on_piadas_adultas_pressed():
	if piadas_adultas_count > 0:
		display_text("Você conta a piada mais adulta que conhece.")
		await textbox_closed
		display_text("%s:\nHahaha, é disso que estou falando." % Enemy.name)
		if not $Guarda/Feliz_sprite.visible:
			$Guarda/Feliz_sprite.visible = true
			$Guarda/Normal_sprite.visible = false
		await textbox_closed
	
		current_enemy_health = max(0, current_enemy_health + 1)
		set_health($VBoxContainer/ProgressBar, current_enemy_health, Enemy.get("max_health"))

		if current_enemy_health == 4:
			display_text("%s:\nParece que o rei soube fazer sua escolha. Pode ir." % Enemy.name)
			if not $Guarda/Feliz_sprite.visible:
				$Guarda/Feliz_sprite.visible = true
				$Guarda/Normal_sprite.visible = false
			await textbox_closed
			await get_tree().create_timer(.25).timeout
			get_tree().change_scene_to_file("res://Mundos/mundoPrincipe.tscn")
	
		piadas_adultas_count -= 1
	else:
		display_text("Você já contou todas as piadas adultas possíveis.")

var buzina_count = 1
var max_buzina_count = 1
func _on_buzina_pressed():
	if buzina_count > 0:
		display_text("Você toca a buzina.")
		await textbox_closed
		display_text("%s:\nEra suposto isso ter graça?" % Enemy.name)
		if not $Guarda/Bravo_sprite.visible:
			$Guarda/Bravo_sprite.visible = true
			$Guarda/Normal_sprite.visible = false
		else:
			$Guarda/Bravo_sprite.visible = false
		await textbox_closed
	
		current_enemy_health = max(0, current_enemy_health - 3)
		set_health($VBoxContainer/ProgressBar, current_enemy_health, Enemy.get("max_health"))

		if current_enemy_health == 0:
			display_text("%s:\nEu esperava mais de você.\nSaia daqui antes que eu peça te executarem." % Enemy.name)
			if not $Guarda/Bravo_sprite.visible:
				$Guarda/Bravo_sprite.visible = true
				$Guarda/Normal_sprite.visible = false
			await textbox_closed
			await get_tree().create_timer(.25).timeout
			get_tree().change_scene_to_file("res://MenuPrincipal/main_menu.tscn")
	
		buzina_count -= 1
	else:
		display_text("É melhor eu não usar isso mais de uma vez.")

var piadas_complexas_count = 1
var max_piadas_complexas_count = 1
func _on_piadas_complexas_pressed():
	if piadas_complexas_count > 0:
		display_text("Você conta a melhor piada complexa que conhece.")
		await textbox_closed
		display_text("%s:\nHahaha, muito boa!" % Enemy.name)
		if not $Guarda/Feliz_sprite.visible:
			$Guarda/Feliz_sprite.visible = true
			$Guarda/Normal_sprite.visible = false
		await textbox_closed
	
		current_enemy_health = max(0, current_enemy_health + 1)
		set_health($VBoxContainer/ProgressBar, current_enemy_health, Enemy.get("max_health"))
	
		if current_enemy_health == 4:
			display_text("%s:\nParece que o rei soube fazer sua escolha. Pode ir." % Enemy.name)
			if not $Guarda/Feliz_sprite.visible:
				$Guarda/Feliz_sprite.visible = true
				$Guarda/Normal_sprite.visible = false
			await textbox_closed
			await get_tree().create_timer(.25).timeout
			get_tree().change_scene_to_file("res://Mundos/mundoPrincipe.tscn")
	
		piadas_complexas_count -= 1
	else:
		display_text("Você já usou todas as piadas complexas possíveis.")

var piadas_bobas_count = 1
var max_piadas_bobas_count = 1
func _on_piadas_bobas_pressed():
	if piadas_bobas_count > 0:
		display_text("Você conta a melhor piada boba que conhece.")
		await textbox_closed
		display_text("%s:\nHahaha, as mais simples são sempre as melhores." % Enemy.name)
		if not $Guarda/Feliz_sprite.visible:
			$Guarda/Feliz_sprite.visible = true
			$Guarda/Normal_sprite.visible = false
		await textbox_closed
	
		current_enemy_health = max(0, current_enemy_health + 1)
		set_health($VBoxContainer/ProgressBar, current_enemy_health, Enemy.get("max_health"))
	
		if current_enemy_health == 4:
			display_text("%s:\nParece que o rei soube fazer sua escolha. Pode ir." %Enemy.name)
			if not $Guarda/Feliz_sprite.visible:
				$Guarda/Feliz_sprite.visible = true
				$Guarda/Normal_sprite.visible = false
			await textbox_closed
			await get_tree().create_timer(.25).timeout
			get_tree().change_scene_to_file("res://Mundos/mundoPrincipe.tscn")
	
		piadas_bobas_count -= 1
	else:
		display_text("Você já usou todas as piadas bobas possíveis.")

func _on_imitações_pressed():
	display_text("Você imita as reações do Duque")
	await textbox_closed
	display_text("%s:\nNunca mais se atreva a fazer isso." % Enemy.name)
	if not $Guarda/Bravo_sprite.visible:
		$Guarda/Bravo_sprite.visible = true
		$Guarda/Normal_sprite.visible = false
	else:
		$Guarda/Bravo_sprite.visible = false
	await textbox_closed
	
	current_enemy_health = max(0, current_enemy_health - 3)
	set_health($VBoxContainer/ProgressBar, current_enemy_health, Enemy.get("max_health"))
	
	if current_enemy_health == 0:
		display_text("%s:\nEu esperava mais de você.\nSaia daqui antes que eu peça te executarem." % Enemy.name)
		if not $Guarda/Bravo_sprite.visible:
			$Guarda/Bravo_sprite.visible = true
			$Guarda/Normal_sprite.visible = false
		await textbox_closed
		await get_tree().create_timer(.25).timeout
		get_tree().change_scene_to_file("res://MenuPrincipal/main_menu.tscn")

func _on_musica_pressed():
	display_text("Você pega um trompete que tinha guardado e começa a \n tocar.")
	await textbox_closed
	display_text("%s:\nSeria melhor nem ter começado." % Enemy.name)
	if not $Guarda/Bravo_sprite.visible:
		$Guarda/Bravo_sprite.visible = true
		$Guarda/Normal_sprite.visible = false
	else:
		$Guarda/Bravo_sprite.visible = false
	await textbox_closed
	
	current_enemy_health = max(0, current_enemy_health - 3)
	set_health($VBoxContainer/ProgressBar, current_enemy_health, Enemy.get("max_health"))
	
	if current_enemy_health == 0:
		display_text("%s:\nEu esperava mais de você.\nSaia daqui antes que eu peça te executarem." % Enemy.name)
		if not $Guarda/Bravo_sprite.visible:
			$Guarda/Bravo_sprite.visible = true
			$Guarda/Normal_sprite.visible = false
		await textbox_closed
		await get_tree().create_timer(.25).timeout
		get_tree().change_scene_to_file("res://MenuPrincipal/main_menu.tscn")

func _on_fantoche_pressed():
	display_text("Você pega um fantoche e começa a falar com o Duque \n como se fosse o fantache.")
	await textbox_closed
	display_text("%s:\nFantoches são tão sem graça." % Enemy.name)
	if not $Guarda/Bravo_sprite.visible:
		$Guarda/Bravo_sprite.visible = true
		$Guarda/Normal_sprite.visible = false
	else:
		$Guarda/Bravo_sprite.visible = false
	await textbox_closed
	
	current_enemy_health = max(0, current_enemy_health - 3)
	set_health($VBoxContainer/ProgressBar, current_enemy_health, Enemy.get("max_health"))
	
	if current_enemy_health == 0:
		display_text("%s:\nEu esperava mais de você.\nSaia daqui antes que eu peça te executarem." % Enemy.name)
		if not $Guarda/Bravo_sprite.visible:
			$Guarda/Bravo_sprite.visible = true
			$Guarda/Normal_sprite.visible = false
		await textbox_closed
		await get_tree().create_timer(.25).timeout
		get_tree().change_scene_to_file("res://MenuPrincipal/main_menu.tscn")

func _on_pena_pressed():
	display_text("Você pega uma pena e começa a passar no nariz do Duque com \n ela")
	await textbox_closed
	display_text("%s:\nNunca mais encoste nada em mim, palhaço." % Enemy.name)
	if not $Guarda/Bravo_sprite.visible:
		$Guarda/Bravo_sprite.visible = true
		$Guarda/Normal_sprite.visible = false
	else:
		$Guarda/Bravo_sprite.visible = false
	await textbox_closed
	
	current_enemy_health = max(0, current_enemy_health - 3)
	set_health($VBoxContainer/ProgressBar, current_enemy_health, Enemy.get("max_health"))
	
	if current_enemy_health == 0:
		display_text("%s:\nEu esperava mais de você.\nSaia daqui antes que eu peça te executarem." % Enemy.name)
		if not $Guarda/Bravo_sprite.visible:
			$Guarda/Bravo_sprite.visible = true
			$Guarda/Normal_sprite.visible = false
		await textbox_closed
		await get_tree().create_timer(.25).timeout
		get_tree().change_scene_to_file("res://MenuPrincipal/main_menu.tscn")

func _on_bichinho_de_balão_pressed():
	display_text("Você pega um bicho de balão e começa a brincar com o \nDuque.")
	await textbox_closed
	display_text("%s:\nMinha vontade é de estourar este balão." % Enemy.name)
	if not $Guarda/Bravo_sprite.visible:
		$Guarda/Bravo_sprite.visible = true
		$Guarda/Normal_sprite.visible = false
	else:
		$Guarda/Bravo_sprite.visible = false
	await textbox_closed
	
	current_enemy_health = max(0, current_enemy_health - 3)
	set_health($VBoxContainer/ProgressBar, current_enemy_health, Enemy.get("max_health"))
	
	if current_enemy_health == 0:
		display_text("%s:\nEu esperava mais de você.\nSaia daqui antes que eu peça te executarem." % Enemy.name)
		if not $Guarda/Bravo_sprite.visible:
			$Guarda/Bravo_sprite.visible = true
			$Guarda/Normal_sprite.visible = false
		await textbox_closed
		await get_tree().create_timer(.25).timeout
		get_tree().change_scene_to_file("res://MenuPrincipal/main_menu.tscn")
