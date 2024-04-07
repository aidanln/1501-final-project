extends Control

@onready var inventory: Inventory = preload("res://inventory/playerinventory.tres")
@onready var inventorySlots: Array = $NinePatchRect/GridContainer.get_children()

func update() :
	for i in range(min(inventory.inventory.size(), inventorySlots.size())) :
		inventorySlots[i].update(inventory.inventory[i])

func _ready():
	inventory.updated.connect(update)
	update()
