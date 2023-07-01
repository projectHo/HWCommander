package com.hw.controller;

import java.util.ArrayList;
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
import com.hw.model.ProcessResourceMasterVO;
import com.hw.model.ProcessResourceTypeCodeInfoVO;
import com.hw.model.UserInfoVO;
import com.hw.service.ProcessResourceService;
import com.hw.service.ProductService;


@Controller
public class HomeController {
	
	private static final Logger LOGGER = LogManager.getLogger(HomeController.class);
	
	@Autowired
    private ProductService productService;
	
	@Autowired
    private ProcessResourceService processResourceService;
	
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
	
	@RequestMapping(value = "/eventMall.do", method = RequestMethod.GET)
	public String goEventMall(Model model) {
		model.addAttribute("eventMallList", productService.getEventMallList());
		return "eventMall";
	}
	
	@RequestMapping(value = "/eventMallDetail.do", method = RequestMethod.GET)
	public String goEventMallDetail(Model model, @RequestParam(value = "productId", required = true) String productId, @SessionAttribute(name = "loginUser", required = false)UserInfoVO userInfoVO) {
		model.addAttribute("loginUser", userInfoVO);
		model.addAttribute("productMaster", productService.getProductMasterById(productId));
		model.addAttribute("productDetail", productService.getProductDetailById(productId));
		return "eventMallDetail";
	}
	
	
	/*--------------------------------------------------
	 - 견적산출
	*--------------------------------------------------*/
	@RequestMapping(value = "/estimateCalculationOne.do", method = RequestMethod.GET)
	public String goEstimateCalculationOne(HttpServletRequest request, Model model) {
		return userLoginCheck(request, model, "estimateCalculationOne");
	}
	
	@RequestMapping(value = "/estimateCalculationTwo.do", method = RequestMethod.GET)
	public String goEstimateCalculationTwo(HttpServletRequest request, Model model) {
		List<ProcessResourceTypeCodeInfoVO> processResourceTypeCodeInfoVOList = processResourceService.getProcessResourceTypeCodeInfoByUseYn("Y");
		List<ProcessResourceMasterVO> processResourceMasterVOList = processResourceService.getProcessResourceMasterAllList();
		
		ObjectMapper mapper = new ObjectMapper();
		String processResourceMasterVOListJSON = "";
		String processResourceTypeCodeInfoVOListJSON = "";
		try {
			processResourceTypeCodeInfoVOListJSON = mapper.writeValueAsString(processResourceTypeCodeInfoVOList);
			processResourceMasterVOListJSON = mapper.writeValueAsString(processResourceMasterVOList);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		model.addAttribute("processResourceMasterVOList", processResourceMasterVOListJSON);
		model.addAttribute("processResourceTypeCodeInfoVOList", processResourceTypeCodeInfoVOListJSON);
		
		return userLoginCheck(request, model, "estimateCalculationTwo");
	}
	
	@RequestMapping(value = "/estimateCalculationThree.do", method = RequestMethod.GET)
	public String goEstimateCalculationThree(HttpServletRequest request, Model model) {
		return userLoginCheck(request, model, "estimateCalculationThree");
	}
	
	@RequestMapping(value = "/estimateCalculationFour.do", method = RequestMethod.GET)
	public String goEstimateCalculationFour(HttpServletRequest request, Model model) {
		return userLoginCheck(request, model, "estimateCalculationFour");
	}
	
	@RequestMapping(value = "/estimateCalculationFive.do", method = RequestMethod.GET)
	public String goEstimateCalculationFive(HttpServletRequest request, Model model) {
		return userLoginCheck(request, model, "estimateCalculationFive");
	}
	
	@RequestMapping(value = "/estimateCalculationSix.do", method = RequestMethod.GET)
	public String goEstimateCalculationSix(HttpServletRequest request, Model model) {
		return userLoginCheck(request, model, "estimateCalculationSix");
	}
	
	@RequestMapping(value = "/estimateCalculationSeven.do", method = RequestMethod.GET)
	public String goEstimateCalculationSeven(HttpServletRequest request, Model model) {
		return userLoginCheck(request, model, "estimateCalculationSeven");
	}
	
	@RequestMapping(value = "/estimateCalculationEight.do", method = RequestMethod.GET)
	public String goEstimateCalculationEight(HttpServletRequest request, Model model) {
		return userLoginCheck(request, model, "estimateCalculationEight");
	}
	
	@RequestMapping(value = "/estimateCalculationNine.do", method = RequestMethod.GET)
	public String goEstimateCalculationNine(HttpServletRequest request, Model model) {
		return userLoginCheck(request, model, "estimateCalculationNine");
	}
	
	@RequestMapping(value = "/estimateCalculationTen.do", method = RequestMethod.GET)
	public String goEstimateCalculationTen(HttpServletRequest request, Model model) {
		return userLoginCheck(request, model, "estimateCalculationTen");
	}
	
	@RequestMapping(value = "/estimateCalculationResult.do", method = RequestMethod.GET)
	public String goEstimateCalculationResult(HttpServletRequest request, Model model) {
		return userLoginCheck(request, model, "estimateCalculationResult");
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
