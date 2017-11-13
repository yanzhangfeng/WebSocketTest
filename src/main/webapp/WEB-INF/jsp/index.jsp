<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh">

<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="ie=edge" />
<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="../css/message.css" />
<script type="text/javascript" src="../bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="../js/jquery.min.js"></script>
<title>message</title>
</head>

<body>
	<div class="message">
	
		<div class="row">
			<div class="personal-message hidden-sm hidden-xs">
				<img class="head-portrait img-responsive" src="" alt="头像" />
				<h3>昵称</h3>
				<p>签名</p>
			</div>
		</div>
		
		<div class="row">
			<div class="pain hidden-sm hidden-xs"></div>
			<div class="chat-pain">
				<h2></h2>
				<button class="btn btn-default">关闭</button>
				<div class="chat pre-scrollable" id="chat"></div>
				<form class="form-group"
					onkeydown="if(event.keyCode==13)return false;">
					<input class="form-control" type="text" name="" id="message"
						value="" />
					<button id="send" type="button" class="btn btn-default">发送</button>
				</form>
			</div>
		</div>
		
	</div>
</body>
<script type="text/javascript">
	$(function() {
		$("#message").focus();
		$("#message").keydown(function() {
			if (event.keyCode == 13 && webSocket.readyState == 1) {
				sendMessage();
			}
		});
		//使滚动条一直保持在底部
		$(".chat").eq(0).scrollTop($(".chat")[0].scrollHeight);
		updateUrl("/chatHandler");
		console.log("webSocket's url : " + url);
		connect();
		$("#send").on("click", function() {
			if(webSocket.readyState == 1){
				sendMessage();				
			}
		});
	});

	var webSocket = null;
	var url = null;
	var message = null;

	function updateUrl(urlPath) {
		if (window.location.protocol == "http:") {
			url = "ws://" + window.location.host + urlPath;
		} else {
			url = "wss://" + window.location.host + urlPath;
		}
	}

	function getMessage() {
		message = $("#message").val();
		$("#message").val("");
		$("#message").focus();
	}

	function connect() {
		webSocket = new WebSocket(url);
		webSocket.onopen = function() {
			console.log("webSocket's readyState :" + webSocket.readyState);
		}
		
		webSocket.onmessage = function(receive) {
			console.log(receive);
			addOtherMessage("sdfs", "别人", receive.data);
		}
		
		webSocket.onclose = function() {
			console.log("webSocket has bean closed!!");
		}
		
		webSocket.onerror = function() {

		}
	}

	function sendMessage() {
		getMessage();
		addMyMessage("111", "我", message);
		console.log(webSocket.send(message));
	}

	function addMyMessage(headPortrait, nickname, message) {
		$my = $("<div class = 'my' id='my'></div>");
		$myHeadPortrait = $("<img class='head-portrait img-responsive' id='my-head-portrait' src='' alt='头像'/>");
		$myHeadPortrait.attr("src", "headPortrait");
		$myContext = $("<div class = 'context' id='my-context'></div>");
		$myNickname = $("<h4 class = 'my-nikcname' id='my-nikcname'></h4>");
		$myNickname.html(nickname);
		$myStatement = $("<div class = 'statement pull-right' id='my-statement'></div>");
		$myStatement.html(message);
		$my.append($myHeadPortrait);
		$my.append($myContext);
		$myContext.append($myNickname);
		$myContext.append($myStatement);
		$myContext.append("<div class = 'clear'></div>");
		$("#chat").append($my);
		$(".chat").eq(0).scrollTop($(".chat")[0].scrollHeight);
	}

	function addOtherMessage(headPortrait, nickname, message) {
		$other = $("<div class = 'other' id='other'></div>");
		$otherHeadPortrait = $("<img class='head-portrait img-responsive' id='other-head-portrait' src='' alt='头像'/>");
		$otherHeadPortrait.attr("src", "headPortrait");
		$otherContext = $("<div class = 'context' id='other-context'></div>");
		$otherNickname = $("<h4 class = 'other-nickname' id='other-nickname'></h4>");
		$otherNickname.html(nickname);
		$otherStatement = $("<div class = 'statement' id='other-statement'></div>");
		$otherStatement.html(message);
		$other.append($otherHeadPortrait);
		$other.append($otherContext);
		$otherContext.append($otherNickname);
		$otherContext.append($otherStatement);
		$otherContext.append("<div class = 'clear'></div>");
		$("#chat").append($other);
		$(".chat").eq(0).scrollTop($(".chat")[0].scrollHeight);
	}
</script>

</html>
