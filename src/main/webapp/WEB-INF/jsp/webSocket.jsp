<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>WebSocket</title>
<link rel="stylesheet" type="text/css" href="../../css/style.css" />
<script src="http://cdn.sockjs.org/sockjs-0.3.min.js"></script>
<script type="text/javascript" src="../../js/jquery.min.js"></script>
</head>
<body>
	<div>
		<div id="connect-container">
			<div>
				<button id="connect">Connect</button>
				<button id="disconnect" disabled="disabled">Disconnect</button>
			</div>

			<div>
				<textarea id="message" style="width: 350px">Here is a message!</textarea>
			</div>

			<div>
				<button id="echo" disabled="disabled">Echo message</button>
			</div>

		</div>
		<div id="console-container">
			<div id="console"></div>
		</div>
	</div>
</body>
<script type="text/javascript">
	$(function() {
		$("#connect").on("click",function(){
			connect();
		});
		$("#disconnect").on("click",function(){
			disconnect();
		});
		$("#echo").on("click",function(){
			echo();
		});
	});
	var ws = null;
	var url = null;
	var transports = [];

	function setConnected(connected) {
		document.getElementById('connect').disabled = connected;
		document.getElementById('disconnect').disabled = !connected;
		document.getElementById('echo').disabled = !connected;
	}

	function connect() {
		ws = new WebSocket("ws://localhost:8080/websocket");
		
		console.log(ws.readyState);//just send connection request,but not conneted.
		
		ws.onopen = function() {
			setConnected(true);
			log('Info: connection opened.');
			console.log(ws.readyState);//when "onopen" is touched,that means connected.
		};
		ws.onmessage = function(event) {
			log('Received: ' + event.data);
		};
		ws.onclose = function(event) {
			setConnected(false);
			log('Info: connection closed.');
		};
	}

	function disconnect() {
		if (ws != null) {
			ws.close();
			ws = null;
		}
		setConnected(false);
	}

	function echo() {
		if (ws != null) {
			var message = document.getElementById('message').value;
			log('Sent: ' + message);
			ws.send(message);
		} else {
			alert('connection not established, please connect.');
		}
	}

	function log(message) {
		var console = document.getElementById('console');
		var p = document.createElement('p');
		p.style.wordWrap = 'break-word';
		p.appendChild(document.createTextNode(message));
		console.appendChild(p);
		while (console.childNodes.length > 25) {
			console.removeChild(console.firstChild);
		}
		console.scrollTop = console.scrollHeight;
	}
</script>
</html>
