extends Node2D

var catAlive = false
var countSeconds = 10
var countMilliseconds = 60

func start() -> void:
	$"Result-alive".visible = false
	$"Result-dead".visible = false
	$"Box-closed".visible = true
	$"Box-open".visible = false
	
	countSeconds = 10
	countMilliseconds = 60
	
	$stateInterval.start()
	$countInterval.start()

func stop() -> void:
	$stateInterval.stop()
	$countInterval.stop()
	catAlive = bool(randi_range(0, 1))
	updateState()
	$"Box-closed".visible = false
	$"Box-open".visible = true
	$"Result-alive".visible = catAlive
	$"Result-dead".visible = !catAlive

func reset() -> void:
	$stateInterval.stop()
	$countInterval.stop()
	start()

func updateState() -> void:
	$"Indicator/State-alive".visible = catAlive
	$"Indicator/State-dead".visible = !catAlive

func stateInterval() -> void:
	catAlive = !catAlive
	updateState()

func countInterval() -> void:
	if countSeconds == 0:
		stop()
		$Timer.text = '00:00'
		return
	countMilliseconds = countMilliseconds - 1
	
	if countMilliseconds == 0:
		countSeconds = countSeconds - 1
		countMilliseconds = 60
	
	$Timer.text = "%02d:%02d" % [countSeconds, countMilliseconds]
