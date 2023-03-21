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
import com.hw.service.AdminService;

@Controller
@RequestMapping(value="/admin")
public class AdminController {
	
	private static final Logger LOGGER = LogManager.getLogger(AdminController.class);
	
	@Autowired
    private AdminService aserService;
	
	@RequestMapping(value = "/main.do", method = RequestMethod.GET)
	public String goAdminPageMain(Model model) {
		return "adminPageMain";
	}
	
	@RequestMapping(value = "/gpuManagement.do", method = RequestMethod.GET)
	public String goGpuManagement(Model model) {
		return "gpuManagement";
	}
	
	@RequestMapping(value = "/cpuManagement.do", method = RequestMethod.GET)
	public String goCpuManagement(Model model) {
		return "cpuManagement";
	}
	
	@RequestMapping(value = "/mbManagement.do", method = RequestMethod.GET)
	public String goMbManagement(Model model) {
		return "mbManagement";
	}
	
	@RequestMapping(value = "/ramManagement.do", method = RequestMethod.GET)
	public String goRamManagement(Model model) {
		return "ramManagement";
	}
	
	@RequestMapping(value = "/psuManagement.do", method = RequestMethod.GET)
	public String goPsuManagement(Model model) {
		return "psuManagement";
	}

	@RequestMapping(value = "/caseManagement.do", method = RequestMethod.GET)
	public String goCaseManagement(Model model) {
		return "caseManagement";
	}
	
	@RequestMapping(value = "/coolerManagement.do", method = RequestMethod.GET)
	public String goCoolerManagement(Model model) {
		return "coolerManagement";
	}
	
	@RequestMapping(value = "/hddManagement.do", method = RequestMethod.GET)
	public String goHddManagement(Model model) {
		return "hddManagement";
	}
	
	@RequestMapping(value = "/ssdManagement.do", method = RequestMethod.GET)
	public String goSsdManagement(Model model) {
		return "ssdManagement";
	}
	
	@RequestMapping(value = "/sfManagement.do", method = RequestMethod.GET)
	public String goSfManagement(Model model) {
		return "sfManagement";
	}
	
	@RequestMapping(value = "/loginLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public UserInfoVO loginLogic(HttpServletRequest request, UserInfoVO userInfoVO) {
		HttpSession httpSession = request.getSession();
		
		UserInfoVO resultVO = aserService.getUserInfoByIdAndPw(userInfoVO);
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
		return aserService.getIdDupliChkCount(id);
	}
	
	@RequestMapping(value = "/signUpLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer signUpLogic(UserInfoVO userInfoVO) {
		return aserService.signUpLogic(userInfoVO);
	}
	
	@RequestMapping(value = "/mailConfirmLogic.do", method = RequestMethod.GET)
	public String mailConfirmLogic(UserInfoVO userInfoVO, Model model) {
		int result = aserService.mailConfirmLogic(userInfoVO);
		model.addAttribute("result", result);
		return "mailConfirmPage";
	}
	
	// 아직 사용안함 인증메일 key값 재발급할때 쓸것.
	@RequestMapping(value = "/updateMailKey.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer updateMailKey(UserInfoVO userInfoVO) {
		return aserService.updateMailKey(userInfoVO);
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
