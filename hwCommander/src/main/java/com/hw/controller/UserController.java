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
import org.springframework.web.bind.annotation.ResponseBody;

import com.hw.model.OrderMasterVO;
import com.hw.model.UserInfoVO;
import com.hw.service.OrderService;
import com.hw.service.UserService;

@Controller
@RequestMapping(value="/user")
public class UserController {
	
	private static final Logger LOGGER = LogManager.getLogger(UserController.class);
	
	@Autowired
    private UserService userService;
	
	@Autowired
    private OrderService orderService;
	
	
	/*--------------------------------------------------
	 - 회원가입 및 로그인
	*--------------------------------------------------*/
	@RequestMapping(value = "/login.do", method = RequestMethod.GET)
	public String goLogin(Model model) {
		return "login";
	}

	@RequestMapping(value = "/loginLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public UserInfoVO loginLogic(HttpServletRequest request, UserInfoVO userInfoVO) {
		HttpSession httpSession = request.getSession();
		
		UserInfoVO resultVO = userService.getUserInfoByIdAndPw(userInfoVO);
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
		return userService.getIdDupliChkCount(id);
	}
	
	@RequestMapping(value = "/signUpLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer signUpLogic(UserInfoVO userInfoVO) {
		return userService.signUpLogic(userInfoVO);
	}
	
	@RequestMapping(value = "/mailConfirmLogic.do", method = RequestMethod.GET)
	public String mailConfirmLogic(UserInfoVO userInfoVO, Model model) {
		int result = userService.mailConfirmLogic(userInfoVO);
		model.addAttribute("result", result);
		return "mailConfirmPage";
	}
	
	// 아직 사용안함 인증메일 key값 재발급할때 쓸것.
	@RequestMapping(value = "/updateMailKey.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer updateMailKey(UserInfoVO userInfoVO) {
		return userService.updateMailKey(userInfoVO);
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
	
	/*--------------------------------------------------
	 - 주문내역
	*--------------------------------------------------*/
	@RequestMapping(value = "/orderList.do", method = RequestMethod.GET)
	public String goOrderList(HttpServletRequest request, Model model) {
		HttpSession httpSession = request.getSession();
		UserInfoVO user = (UserInfoVO) httpSession.getAttribute("loginUser");
		
		List<OrderMasterVO> orderMasterVOList = orderService.getOrderMasterListByOrdererUserId(user.getId());
		
		model.addAttribute("loginUser", user);
		model.addAttribute("orderMasterVOList", orderMasterVOList);
		
		return userLoginCheck(request, model, "userOrderList");
	}
	
	@RequestMapping(value = "/orderListDetail.do", method = RequestMethod.GET)
	public String goOrderListDetail(HttpServletRequest request
			, Model model
			, @RequestParam(value = "id", required = true) String id) {
		HttpSession httpSession = request.getSession();
		UserInfoVO user = (UserInfoVO) httpSession.getAttribute("loginUser");
		
		model.addAttribute("loginUser", user);
		model.addAttribute("orderMasterVO", orderService.getOrderMasterById(id));
		model.addAttribute("orderDetailVOList", orderService.getOrderDetailListById(id));
		
		return userLoginCheck(request, model, "userOrderListDetail");
	}
	
	@RequestMapping(value = "/orderVideoRequestToAdminLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer orderVideoRequestToAdminLogic(String id) {
		OrderMasterVO orderMasterVO = new OrderMasterVO();
		orderMasterVO.setId(id);
		orderMasterVO.setVideoRequestCd("02");
		return orderService.updateVideoRequestCd(orderMasterVO);
	}
	
	@RequestMapping(value = "/orderRefundRequestToAdminLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer orderRefundRequestToAdminLogic(String id) {
		OrderMasterVO orderMasterVO = new OrderMasterVO();
		orderMasterVO.setId(id);
		orderMasterVO.setOrderStateCd("09");
		return orderService.updateOrderStateCd(orderMasterVO);
	}
	
	@RequestMapping(value = "/orderUpdateRecipientHpNumber2Logic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer orderUpdateRecipientHpNumber2Logic(OrderMasterVO orderMasterVO) {
		return orderService.updateRecipientHpNumber2(orderMasterVO);
	}
	
	@RequestMapping(value = "/orderUpdateAddrsLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer orderUpdateAddrsLogic(OrderMasterVO orderMasterVO) {
		return orderService.updateAddrs(orderMasterVO);
	}
	
	@RequestMapping(value = "/orderUpdateOrderRequest.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer orderUpdateOrderRequest(OrderMasterVO orderMasterVO) {
		return orderService.updateOrderRequest(orderMasterVO);
	}
	
	@RequestMapping(value = "/orderUpdateDeliveryRequest.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer orderUpdateDeliveryRequest(OrderMasterVO orderMasterVO) {
		return orderService.updateDeliveryRequest(orderMasterVO);
	}
	
	/*--------------------------------------------------
	 - 주문진행현황
	*--------------------------------------------------*/
	@RequestMapping(value = "/orderProgressStatus.do", method = RequestMethod.GET)
	public String goOrderProgressStatus(HttpServletRequest request
			, Model model
			, @RequestParam(value = "id", required = true) String id) {
		
		HttpSession httpSession = request.getSession();
		UserInfoVO user = (UserInfoVO) httpSession.getAttribute("loginUser");
		
		model.addAttribute("loginUser", user);
		model.addAttribute("orderMasterVO", orderService.getOrderMasterById(id));
		model.addAttribute("orderDetailVOList", orderService.getOrderDetailListById(id));
		
		return userLoginCheck(request, model, "orderProgressStatus");
	}
	
	/*--------------------------------------------------
	 - private method
	*--------------------------------------------------*/
	private String userLoginCheck(HttpServletRequest request, Model model, String url) {
		HttpSession httpSession = request.getSession();
		
		UserInfoVO user = (UserInfoVO) httpSession.getAttribute("loginUser");
		
		if(null == user) {
			model.addAttribute("msg", "로그인 후에 이용 가능합니다.");
			model.addAttribute("url", "/user/login.do");
			return "redirect";
		}else {
			return url;
		}
	}
	
}
