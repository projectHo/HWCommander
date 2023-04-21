package com.hw.service.impl;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hw.dao.OrderDAO;
import com.hw.service.OrderService;

@Service
public class OrderServiceImpl implements OrderService {
	
	@Autowired
    private OrderDAO productDAO;
}
