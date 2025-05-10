extends Control

@export var Enemy : Resource = null

@onready var actions_button = $ActionsPanel/Acoes/acoes as Button
@onready var itens_button = $ActionsPanel/Acoes/Itens as Button
@onready var fase_5 = load("res://Mundos/mundoRei.tscn") as PackedScene
@onready var main_menu = load("res://MenuPrincipal/main_menu.tscn") as PackedScene

var current_enemy_health = 0
var current_enemy_max_health = 0

signal textbox_closed

func _ready():
	Enemy = ResourceLoader.load("res://Personagens/Scripts Enemies/PrincipeB.tres")
	set_health($VBoxContainer/ProgressBar, Enemy.health, Enemy.max_health)
	current_enemy_health = Enemy.get("health")
	current_enemy_max_health = Enemy.get("max_health")

	$TextBox.hide()
	$ActionsPanel.hide()
	handle_connecting_signals()
	
	display_text("Principe:\nOlhe!! Um bobo da corte!! Eu adoro bobos da corte.")
	await textbox_closed
	display_text("Principe:\nMeu pai sempre fala que acha difícil achar um bom bobo\nda corte...")
	await textbox_closed
	display_text("Principe:\nEu não acho que deve ser tão difícil assim, é só eles usarem\naquele bonequinhos de fantoche que eu já dou muita\nrisada!")
	await textbox_closed
	display_text("Principe:\nFora que mamãe me faz rir muito com cócegas. Mas ela diz\nque eu já estou grandinho de mais para tudo isso.")
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
		display_text("%s:\nEu não entendi..." % Enemy.name)
		if not $Guarda/Bravo_sprite.visible:
			$Guarda/Bravo_sprite.visible = true
			$Guarda/Normal_sprite.visible = false
		else:
			$Guarda/Bravo_sprite.visible = false
		await textbox_closed
	
		current_enemy_health = max(0, current_enemy_health - 3)
		set_health($VBoxContainer/ProgressBar, current_enemy_health, Enemy.get("max_health"))

		if current_enemy_health == 0:
			display_text("%s:\nVá embora, meu papai não quer falar com você.\nSe você não for, eu chamo os guardas." % Enemy.name)
			if not $Guarda/Bravo_sprite.visible:
				$Guarda/Bravo_sprite.visible = true
				$Guarda/Normal_sprite.visible = false
			await textbox_closed
			await get_tree().create_timer(.25).timeout
			get_tree().change_scene_to_file("res://MenuPrincipal/main_menu.tscn")
	
		piadas_adultas_count -= 1
	else:
		display_text("Você já contou todas as piadas adultas possíveis.")

var buzina_count = 1
var max_buzina_count = 1
func _on_buzina_pressed():
	if buzina_count > 0:
		display_text("Você toca a buzina.")
		await textbox_closed
		display_text("%s:\nHm. Não gosto de barulhos altos." % Enemy.name)
		if not $Guarda/Bravo_sprite.visible:
			$Guarda/Bravo_sprite.visible = true
			$Guarda/Normal_sprite.visible = false
		else:
			$Guarda/Bravo_sprite.visible = false
		await textbox_closed
	
		current_enemy_health = max(0, current_enemy_health - 3)
		set_health($VBoxContainer/ProgressBar, current_enemy_health, Enemy.get("max_health"))

		if current_enemy_health == 0:
			display_text("%s:\nVá embora, meu papai não quer falar com você.\nSe você não for, eu chamo os guardas." % Enemy.name)
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
		display_text("%s:\nNão entendi..." % Enemy.name)
		if not $Guarda/Bravo_sprite.visible:
			$Guarda/Bravo_sprite.visible = true
			$Guarda/Normal_sprite.visible = false
		else:
			$Guarda/Bravo_sprite.visible = false
		await textbox_closed
		current_enemy_health = max(0, current_enemy_health - 3)
		set_health($VBoxContainer/ProgressBar, current_enemy_health, Enemy.get("max_health"))
	
		if current_enemy_health == 0:
			display_text("%s:\nVá embora, meu papai não quer falar com você.\nSe você não for, eu chamo os guardas." % Enemy.name)
			if not $Guarda/Bravo_sprite.visible:
				$Guarda/Bravo_sprite.visible = true
				$Guarda/Normal_sprite.visible = false
			await textbox_closed
			await get_tree().create_timer(.25).timeout
			get_tree().change_scene_to_file("res://MenuPrincipal/main_menu.tscn")
	
		piadas_complexas_count -= 1
	else:
		display_text("Você já usou todas as piadas complexas possíveis.")

