package com.hw.dao;

import java.util.List;

import com.hw.model.OrderDetailVO;
import com.hw.model.OrderMasterHistoryVO;
import com.hw.model.OrderMasterVO;
import com.hw.model.ProcessResourceMasterVO;
import com.hw.model.RefundInfoVO;

public interface OrderDAO {
	/*--------------------------------------------------
	 - order_master, order_detail
	*--------------------------------------------------*/
	public String getOrderMasterVOUniqueId();
	public Integer getOrderMasterVOIdDupliChkCount(String id);
	public Integer insertOrderMasterVO(OrderMasterVO OrderMasterVO);
	public List<OrderMasterVO> getOrderMasterAllList(OrderMasterVO orderMasterVO);
	public void deleteOrderMasterVO(String id);
	public Integer updateOrderMasterVO(OrderMasterVO OrderMasterVO);
	
	public Integer insertOrderMasterHistoryVO(OrderMasterHistoryVO orderMasterHistoryVO);
	public Integer getOrderMasterHistoryVOMaxHistorySeq(String id);
	public void deleteOrderMasterHistoryVO(String id);
	
	public List<OrderDetailVO> getOrderDetailAllList(OrderDetailVO orderDetailVO);
	public Integer insertOrderDetailVO(OrderDetailVO orderDetailVO);
	public void deleteOrderDetailVO(String id);
	public List<OrderDetailVO> getOrderDetailAndRefundInfoListById(String id);
	
	/*--------------------------------------------------
	 - refund_info
	*--------------------------------------------------*/
	public String getRefundInfoVOMaxId();
	public List<RefundInfoVO> getRefundInfoAllList(RefundInfoVO refundInfoVO);
	public Integer insertRefundInfoVO(RefundInfoVO refundInfoVO);
	public Integer updateRefundInfoVO(RefundInfoVO refundInfoVO);
	public void deleteRefundInfoVO(String id);
	public List<RefundInfoVO> getRefundInfoListByOrderIds(String[] orderIds);
	
}