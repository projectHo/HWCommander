package com.hw.controller;


import java.text.DecimalFormat;
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
import com.hw.model.BanpumMasterVO;
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
			, @RequestParam(value = "productIds", required = true) String productIds
			, @RequestParam(value = "orderQtys", required = true) String orderQtys
			, @RequestParam(value = "boxQtys", required = true) String boxQtys) {
		HttpSession httpSession = request.getSession();
		
		UserInfoVO loginUser = (UserInfoVO) httpSession.getAttribute("loginUser");

		// 23.11.04 쎄하다...ㅋㅋ 한 주문건 내에 여러 제품 구매 시 아래 컨트롤러 로직부터 화면까지 싹 바꿔야함.(23.10.26 시점 이전 롤백 및 추가구현 필요)
//		String[] productIdsArray = productIds.split(",");
//		String[] orderQtysArray = orderQtys.split(",");
//		String[] boxQtysArray = boxQtys.split(",");
		
		// 23.10.26 현재 비즈니스모델은 [견적산출결과에서 구매] or [반품몰에서 구매] 로만 구성되어있으며
		// 프로토타입의 장바구니(catr)가 폐기되면서 견적저장실(escas storage)이 그 자리를 대체하고
		// 견적저장실에서 구매로 이어지는 경우에는 [견적산출결과에서 구매] 방식을 채택하기에 분기를 변경함.
		// accessRoute == [견적산출결과에서 구매] == "direct"
		// accessRoute == [반품몰에서 구매] == "banpum"
		int productPrice = 0;
		int totOrderPrice = 0;
		String orderName = "";
		if("direct".equals(accessRoute)) {
			
			ProductMasterVO productMasterVO = new ProductMasterVO();
			productMasterVO = productService.getProductMasterById(productIds);
			
			List<ProductDetailVO> productDetailVOList = new ArrayList<>();
			productDetailVOList = productService.getProductDetailById(productIds);
			
			model.addAttribute("productMasterVO", productMasterVO);
			model.addAttribute("productDetailVOList", productDetailVOList);
			
			orderName = productMasterVO.getProductName();
			productPrice = productMasterVO.getProductPrice()*Integer.parseInt(orderQtys);
			
		}else if("banpum".equals(accessRoute)) {
			
			BanpumMasterVO banpumMasterVO = new BanpumMasterVO();
			banpumMasterVO = productService.getBanpumMasterById(productIds);
			
			model.addAttribute("banpumMasterVO", banpumMasterVO);
			
			orderName = banpumMasterVO.getBanpumName();
			productPrice = banpumMasterVO.getBanpumPrice()*Integer.parseInt(orderQtys);
			
		}
		
		int boxTotPrice = 5000*Integer.parseInt(boxQtys);
		totOrderPrice = productPrice+boxTotPrice;
		
		DecimalFormat df = new DecimalFormat("###,###");
		
		request.setAttribute("orderId", orderService.getOrderMasterVOUniqueId());
		request.setAttribute("totOrderPrice", totOrderPrice);
		
		model.addAttribute("accessRoute", accessRoute);
		model.addAttribute("loginUser", loginUser);
		model.addAttribute("orderName", orderName);
		model.addAttribute("orderQtys", orderQtys);
		model.addAttribute("boxQtys", boxQtys);
		model.addAttribute("boxTotPrice", boxTotPrice);
		model.addAttribute("totOrderPriceStr", df.format(totOrderPrice));
		model.addAttribute("boxTotPriceStr", df.format(boxTotPrice));
		
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
	
	@RequestMapping(value = "/orderDeleteLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer orderDeleteLogic(
			@RequestParam(value = "id", required = true) String id) {
		return orderService.orderAllDeleteLogic(id);
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