var piadas_bobas_count = 1
var max_piadas_bobas_count = 1
func _on_piadas_bobas_pressed():
	if piadas_bobas_count > 0:
		display_text("Você conta a melhor piada boba que conhece.")
		await textbox_closed
		display_text("%s:\nEu não sou mais criança..." % Enemy.name)
		if not $Guarda/Bravo_sprite.visible:
			$Guarda/Bravo_sprite.visible = true
			$Guarda/Normal_sprite.visible = false
		else:
			$Guarda/Bravo_sprite.visible = false
		await textbox_closed
	
		current_enemy_health = max(0, current_enemy_health - 3)
		set_health($VBoxContainer/ProgressBar, current_enemy_health, Enemy.get("max_health"))
	
		if current_enemy_health == 0:
			display_text("%s:\nVá embora, meu papai não quer falar com você.\nSe você não for, eu chamo os guardas." %Enemy.name)
			if not $Guarda/Bravo_sprite.visible:
				$Guarda/Bravo_sprite.visible = true
				$Guarda/Normal_sprite.visible = false
			await textbox_closed
			await get_tree().create_timer(.25).timeout
			get_tree().change_scene_to_file("res://MenuPrincipal/main_menu.tscn")
	
		piadas_bobas_count -= 1
	else:
		display_text("Você já usou todas as piadas bobas possíveis.")

func _on_imitações_pressed():
	display_text("Você imita as reações do Principe.")
	await textbox_closed
	display_text("%s:\nPara de me imitar." % Enemy.name)
	if not $Guarda/Bravo_sprite.visible:
		$Guarda/Bravo_sprite.visible = true
		$Guarda/Normal_sprite.visible = false
	else:
		$Guarda/Bravo_sprite.visible = false
	await textbox_closed
	
	current_enemy_health = max(0, current_enemy_health - 3)
	set_health($VBoxContainer/ProgressBar, current_enemy_health, Enemy.get("max_health"))
	
	if current_enemy_health == 0:
		display_text("%s:\nVá embora, meu papai não quer falar com você.\nSe você não for, eu chamo os guardas." % Enemy.name)
		if not $Guarda/Bravo_sprite.visible:
			$Guarda/Bravo_sprite.visible = true
			$Guarda/Normal_sprite.visible = false
		await textbox_closed
		await get_tree().create_timer(.25).timeout
		get_tree().change_scene_to_file("res://MenuPrincipal/main_menu.tscn")

func _on_musica_pressed():
	display_text("Você pega um trompete que tinha guardado e começa a \n tocar.")
	await textbox_closed
	display_text("%s:\nEu nunca entendi música direito." % Enemy.name)
	if not $Guarda/Bravo_sprite.visible:
		$Guarda/Bravo_sprite.visible = true
		$Guarda/Normal_sprite.visible = false
	else:
		$Guarda/Bravo_sprite.visible = false
	await textbox_closed
	
	current_enemy_health = max(0, current_enemy_health - 3)
	set_health($VBoxContainer/ProgressBar, current_enemy_health, Enemy.get("max_health"))
	
	if current_enemy_health == 0:
		display_text("%s:\nVá embora, meu papai não quer falar com você.\nSe você não for, eu chamo os guardas." % Enemy.name)
		if not $Guarda/Bravo_sprite.visible:
			$Guarda/Bravo_sprite.visible = true
			$Guarda/Normal_sprite.visible = false
		await textbox_closed
		await get_tree().create_timer(.25).timeout
		get_tree().change_scene_to_file("res://MenuPrincipal/main_menu.tscn")

