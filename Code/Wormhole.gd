extends Area2D


@export var target : Node2D

func PortalActive(area : Area2D):
	var ship = area.get_parent()
	ship.global_position = target.global_position + ship.vel.normalized() * 50.0
