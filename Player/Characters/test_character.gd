class_name TestCharacter
extends Character

func light_punch() -> void:
	print("lp")
func heavy_punch() -> void:
	print("hp")
func light_kick() -> void:
	print("lk")
func heavy_kick() -> void:
	print("hk")

func crouch_punch() -> void:
	print("cp")
func crouch_kick() -> void:
	print("ck")
func grab() -> void:
	print("grab")

func super_light_punch() -> void:
	print("super lp")
func super_heavy_punch() -> void:
	pass
func super_light_kick() -> void:
	pass
func super_heavy_kick() -> void:
	pass
