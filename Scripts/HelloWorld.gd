extends Panel

# Store the default text in a global variable, at the highest scope usable by all functions.
#var default_text = " "
#func _ready():
#	var label = get_node("Label")
#	default_text = label.text
## When the ready() function is called, the default text of the Label will be saved into our default_text variable  by copying the value of the text set in the editor. This is done with the assignment operator, =.
#func _on_Button_pressed():
#	var label = get_node("Label")
#	if label.text == "Hello World!":
#
## Set the current text of the Label to be the same as the default text that we copied in the ready() function.
#		label.text = default_text
#	else:
#		label.text = "Hello World!"
#
#
