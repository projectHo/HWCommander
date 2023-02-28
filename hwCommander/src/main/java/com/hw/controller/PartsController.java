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
		
		UserInfoVO resultVO = partsService.getUserInfoByIdAndPw(userInfoVO);
		if(resultVO.getMailConfirm().equals("Y")) {
			httpSession.setAttribute("loginUser", resultVO);
		}else {
			httpSession.removeAttribute("loginUser"); 
			httpSession.invalidate(); // 세션 전체 제거, 무효화 
		}
		System.out.println("===========================");
		System.out.println("===========================");
		System.out.println("id : "+userInfoVO.getId());
		System.out.println("pw : "+userInfoVO.getPw());
		System.out.println("===========================");
		System.out.println("===========================");
		
		return resultVO;
	}
	
	@RequestMapping(value = "/signUp.do", method = RequestMethod.GET)
	public String goSignUp(Model model) {
		return "signUp";
	}
	
	@RequestMapping(value = "/idDupliChk.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer idDupliChk(String id) {
		return partsService.getIdDupliChkCount(id);
	}
	
	@RequestMapping(value = "/signUpLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer signUpLogic(UserInfoVO userInfoVO) {
		return partsService.signUpLogic(userInfoVO);
	}
	
	@RequestMapping(value = "/mailConfirmLogic.do", method = RequestMethod.GET)
	public String mailConfirmLogic(UserInfoVO userInfoVO, Model model) {
		int result = partsService.mailConfirmLogic(userInfoVO);
		model.addAttribute("result", result);
		return "mailConfirmPage";
	}
	
	// 아직 사용안함 인증메일 key값 재발급할때 쓸것.
	@RequestMapping(value = "/updateMailKey.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer updateMailKey(UserInfoVO userInfoVO) {
		return partsService.updateMailKey(userInfoVO);
	}
	
	@RequestMapping(value = "/logoutLogic.do", method = RequestMethod.GET)
	public String logoutLogic(HttpServletRequest request, Model model) {
		HttpSession httpSession = request.getSession(false);
		if(httpSession != null) {
			httpSession.removeAttribute("loginUser"); 
			httpSession.invalidate(); 
		}
		model.addAttribute("loginUser", null);
		return "redirect:/";
	}
	
}
