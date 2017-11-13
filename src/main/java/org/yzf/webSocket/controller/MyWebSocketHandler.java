package org.yzf.webSocket.controller;

import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class MyWebSocketHandler extends TextWebSocketHandler {

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		super.afterConnectionEstablished(session);
		System.out.println("connected");
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		//super.handleTextMessage(session, message);
		TextMessage returnMessage = new TextMessage(message.getPayload());  
        session.sendMessage(returnMessage);
	}

	
}
