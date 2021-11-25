extends Label

var life = Resources.life

func _ready():
	self.text = str("x", life)
