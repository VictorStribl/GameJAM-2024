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
	Enemy = ResourceLoader.load("res://Personagens/Scripts Enemies/ReiB.tres")
	set_health($VBoxContainer/ProgressBar, Enemy.health, Enemy.max_health)
	current_enemy_health = Enemy.get("health")
	current_enemy_max_health = Enemy.get("max_health")

	$TextBox.hide()
	$ActionsPanel.hide()
	handle_connecting_signals()
	
	display_text("Rei:\nOlá meu caro Voski, acredito que já seja de seu saber o\nporquê lhe convidei aqui.")
	await textbox_closed
	display_text("Rei:\nNos últimos tempos há tamanha dificuldade para encontrar\nbons Bobos da Corte. Aqueles que me façam ser agraciado\ncomo bem mereço ser. ")
	await textbox_closed
	display_text("Rei:\nO último paspalho a vir aqui não soube nem imitar um\nguarda espalhafatoso com precisão, acredita?")
	await textbox_closed
	display_text("Rei:\nHá muita dificuldade em encontrar aqueles que façam o\n mínimo como tocar belas músicas ou sequer fazer meu\n cão de caça Hefesto de balão.")
	await textbox_closed
	display_text("Rei:\nEntão após ouvir tantos elogios a seu respeito, gostaria de\nsua mais graciosa apresentação.")
	await textbox_closed
	display_text("Rei:\nMas saiba que não será fácil, não é qualquer coisa que me\nagrada dê o seu melhor!")
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
		display_text("%s:\nÉ.. Talvez tenha sido um erro te chamar\naté aqui." % Enemy.name)
		if not $Guarda/Bravo_sprite.visible:
			$Guarda/Bravo_sprite.visible = true
			$Guarda/Normal_sprite.visible = false
		else:
			$Guarda/Bravo_sprite.visible = false
		await textbox_closed
	
		current_enemy_health = max(0, current_enemy_health - 5)
		set_health($VBoxContainer/ProgressBar, current_enemy_health, Enemy.get("max_health"))

		if current_enemy_health == 0:
			display_text("%s:\nVá embora, e nunca mais volte, bobo." % Enemy.name)
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
		display_text("%s:\nPra que todo esse barulho?" % Enemy.name)
		if not $Guarda/Bravo_sprite.visible:
			$Guarda/Bravo_sprite.visible = true
			$Guarda/Normal_sprite.visible = false
		else:
			$Guarda/Bravo_sprite.visible = false
		await textbox_closed
	
		current_enemy_health = max(0, current_enemy_health - 5)
		set_health($VBoxContainer/ProgressBar, current_enemy_health, Enemy.get("max_health"))

		if current_enemy_health == 0:
			display_text("%s:\nVá embora, e nunca mais volte, bobo." % Enemy.name)
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
		display_text("%s:\nQue horror." % Enemy.name)
		if not $Guarda/Bravo_sprite.visible:
			$Guarda/Bravo_sprite.visible = true
			$Guarda/Normal_sprite.visible = false
		else:
			$Guarda/Bravo_sprite.visible = false
		await textbox_closed
	
		current_enemy_health = max(0, current_enemy_health - 5)
		set_health($VBoxContainer/ProgressBar, current_enemy_health, Enemy.get("max_health"))
	
		if current_enemy_health == 0:
			display_text("%s:\nVá embora, e nunca mais volte, bobo." % Enemy.name)
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
		display_text("%s:\nPéssimo." % Enemy.name)
		if not $Guarda/Bravo_sprite.visible:
			$Guarda/Bravo_sprite.visible = true
			$Guarda/Normal_sprite.visible = false
		else:
			$Guarda/Bravo_sprite.visible = false
		await textbox_closed
	
		current_enemy_health = max(0, current_enemy_health - 5)
		set_health($VBoxContainer/ProgressBar, current_enemy_health, Enemy.get("max_health"))
	
		if current_enemy_health == 0:
			display_text("%s:\nVá embora, e nunca mais volte, bobo." %Enemy.name)
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
	display_text("Você imita as reações do Rei")
	await textbox_closed
	display_text("%s:\nHahaha, belas imitações!" % Enemy.name)
	if not $Guarda/Feliz_sprite.visible:
		$Guarda/Feliz_sprite.visible = true
		$Guarda/Normal_sprite.visible = false
	await textbox_closed
	
	current_enemy_health = max(0, current_enemy_health + 1)
	set_health($VBoxContainer/ProgressBar, current_enemy_health, Enemy.get("max_health"))
	
	if current_enemy_health == 6:
		display_text("%s:\nMuito bem, Voski. Você realmente é muito bom no que faz." % Enemy.name)
		if not $Guarda/Feliz_sprite.visible:
				$Guarda/Feliz_sprite.visible = true
				$Guarda/Normal_sprite.visible = false
		await textbox_closed
		display_text("Este é o fim da demo, obrigado por jogar!")
		await textbox_closed
		await get_tree().create_timer(.50).timeout
		get_tree().change_scene_to_file("res://MenuPrincipal/main_menu.tscn")

