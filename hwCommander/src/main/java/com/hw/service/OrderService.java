package com.hw.service;

import java.util.List;

import com.hw.model.OrderDetailVO;
import com.hw.model.OrderMasterVO;

public interface OrderService {
	public String getOrderMasterVOUniqueId();
	public Integer orderRegistLogic(OrderMasterVO orderMasterVO, List<OrderDetailVO> orderDetailVOList);
	public void orderAllDeleteLogic(String id);
	public List<OrderMasterVO> getOrderMasterAllList();
	public OrderMasterVO getOrderMasterById(String id);
	public List<OrderMasterVO> getOrderMasterListByOrdererUserId(String ordererUserId);
	public Integer inicisPayComplete(String id);
	public Integer orderVideoRequestToAdmin(String id);
	public Integer adminUpdateOrderStateCd(OrderMasterVO orderMasterVO);
	public Integer adminUpdateVideoRequestCd(OrderMasterVO orderMasterVO);
	
	public List<OrderDetailVO> getOrderDetailListById(String id);
}