package org.yzf.webSocket.entity;

import java.util.HashMap;
import java.util.Map;

import org.springframework.web.socket.WebSocketSession;

public class Sessions {
	public static Map<String,WebSocketSession> sessions = new HashMap<>();
	
	public static void addSession(String nickname,WebSocketSession session) {
		sessions.put(nickname, session);
	}
}
