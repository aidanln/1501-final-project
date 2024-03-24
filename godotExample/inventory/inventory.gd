extends Resource

class_name Inventory

@export var inventory: Array

signal updated

func add(item) :
    for i in range(inventory.size()):
        if !inventory[i]:
            inventory[i] = item
            break
    updated.emit()