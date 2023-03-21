package com.hw.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hw.model.UserInfoVO;
import com.hw.service.PartsService;
import com.hw.service.UserService;

@Controller
@RequestMapping(value="/parts")
public class PartsController {
	
	private static final Logger LOGGER = LogManager.getLogger(PartsController.class);
	
	@Autowired
    private PartsService partsService;
	
	@RequestMapping(value = "/login.do", method = RequestMethod.GET)
	public String goLogin(Model model) {
		return "login";
	}
	
	@RequestMapping(value = "/loginLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public UserInfoVO loginLogic(HttpServletRequest request, UserInfoVO userInfoVO) {
		HttpSession httpSession = request.getSession();
		
		
		return null;
	}
	
	
}
