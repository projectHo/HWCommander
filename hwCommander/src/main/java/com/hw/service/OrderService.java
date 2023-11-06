package com.hw.service;

import java.util.List;

import com.hw.model.OrderDetailVO;
import com.hw.model.OrderMasterVO;
import com.hw.model.RefundInfoVO;

public interface OrderService {
	/*--------------------------------------------------
	 - order_master, order_detail
	*--------------------------------------------------*/
	public String getOrderMasterVOUniqueId();
	public Integer orderRegistLogic(OrderMasterVO orderMasterVO, List<OrderDetailVO> orderDetailVOList);
	public Integer orderAllDeleteLogic(String id);
	public List<OrderMasterVO> getOrderMasterAllList();
	public OrderMasterVO getOrderMasterById(String id);
	public List<OrderMasterVO> getOrderMasterListByOrdererUserId(String ordererUserId);
	public Integer inicisPayComplete(String id);
	public Integer updateOrderStateCd(OrderMasterVO orderMasterVO);
	public Integer updateVideoRequestCd(OrderMasterVO orderMasterVO);
	public Integer updateWaybillNumber(OrderMasterVO orderMasterVO);
	
	public Integer updateRecipientHpNumber2(OrderMasterVO orderMasterVO);
	public Integer updateAddrs(OrderMasterVO orderMasterVO);
	public Integer updateOrderRequest(OrderMasterVO orderMasterVO);
	public Integer updateDeliveryRequest(OrderMasterVO orderMasterVO);
	
	public List<OrderDetailVO> getOrderDetailListById(String id);
	public List<OrderDetailVO> getOrderDetailListByProductId(String productId);
	public List<OrderDetailVO> getOrderDetailAndRefundInfoListById(String id);
	
	/*--------------------------------------------------
	 - refund_info
	*--------------------------------------------------*/
	public List<RefundInfoVO> getRefundInfoAllList();
	public RefundInfoVO getRefundInfoById(String id);
	public List<RefundInfoVO> getRefundInfoByOrderId(String orderId);
	// DB 구조 상 해당 조회조건으로 여러 건이 존재할 수 있어서 return 형식을 List로 잡았으나 로직 상 1건만 조회되어야 함.
	public List<RefundInfoVO> getRefundInfoByOrderIdAndOrderSeq(String orderId, int orderSeq);
	public Integer refundInfoRegistLogic(RefundInfoVO refundInfoVO, String orderStateCd);
	public Integer refundInfoUpdateLogic(RefundInfoVO refundInfoVO);
	public Integer refundInfoDeleteLogic(String id);
	public List<RefundInfoVO> getRefundInfoByUserId(String userId);
}