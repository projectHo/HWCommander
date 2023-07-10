package com.hw.service.impl;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hw.dao.OrderDAO;
import com.hw.service.OrderService;

@Service
public class OrderServiceImpl implements OrderService {
	
	@Autowired
    private OrderDAO orderDAO;
	
	@Override
	public String getOrderMasterVOUniqueId() {
		String id = null;
		id = orderDAO.getOrderMasterVOUniqueId();
		
		int dupliChkCount = orderDAO.getOrderMasterVOIdDupliChkCount(id);
		
		if(0 == dupliChkCount) {
			return id;
		}else {
			// 중복인 id 인 경우 재귀함수 호출
			return getOrderMasterVOUniqueId();
		}
	}
}
