package org.yzf.webSocket.controller;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import org.yzf.webSocket.entity.Sessions;

public class ChatHandler extends TextWebSocketHandler {

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("connected");
		
		String nickname = (String)session.getAttributes().get("nickname");
		Sessions.addSession(nickname, session);
		handleTextMessage(session, new TextMessage("你好"));
		super.afterConnectionEstablished(session);
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		super.handleTextMessage(session, message);
		TextMessage returnMessage = new TextMessage(message.getPayload());
		session.sendMessage(returnMessage);
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		session.close();
		super.afterConnectionClosed(session, status);
	}

}