var fantoche_count = 1
var max_fantoche_count = 1
func _on_fantoche_pressed():
	if fantoche_count > 0:
		display_text("Você pega um fantoche e começa a falar com o principe \ncomo se fosse o fantache")
		await textbox_closed
		display_text("%s:\nHahaha, adoro fantoches." % Enemy.name)
		if not $Guarda/Feliz_sprite.visible:
			$Guarda/Feliz_sprite.visible = true
			$Guarda/Normal_sprite.visible = false
		await textbox_closed
	
		current_enemy_health = max(0, current_enemy_health + 1)
		set_health($VBoxContainer/ProgressBar, current_enemy_health, Enemy.get("max_health"))
	
		if current_enemy_health == 4:
			display_text("%s:\nAh, meu papai queria falar com você, é melhor você ir." % Enemy.name)
			if not $Guarda/Feliz_sprite.visible:
				$Guarda/Feliz_sprite.visible = true
				$Guarda/Normal_sprite.visible = false
			await textbox_closed
			await get_tree().create_timer(.25).timeout
			get_tree().change_scene_to_file("res://Mundos/mundoRei.tscn")
	
		fantoche_count -= 1
	else:
		display_text("É melhor eu não repetir a brincadeira mais de uma vez.")

var pena_count = 1
var max_pena_count = 1
func _on_pena_pressed():
	if pena_count > 0:
		display_text("Você pega uma pena e começa a tentar fazer o principe\nrir com ela.")
		await textbox_closed
		display_text("%s:\nHahaha, faz cócegas." % Enemy.name)
		if not $Guarda/Feliz_sprite.visible:
			$Guarda/Feliz_sprite.visible = true
			$Guarda/Normal_sprite.visible = false
		await textbox_closed
	
		current_enemy_health = max(0, current_enemy_health + 1)
		set_health($VBoxContainer/ProgressBar, current_enemy_health, Enemy.get("max_health"))
	
		if current_enemy_health == 4:
			display_text("%s:\nAh, meu papai queria falar com você, é melhor você ir." % Enemy.name)
			if not $Guarda/Feliz_sprite.visible:
				$Guarda/Feliz_sprite.visible = true
				$Guarda/Normal_sprite.visible = false
			await textbox_closed
			await get_tree().create_timer(.25).timeout
			get_tree().change_scene_to_file("res://Mundos/mundoRei.tscn")
	
		pena_count -= 1
	else:
		display_text("É melhor eu não repetir a brincadeira mais de uma vez.")

func _on_bichinho_de_balão_pressed():
	display_text("Você pega um bicho de balão e começa a brincar com o \nPrincipe.")
	await textbox_closed
	display_text("%s:\nHm.. Eu gosto mais de fantoches." % Enemy.name)
	if not $Guarda/Bravo_sprite.visible:
		$Guarda/Bravo_sprite.visible = true
		$Guarda/Normal_sprite.visible = false
	else:
		$Guarda/Bravo_sprite.visible = false
	await textbox_closed
	
	current_enemy_health = max(0, current_enemy_health - 3)
	set_health($VBoxContainer/ProgressBar, current_enemy_health, Enemy.get("max_health"))
	
	if current_enemy_health == 0:
		display_text("%s:\nVá embora, meu papai não quer falar com você.\nSe você não for, eu chamo os guardas." % Enemy.name)
		if not $Guarda/Bravo_sprite.visible:
			$Guarda/Bravo_sprite.visible = true
			$Guarda/Normal_sprite.visible = false
		await textbox_closed
		await get_tree().create_timer(.25).timeout
		get_tree().change_scene_to_file("res://MenuPrincipal/main_menu.tscn")
