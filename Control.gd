extends Control

var port = "0"

func _ready():
	check_server_count()
#	OS.execute("notepad",['-port:' + port,'-auto:1'],false)
#	get_node("HTTPReqCount").request("http://2D.MONSTER/count.php")

var timer = 0.00

func _physics_process(delta):
	timer += delta
	
	if timer > 1 and int(timer) % 15 == 0:
		timer = 0
		check_server_count()

func check_server_count():
	get_node("HTTPReqCount").request("http://2D.MONSTER/count.php")

func _on_HTTPReqCount_request_completed(result, response_code, headers, body):
	if (int(body.get_string_from_utf8()) < 1): # NUMBER OF SERVERS TO STAND BY
		get_node("HTTPReqPort").request("http://2D.MONSTER/port.php")
		print("LOADiNG A SERVER...")
	else:
		print("MAX SERVER COUNT!")

func do_stuff():
	get_tree().quit()

func _on_HTTPReqPort_request_completed(result, response_code, headers, body):
	port = body.get_string_from_utf8()
	get_node("HTTPReqPort_Up").request("http://2D.MONSTER/port_up.php")
	OS.execute("rnbhost",["-port:" + port,"-auto:1"],false)
	print("LOADiNG A SERVER PORT...")
