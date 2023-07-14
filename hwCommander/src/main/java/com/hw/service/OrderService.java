package com.hw.service;

import java.util.List;

import com.hw.model.OrderDetailVO;
import com.hw.model.OrderMasterVO;

public interface OrderService {
	public String getOrderMasterVOUniqueId();
	public Integer orderRegistLogic(OrderMasterVO orderMasterVO, List<OrderDetailVO> orderDetailVOList);
	public void orderAllDeleteLogic(String id);
	public Integer inicisPayComplete(String id);
	public List<OrderMasterVO> getOrderMasterAllList(OrderMasterVO orderMasterVO);
	public OrderMasterVO getOrderMasterById(String id);
	public Integer orderVideoRequestToAdmin(String id);
	
	public List<OrderDetailVO> getOrderDetailAllList(OrderDetailVO orderDetailVO);
}