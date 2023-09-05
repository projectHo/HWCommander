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
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hw.model.OrderDetailVO;
import com.hw.model.OrderMasterVO;
import com.hw.model.ProductDetailVO;
import com.hw.model.ProductMasterVO;
import com.hw.model.UserInfoVO;
import com.hw.service.OrderService;
import com.hw.service.ProductService;

@Controller
@RequestMapping(value="/order")
public class OrderController {
	
	private static final Logger LOGGER = LogManager.getLogger(OrderController.class);
	
	@Autowired
    private OrderService orderService;
	
	@Autowired
    private ProductService productService;
	
	@RequestMapping(value = "/sheet.do", method = RequestMethod.GET)
	public String goSheet(Model model
			, HttpServletRequest request
			, @RequestParam(value = "accessRoute", required = true) String accessRoute
			, @RequestParam(value = "productIds", required = true) String productIds) {
		HttpSession httpSession = request.getSession();
		
		UserInfoVO loginUser = (UserInfoVO) httpSession.getAttribute("loginUser");
		
		if("direct".equals(accessRoute)) {
			// order 1건에 product 1건이라는 전제임. product가 여러건일 때(ex. cart)아래 else에서 처리
			List<ProductMasterVO> productMasterVOList = new ArrayList<>();
			productMasterVOList.add(productService.getProductMasterById(productIds));
			
			List<List<ProductDetailVO>> productDetailVOListList = new ArrayList<>();
			productDetailVOListList.add(productService.getProductDetailById(productIds));
			
			model.addAttribute("productList", productMasterVOList);
			model.addAttribute("productDetailList", productDetailVOListList);
			model.addAttribute("orderName", productMasterVOList.get(0).getProductName());
			
			request.setAttribute("productPrice", productMasterVOList.get(0).getProductPrice());
		}else {
			// todo wonho Cart
			// jsp idlist.join(", ")
			model.addAttribute("productList", null);
			model.addAttribute("orderName", "~~~외 ~~건");
		}
		
		request.setAttribute("orderId", orderService.getOrderMasterVOUniqueId());
		model.addAttribute("loginUser", loginUser);
		
		if(null == loginUser) {
			return "redirect:/user/login.do";
		}else {
			return "orderSheet";
		}
	}
	
	@RequestMapping(value = "/orderRegistLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer orderRegistLogic(
			@RequestParam(value = "orderMasterVO", required = true) String orderMasterVOString
			, @RequestParam(value = "orderDetailVOList", required = true) String orderDetailVOListString) throws JsonMappingException, JsonProcessingException {
		
		OrderMasterVO orderMasterVO = new OrderMasterVO();
		List<OrderDetailVO> orderDetailVOList = new ArrayList<>();
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		orderMasterVO = objectMapper.readValue(orderMasterVOString, OrderMasterVO.class);
		orderDetailVOList = objectMapper.readValue(orderDetailVOListString, new TypeReference<List<OrderDetailVO>>() {});
		
		return orderService.orderRegistLogic(orderMasterVO, orderDetailVOList);
	}
	
	@RequestMapping(value = "/inicisPayReturn.do", method = RequestMethod.POST)
	public String inicisPayReturn(Model model) {
		return "orderReturn";
	}
	
	@RequestMapping(value = "/inicisPayComplete.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer inicisPayComplete(@RequestParam(value = "id", required = true) String id) {
		return orderService.inicisPayComplete(id);
	}
	
	@RequestMapping(value = "/inicisPayClose.do", method = RequestMethod.GET)
	public String inicisPayClose(Model model, @RequestParam(value = "id", required = true) String id) {
		orderService.orderAllDeleteLogic(id);
		return "INIstdpay/close";
	}
	
	/*--------------------------------------------------
	 - 진행현황페이지(제품 공수 중)
	*--------------------------------------------------*/
	@RequestMapping(value = "/orderStateCd03Page.do", method = RequestMethod.GET)
	public String goOrderStateCd03Page(HttpServletRequest request
			, Model model
			, @RequestParam(value = "id", required = true) String id) {
		
		HttpSession httpSession = request.getSession();
		UserInfoVO user = (UserInfoVO) httpSession.getAttribute("loginUser");
		
		model.addAttribute("loginUser", user);
		model.addAttribute("orderMasterVO", orderService.getOrderMasterById(id));
		model.addAttribute("orderDetailVOList", orderService.getOrderDetailListById(id));
		
		return userLoginCheck(request, model, "orderStateCd03Page");
	}
	
	/*--------------------------------------------------
	 - 진행현황페이지(조립 중)
	*--------------------------------------------------*/
	@RequestMapping(value = "/orderStateCd04Page.do", method = RequestMethod.GET)
	public String goOrderStateCd04Page(HttpServletRequest request
			, Model model
			, @RequestParam(value = "id", required = true) String id) {
		
		HttpSession httpSession = request.getSession();
		UserInfoVO user = (UserInfoVO) httpSession.getAttribute("loginUser");
		
		model.addAttribute("loginUser", user);
		model.addAttribute("orderMasterVO", orderService.getOrderMasterById(id));
		model.addAttribute("orderDetailVOList", orderService.getOrderDetailListById(id));
		
		return userLoginCheck(request, model, "orderStateCd04Page");
	}
	
	/*--------------------------------------------------
	 - 진행현황페이지(시스템 구성 중)
	*--------------------------------------------------*/
	@RequestMapping(value = "/orderStateCd05Page.do", method = RequestMethod.GET)
	public String goOrderStateCd05Page(HttpServletRequest request
			, Model model
			, @RequestParam(value = "id", required = true) String id) {
		
		HttpSession httpSession = request.getSession();
		UserInfoVO user = (UserInfoVO) httpSession.getAttribute("loginUser");
		
		model.addAttribute("loginUser", user);
		model.addAttribute("orderMasterVO", orderService.getOrderMasterById(id));
		model.addAttribute("orderDetailVOList", orderService.getOrderDetailListById(id));
		
		return userLoginCheck(request, model, "orderStateCd05Page");
	}
	
	/*--------------------------------------------------
	 - private method
	*--------------------------------------------------*/
	private String userLoginCheck(HttpServletRequest request, Model model, String url) {
		HttpSession httpSession = request.getSession();
		
		UserInfoVO user = (UserInfoVO) httpSession.getAttribute("loginUser");
		
		if(null == user) {
			model.addAttribute("msg", "로그인 후에 이용이 가능합니다.");
			model.addAttribute("url", "/user/login.do");
			return "redirect";
		}else {
			return url;
		}
	}
}