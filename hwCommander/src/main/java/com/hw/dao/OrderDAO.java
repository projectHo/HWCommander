package com.hw.dao;

import java.util.List;

import com.hw.model.OrderDetailVO;
import com.hw.model.OrderMasterHistoryVO;
import com.hw.model.OrderMasterVO;
import com.hw.model.ProcessResourceMasterVO;

public interface OrderDAO {
	public String getOrderMasterVOUniqueId();
	public Integer getOrderMasterVOIdDupliChkCount(String id);
	public Integer insertOrderMasterVO(OrderMasterVO OrderMasterVO);
	public List<OrderMasterVO> getOrderMasterAllList(OrderMasterVO orderMasterVO);
	public void deleteOrderMasterVO(String id);
	public Integer updateOrderMasterVO(OrderMasterVO OrderMasterVO);
	
	public Integer insertOrderMasterHistoryVO(OrderMasterHistoryVO orderMasterHistoryVO);
	public Integer getOrderMasterHistoryVOMaxHistorySeq(String id);
	public void deleteOrderMasterHistoryVO(String id);
	
	public Integer insertOrderDetailVO(OrderDetailVO orderDetailVO);
	public void deleteOrderDetailVO(String id);
}