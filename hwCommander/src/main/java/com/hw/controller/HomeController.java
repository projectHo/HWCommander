package com.hw.controller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.hw.model.UserInfoVO;


@Controller
public class HomeController {
	
	private static final Logger LOGGER = LogManager.getLogger(HomeController.class);
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(@SessionAttribute(name = "loginUser", required = false)UserInfoVO userInfoVO, Model model) {
		
		model.addAttribute("loginUser", userInfoVO);
		
		return "main";
	}
	
	@RequestMapping(value = "/aboutUs.do", method = RequestMethod.GET)
	public String goAboutUs(Model model) {
		return "aboutUs";
	}
	
	@RequestMapping(value = "/termsOfService.do", method = RequestMethod.GET)
	public String goTermsOfService(Model model) {
		return "termsOfService";
	}
	
	@RequestMapping(value = "/personalInformationProcessingPolicy.do", method = RequestMethod.GET)
	public String goPersonalInformationProcessingPolicy(Model model) {
		return "personalInformationProcessingPolicy";
	}
}
