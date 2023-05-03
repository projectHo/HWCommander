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
			List<ProductMasterVO> productMasterVOList = new ArrayList<>();
			productMasterVOList.add(productService.getProductMasterById(productIds));
			model.addAttribute("productList", productMasterVOList);
		}else {
			// Cart
			// jsp idlist.join(", ")
			model.addAttribute("productList", null);
		}
		
		model.addAttribute("loginUser", loginUser);
		
		if(null == loginUser) {
			return "redirect:/user/login.do";
		}else {
			return "orderSheet";
		}
	}
	
}