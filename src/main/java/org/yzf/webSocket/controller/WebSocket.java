package org.yzf.webSocket.controller;

import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class WebSocket {
	
	@RequestMapping(path = "index")
	public ModelAndView index(@RequestParam("nickname") String nickname,HttpSession session) {
		System.out.println("httpSession's id = " + session.getId());
		session.setAttribute("nickname", nickname);
		return new ModelAndView("index");
	}
	
	@RequestMapping(path = "webSocket")
	public ModelAndView webSocket(HttpSession session) {
		System.out.println(session.getId());
		return new ModelAndView("webSocket");
	}
}
