package com.hw.service.impl;


import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hw.dao.OrderDAO;
import com.hw.model.OrderDetailVO;
import com.hw.model.OrderMasterHistoryVO;
import com.hw.model.OrderMasterVO;
import com.hw.model.PartsGpuVO;
import com.hw.model.PartsMakerHistoryVO;
import com.hw.model.ProductDetailVO;
import com.hw.model.ProductMasterVO;
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
	
	@Override
	public Integer orderRegistLogic(OrderMasterVO orderMasterVO, List<OrderDetailVO> orderDetailVOList) {
		int result = 0;
		
		for(int i = 0; i < orderDetailVOList.size(); i++) {
			OrderDetailVO orderDetailVO = new OrderDetailVO();
			orderDetailVO = orderDetailVOList.get(i); 
			orderDetailVO.setSeq(i+1);
			
			orderDAO.insertOrderDetailVO(orderDetailVO);
		}
		
		result = orderDAO.insertOrderMasterVO(orderMasterVO);
		
		OrderMasterVO searchVO = new OrderMasterVO();
		searchVO.setId(orderMasterVO.getId());
		
		if(1 == result) {
			result += orderDAO.insertOrderMasterHistoryVO(orderMasterVOToOrderMasterHistoryVO(orderMasterVO));
		}
		
		return result;
	}
	
	@Override
	public void orderAllDeleteLogic(String id) {
		orderDAO.deleteOrderMasterVO(id);
		orderDAO.deleteOrderMasterHistoryVO(id);
		orderDAO.deleteOrderDetailVO(id);
	}
	
	@Override
	public Integer inicisPayComplete(String id) {
		int result = 0;
		OrderMasterVO searchVO = new OrderMasterVO();
		searchVO.setId(id);
		
		OrderMasterVO orderMasterVO = orderDAO.getOrderMasterAllList(searchVO).get(0);
		
		// 결제완료
		orderMasterVO.setOrderStateCd("02");
		result = orderDAO.updateOrderMasterVO(orderMasterVO);
		
		if(1 == result) {
			result += orderDAO.insertOrderMasterHistoryVO(orderMasterVOToOrderMasterHistoryVO(orderMasterVO));
		}
		
		return result;
	}
	
	@Override
	public List<OrderMasterVO> getOrderMasterAllList(OrderMasterVO orderMasterVO) {
		return orderDAO.getOrderMasterAllList(orderMasterVO);
	}
	
	@Override
	public OrderMasterVO getOrderMasterById(String id) {
		OrderMasterVO resultVO = null;
		OrderMasterVO searchVO = new OrderMasterVO();
		
		searchVO.setId(id);
		List<OrderMasterVO> resultList = orderDAO.getOrderMasterAllList(searchVO);
		
		if(resultList.size() != 0) {
			resultVO = resultList.get(0);
		}
		
		return resultVO;
	}
	
	@Override
	public Integer orderVideoRequestToAdmin(String id) {
		int result = 0;
		OrderMasterVO searchVO = new OrderMasterVO();
		searchVO.setId(id);
		
		OrderMasterVO orderMasterVO = orderDAO.getOrderMasterAllList(searchVO).get(0);
		
		// 요청
		orderMasterVO.setVideoRequestCd("02");
		result = orderDAO.updateOrderMasterVO(orderMasterVO);
		
		if(1 == result) {
			result += orderDAO.insertOrderMasterHistoryVO(orderMasterVOToOrderMasterHistoryVO(orderMasterVO));
		}
		
		return result;
	}
	
	@Override
	public List<OrderDetailVO> getOrderDetailAllList(OrderDetailVO orderDetailVO) {
		return orderDAO.getOrderDetailAllList(orderDetailVO);
	}
	
	private OrderMasterHistoryVO orderMasterVOToOrderMasterHistoryVO(OrderMasterVO orderMasterVO) {
		OrderMasterHistoryVO orderMasterHistoryVO = new OrderMasterHistoryVO();
		
		OrderMasterVO searchVO = new OrderMasterVO();
		searchVO.setId(orderMasterVO.getId());
		
		orderMasterHistoryVO.setId(orderMasterVO.getId());
		orderMasterHistoryVO.setHistorySeq(orderDAO.getOrderMasterHistoryVOMaxHistorySeq(orderMasterVO.getId()));
		orderMasterHistoryVO.setOrderDate(orderDAO.getOrderMasterAllList(searchVO).get(0).getOrderDate());
		orderMasterHistoryVO.setOrderName(orderMasterVO.getOrderName());
		orderMasterHistoryVO.setTotOrderPrice(orderMasterVO.getTotOrderPrice());
		orderMasterHistoryVO.setOrderStateCd(orderMasterVO.getOrderStateCd());
		orderMasterHistoryVO.setOrdererUserId(orderMasterVO.getOrdererUserId());
		orderMasterHistoryVO.setOrdererName(orderMasterVO.getOrdererName());
		orderMasterHistoryVO.setOrdererHpNumber(orderMasterVO.getOrdererHpNumber());
		orderMasterHistoryVO.setOrdererMail(orderMasterVO.getOrdererMail());
		orderMasterHistoryVO.setRecipientName(orderMasterVO.getRecipientName());
		orderMasterHistoryVO.setRecipientHpNumber(orderMasterVO.getRecipientHpNumber());
		orderMasterHistoryVO.setRecipientHpNumber2(orderMasterVO.getRecipientHpNumber2());
		orderMasterHistoryVO.setRecipientJibunAddr(orderMasterVO.getRecipientJibunAddr());
		orderMasterHistoryVO.setRecipientRoadAddr(orderMasterVO.getRecipientRoadAddr());
		orderMasterHistoryVO.setRecipientDetailAddr(orderMasterVO.getRecipientDetailAddr());
		orderMasterHistoryVO.setRecipientZipcode(orderMasterVO.getRecipientZipcode());
		orderMasterHistoryVO.setOrderRequest(orderMasterVO.getOrderRequest());
		orderMasterHistoryVO.setDeliveryRequest(orderMasterVO.getDeliveryRequest());
		orderMasterHistoryVO.setPaymentMethod(orderMasterVO.getPaymentMethod());
		orderMasterHistoryVO.setWaybillNumber(orderMasterVO.getWaybillNumber());
		orderMasterHistoryVO.setVideoRequestCd(orderMasterVO.getVideoRequestCd());
		
		return orderMasterHistoryVO;
	}
}
