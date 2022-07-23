extends Node

# A simpler global signal system is to just use a "signalton"
# (an autoload file that contains all signals, so they can be connected
# and emitted globally)
# for ex. GlobalSignals.emit_signal("my_signal", "any args")
# and GlobalSignals.connect("my_signal", self, "func")
signal press_button
signal player_changed
signal place_player
signal start_ui_timer

# Followed tutorial here for creating a global signal system:
# https://joshanthony.info/2021/08/09/creating-a-global-signal-system-in-godot/
# Didn't understand it well enough (not enough time), so I commented out the code

"""
# Keeps track of what signal emitters have been registered.
var _emitters = {}

# Register a signal with GlobalSignal, making it accessible to global listeners.
func add_emitter(signal_name: String, emitter: Object) -> void:
	var emitter_data = { 'object': emitter, 'object_id': emitter.get_instance_id() }
	if not _emitters.has(signal_name):
		_emitters[signal_name] = {}
	_emitters[signal_name][emitter.get_instance_id()] = emitter_data

# Keeps track of what listeners have been registered.
var _listeners = {}

# Adds a new global listener.
func add_listener(signal_name: String, listener: Object, method: String) -> void:
	var listener_data = { 'object': listener, 'object_id': listener.get_instance_id(), 'method': method }
	if not _listeners.has(signal_name):
		_listeners[signal_name] = {}
	_listeners[signal_name][listener.get_instance_id()] = listener_data

# Connect an emitter to existing listeners of its signal.
func _connect_emitter_to_listeners(signal_name: String, emitter: Object) -> void:
	var listeners = _listeners[signal_name]
	for listener in listeners.values():
		emitter.connect(signal_name, listener.object, listener.method)


# Connect a listener to emitters who emit the signal it's listening for.
func _connect_listener_to_emitters(signal_name: String, listener: Object, method: String) -> void:
	var emitters = _emitters[signal_name]
	for emitter in emitters.values():
		emitter.object.connect(signal_name, listener, method)
"""
