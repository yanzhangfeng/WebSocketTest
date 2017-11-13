package org.yzf.webSocket.interceptor;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

/**
 * this interceptor is used to do some operation before handshake or after
 * handshake, if you want to do something before or after handshake.
 * 
 * @author zhangfengyan
 *
 */
public class HandShakeInterceptor extends HttpSessionHandshakeInterceptor {

	@Override
	public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler,
			Map<String, Object> attributes) throws Exception {
		// you can do something before handshake at this place.
		System.out.println("before handshake");
		return super.beforeHandshake(request, response, wsHandler, attributes);

	}

	@Override
	public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler,
			Exception ex) {
		// you can do something after handshake at this place.
		System.out.println("after handshake");

		HttpServletRequest rq = ((ServletServerHttpRequest) request).getServletRequest();
		HttpSession session = rq.getSession();
		super.afterHandshake(request, response, wsHandler, ex);

	}

}
