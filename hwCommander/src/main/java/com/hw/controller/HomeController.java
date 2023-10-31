package com.hw.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hw.model.EstimateCalculationResultPrivateDetailVO;
import com.hw.model.EstimateCalculationResultPrivateMasterVO;
import com.hw.model.PartsMbHistoryVO;
import com.hw.model.PartsRamHistoryVO;
import com.hw.model.ProcessResourceMasterVO;
import com.hw.model.ProcessResourceTypeCodeInfoVO;
import com.hw.model.UserInfoVO;
import com.hw.service.ProcessResourceService;
import com.hw.service.ProductService;
//08.17 test
import com.hw.service.PartsService;
// end


@Controller
public class HomeController {
	
	private static final Logger LOGGER = LogManager.getLogger(HomeController.class);
	
	@Autowired
    private ProductService productService;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(@SessionAttribute(name = "loginUser", required = false)UserInfoVO userInfoVO, Model model) {
		
		model.addAttribute("loginUser", userInfoVO);
		
		return "main";
	}
	@RequestMapping(value = "/mainInfo.do", method = RequestMethod.GET)
	public String goMainInfo(@SessionAttribute(name = "loginUser", required = false)UserInfoVO userInfoVO, Model model) {
		
		model.addAttribute("loginUser", userInfoVO);
		
		return "mainInfo";
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
	
	@RequestMapping(value = "/productMall.do", method = RequestMethod.GET)
	public String goProductMall(Model model) {
		model.addAttribute("productMallList", productService.getProductMallList());
		return "productMall";
	}
	
	@RequestMapping(value = "/productMallDetail.do", method = RequestMethod.GET)
	public String goProductMallDetail(Model model, @RequestParam(value = "productId", required = true) String productId, @SessionAttribute(name = "loginUser", required = false)UserInfoVO userInfoVO) {
		model.addAttribute("loginUser", userInfoVO);
		model.addAttribute("productMaster", productService.getProductMasterById(productId));
		model.addAttribute("productDetail", productService.getProductDetailById(productId));
		return "productMallDetail";
	}
	
	@RequestMapping(value = "/userBanpumMall.do", method = RequestMethod.GET)
	public String goUserBanmpumMall(Model model) {
		model.addAttribute("banpumMasterList", productService.getBanpumMasterAllListByExposureYn("Y"));
		return "userBanpumMall";
	}
	@RequestMapping(value = "/userBanpumMallDetail.do", method = RequestMethod.GET)
	public String goUserBanmpumMallDetail(Model model, @RequestParam(value = "banpumMallId", required = true) String productId, @SessionAttribute(name = "loginUser", required = false)UserInfoVO userInfoVO) {
		model.addAttribute("loginUser", userInfoVO);
		model.addAttribute("banpumMaster", productService.getBanpumMasterById(productId));
		return "userBanpumMallDetail";
	}
	
	/*--------------------------------------------------
	 - private method
	*--------------------------------------------------*/
	private String userLoginCheck(HttpServletRequest request, Model model, String url) {
		HttpSession httpSession = request.getSession();
		
		UserInfoVO user = (UserInfoVO) httpSession.getAttribute("loginUser");
		
		if(null == user) {
			model.addAttribute("msg", "로그인 후에 견적산출이 가능합니다.");
			model.addAttribute("url", "/user/login.do");
			return "redirect";
		}else {
			return url;
		}
	}
	
}