var musica_count = 1
var max_musica_count = 1
func _on_musica_pressed():
	if musica_count > 0:
		display_text("Você pega um trompete e começa a tocar.")
		await textbox_closed
		display_text("%s:\nHahaha, isso que é música." % Enemy.name)
		if not $Guarda/Feliz_sprite.visible:
			$Guarda/Feliz_sprite.visible = true
			$Guarda/Normal_sprite.visible = false
		await textbox_closed
	
		current_enemy_health = max(0, current_enemy_health + 1)
		set_health($VBoxContainer/ProgressBar, current_enemy_health, Enemy.get("max_health"))
	
		if current_enemy_health == 6:
			display_text("%s:\nMuito bem, Voski. Você realmente é muito bom no que faz." % Enemy.name)
			if not $Guarda/Feliz_sprite.visible:
				$Guarda/Feliz_sprite.visible = true
				$Guarda/Normal_sprite.visible = false
			await textbox_closed
			display_text("Este é o fim da demo, obrigado por jogar!")
			await textbox_closed
			await get_tree().create_timer(.50).timeout
			get_tree().change_scene_to_packed(main_menu)
	
		musica_count -= 1
	else:
		display_text("É melhor eu não repetir nada.")

var fantoche_count = 1
var max_fantoche_count = 1
func _on_fantoche_pressed():
	if fantoche_count > 0:
		display_text("Você pega um fantoche e começa a falar com o Rei \n como se fosse o fantache")
		await textbox_closed
		display_text("%s:\nNunca gostei de fantoches." % Enemy.name)
		if not $Guarda/Feliz_sprite.visible:
			$Guarda/Feliz_sprite.visible = true
			$Guarda/Normal_sprite.visible = false
		else:
			$Guarda/Feliz_sprite.visible = false
		await textbox_closed
	
		current_enemy_health = max(0, current_enemy_health - 5)
		set_health($VBoxContainer/ProgressBar, current_enemy_health, Enemy.get("max_health"))
	
		if current_enemy_health == 0:
			display_text("%s:\nVá embora, e nunca mais volte, bobo." % Enemy.name)
			if not $Guarda/Bravo_sprite.visible:
				$Guarda/Bravo_sprite.visible = true
				$Guarda/Normal_sprite.visible = false
			await textbox_closed
			await get_tree().create_timer(.25).timeout
			get_tree().change_scene_to_file("res://MenuPrincipal/main_menu.tscn")
	
		fantoche_count -= 1
	else:
		display_text("É melhor eu não repetir a brincadeira mais de uma vez.")

var pena_count = 1
var max_pena_count = 1
func _on_pena_pressed():
	if pena_count > 0:
		display_text("Você pega uma pena, mas ao se aproximar do rei com \n ela, ele diz")
		await textbox_closed
		display_text("%s:\nBobo, é melhor você nem continuar." % Enemy.name)
		if not $Guarda/Feliz_sprite.visible:
			$Guarda/Feliz_sprite.visible = true
			$Guarda/Normal_sprite.visible = false
		else:
			$Guarda/Feliz_sprite.visible = false
		await textbox_closed
	
		current_enemy_health = max(0, current_enemy_health - 5)
		set_health($VBoxContainer/ProgressBar, current_enemy_health, Enemy.get("max_health"))
	
		if current_enemy_health == 0:
			display_text("%s:\nVá embora, e nunca mais volte, bobo." % Enemy.name)
			if not $Guarda/Bravo_sprite.visible:
				$Guarda/Bravo_sprite.visible = true
				$Guarda/Normal_sprite.visible = false
			await textbox_closed
			await get_tree().create_timer(.25).timeout
			get_tree().change_scene_to_packed(fase_5)
	
		pena_count -= 1
	else:
		display_text("É melhor eu não repetir a brincadeira mais de uma vez.")

var bichinho_de_balão_count = 1
var max_bichinho_de_balão_count = 1
func _on_bichinho_de_balão_pressed():
	if bichinho_de_balão_count > 0:
		display_text("Você pega um bicho de balão e começa a interagir com o \nRei")
		await textbox_closed
		display_text("%s:\nHahaha, muito bom!" % Enemy.name)
		if not $Guarda/Bravo_sprite.visible:
			$Guarda/Bravo_sprite.visible = true
			$Guarda/Normal_sprite.visible = false
		await textbox_closed
	
		current_enemy_health = max(0, current_enemy_health + 1)
		set_health($VBoxContainer/ProgressBar, current_enemy_health, Enemy.get("max_health"))
	
		if current_enemy_health == 6:
			display_text("%s:\nMuito bem, Voski. Você realmente é muito bom no que faz." % Enemy.name)
			if not $Guarda/Feliz_sprite.visible:
				$Guarda/Feliz_sprite.visible = true
				$Guarda/Normal_sprite.visible = false
			await textbox_closed
			display_text("Este é o fim da demo, obrigado por jogar!")
			await textbox_closed
			await get_tree().create_timer(.50).timeout
			get_tree().change_scene_to_file("res://MenuPrincipal/main_menu.tscn")
	
		bichinho_de_balão_count -= 1
	else:
		display_text("Melhor eu não repetir as coisas.")
