extends Label

func _ready() -> void:
	$"..".value_changed.connect(_on_change)
	text = str($"..".value).trim_suffix(".0")

func _on_change(value: float):
	text = str(value).trim_suffix(".0")
