package com.hw.service.impl;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hw.dao.OrderDAO;
import com.hw.model.OrderDetailVO;
import com.hw.model.OrderMasterHistoryVO;
import com.hw.model.OrderMasterVO;
import com.hw.model.RefundInfoVO;
import com.hw.service.OrderService;

@Service
public class OrderServiceImpl implements OrderService {
	
	@Autowired
    private OrderDAO orderDAO;
	
	/*--------------------------------------------------
	 - order_master, order_detail
	*--------------------------------------------------*/
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
			OrderMasterHistoryVO orderMasterHistoryVO = orderMasterVOToOrderMasterHistoryVO(orderMasterVO);
			orderMasterHistoryVO.setHistoryContents("최초등록");
			result += orderDAO.insertOrderMasterHistoryVO(orderMasterHistoryVO);
		}
		
		return result;
	}
	
	@Override
	public Integer orderAllDeleteLogic(String id) {
		int result = 0;
		orderDAO.deleteOrderMasterVO(id);
		orderDAO.deleteOrderMasterHistoryVO(id);
		orderDAO.deleteOrderDetailVO(id);
		result = 1;
		return result;
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
			OrderMasterHistoryVO orderMasterHistoryVO = orderMasterVOToOrderMasterHistoryVO(orderMasterVO);
			orderMasterHistoryVO.setHistoryContents("이니시스 결제완료");
			result += orderDAO.insertOrderMasterHistoryVO(orderMasterHistoryVO);
		}
		
		return result;
	}
	
	@Override
	public List<OrderMasterVO> getOrderMasterAllList() {
		OrderMasterVO searchVO = new OrderMasterVO();
		return orderDAO.getOrderMasterAllList(searchVO);
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
	public List<OrderMasterVO> getOrderMasterListByOrdererUserId(String ordererUserId) {
		OrderMasterVO searchVO = new OrderMasterVO();
		
		searchVO.setOrdererUserId(ordererUserId);
		List<OrderMasterVO> resultList = orderDAO.getOrderMasterAllList(searchVO);
		
		return resultList;
	}
	
	@Override
	public Integer updateOrderStateCd(OrderMasterVO orderMasterVO) {
		int result = 0;
		OrderMasterVO targetOrderMasterVO = getOrderMasterById(orderMasterVO.getId());
		
		targetOrderMasterVO.setOrderStateCd(orderMasterVO.getOrderStateCd());
		result = orderDAO.updateOrderMasterVO(targetOrderMasterVO);
		
		if(1 == result) {
			OrderMasterHistoryVO orderMasterHistoryVO = orderMasterVOToOrderMasterHistoryVO(targetOrderMasterVO);
			orderMasterHistoryVO.setHistoryContents("결제상태변경");
			result += orderDAO.insertOrderMasterHistoryVO(orderMasterHistoryVO);
		}
		
		return result;
	}
	
	@Override
	public Integer updateVideoRequestCd(OrderMasterVO orderMasterVO) {
		int result = 0;
		OrderMasterVO targetOrderMasterVO = getOrderMasterById(orderMasterVO.getId());
		
		targetOrderMasterVO.setVideoRequestCd(orderMasterVO.getVideoRequestCd());
		result = orderDAO.updateOrderMasterVO(targetOrderMasterVO);
		
		if(1 == result) {
			OrderMasterHistoryVO orderMasterHistoryVO = orderMasterVOToOrderMasterHistoryVO(targetOrderMasterVO);
			orderMasterHistoryVO.setHistoryContents("영상요청상태변경");
			result += orderDAO.insertOrderMasterHistoryVO(orderMasterHistoryVO);
		}
		
		return result;
	}
	
	@Override
	public Integer updateWaybillNumber(OrderMasterVO orderMasterVO) {
		int result = 0;
		OrderMasterVO targetOrderMasterVO = getOrderMasterById(orderMasterVO.getId());
		
		targetOrderMasterVO.setWaybillNumber(orderMasterVO.getWaybillNumber());
		result = orderDAO.updateOrderMasterVO(targetOrderMasterVO);
		
		if(1 == result) {
			OrderMasterHistoryVO orderMasterHistoryVO = orderMasterVOToOrderMasterHistoryVO(targetOrderMasterVO);
			orderMasterHistoryVO.setHistoryContents("운송장번호 항목 변경");
			result += orderDAO.insertOrderMasterHistoryVO(orderMasterHistoryVO);
		}
		
		return result;
	}
	
	@Override
	public Integer updateRecipientHpNumber2(OrderMasterVO orderMasterVO) {
		int result = 0;
		OrderMasterVO targetOrderMasterVO = getOrderMasterById(orderMasterVO.getId());
		
		targetOrderMasterVO.setRecipientHpNumber2(orderMasterVO.getRecipientHpNumber2());
		result = orderDAO.updateOrderMasterVO(targetOrderMasterVO);
		
		if(1 == result) {
			OrderMasterHistoryVO orderMasterHistoryVO = orderMasterVOToOrderMasterHistoryVO(targetOrderMasterVO);
			orderMasterHistoryVO.setHistoryContents("추가연락처 항목 변경");
			result += orderDAO.insertOrderMasterHistoryVO(orderMasterHistoryVO);
		}
		
		return result;
	}
	
	@Override
	public Integer updateAddrs(OrderMasterVO orderMasterVO) {
		int result = 0;
		OrderMasterVO targetOrderMasterVO = getOrderMasterById(orderMasterVO.getId());
		
		targetOrderMasterVO.setRecipientJibunAddr(orderMasterVO.getRecipientJibunAddr());
		targetOrderMasterVO.setRecipientRoadAddr(orderMasterVO.getRecipientRoadAddr());
		targetOrderMasterVO.setRecipientDetailAddr(orderMasterVO.getRecipientDetailAddr());
		targetOrderMasterVO.setRecipientZipcode(orderMasterVO.getRecipientZipcode());
		
		result = orderDAO.updateOrderMasterVO(targetOrderMasterVO);
		
		if(1 == result) {
			OrderMasterHistoryVO orderMasterHistoryVO = orderMasterVOToOrderMasterHistoryVO(targetOrderMasterVO);
			orderMasterHistoryVO.setHistoryContents("주소 항목 변경");
			result += orderDAO.insertOrderMasterHistoryVO(orderMasterHistoryVO);
		}
		
		return result;
	}
	
	@Override
	public Integer updateOrderRequest(OrderMasterVO orderMasterVO) {
		int result = 0;
		OrderMasterVO targetOrderMasterVO = getOrderMasterById(orderMasterVO.getId());
		
		targetOrderMasterVO.setOrderRequest(orderMasterVO.getOrderRequest());
		
		result = orderDAO.updateOrderMasterVO(targetOrderMasterVO);
		
		if(1 == result) {
			OrderMasterHistoryVO orderMasterHistoryVO = orderMasterVOToOrderMasterHistoryVO(targetOrderMasterVO);
			orderMasterHistoryVO.setHistoryContents("주문 시 요청사항 항목 변경");
			result += orderDAO.insertOrderMasterHistoryVO(orderMasterHistoryVO);
		}
		
		return result;
	}
	
	@Override
	public Integer updateDeliveryRequest(OrderMasterVO orderMasterVO) {
		int result = 0;
		OrderMasterVO targetOrderMasterVO = getOrderMasterById(orderMasterVO.getId());
		
		targetOrderMasterVO.setDeliveryRequest(orderMasterVO.getDeliveryRequest());
		
		result = orderDAO.updateOrderMasterVO(targetOrderMasterVO);
		
		if(1 == result) {
			OrderMasterHistoryVO orderMasterHistoryVO = orderMasterVOToOrderMasterHistoryVO(targetOrderMasterVO);
			orderMasterHistoryVO.setHistoryContents("배송 시 요청사항 항목 변경");
			result += orderDAO.insertOrderMasterHistoryVO(orderMasterHistoryVO);
		}
		
		return result;
	}
	
	@Override
	public List<OrderDetailVO> getOrderDetailListById(String id) {
		OrderDetailVO searchVO = new OrderDetailVO();
		searchVO.setId(id);
		return orderDAO.getOrderDetailAllList(searchVO);
	}
	
	@Override
	public List<OrderDetailVO> getOrderDetailListByProductId(String productId) {
		OrderDetailVO searchVO = new OrderDetailVO();
		searchVO.setProductId(productId);
		return orderDAO.getOrderDetailAllList(searchVO);
	}
	
	@Override
	public List<OrderDetailVO> getOrderDetailAndRefundInfoListById(String id) {
		return orderDAO.getOrderDetailAndRefundInfoListById(id);
	}
	
	/*--------------------------------------------------
	 - refund_info
	*--------------------------------------------------*/
	@Override
	public List<RefundInfoVO> getRefundInfoAllList() {
		RefundInfoVO searchVO = new RefundInfoVO();
		return orderDAO.getRefundInfoAllList(searchVO);
	}
	
	@Override
	public RefundInfoVO getRefundInfoById(String id) {
		RefundInfoVO resultVO = null;
		RefundInfoVO searchVO = new RefundInfoVO();
		
		searchVO.setId(id);
		List<RefundInfoVO> resultList = orderDAO.getRefundInfoAllList(searchVO);
		
		if(resultList.size() != 0) {
			resultVO = resultList.get(0);
		}
		
		return resultVO;
	}
	
	@Override
	public List<RefundInfoVO> getRefundInfoByOrderId(String orderId) {
		RefundInfoVO searchVO = new RefundInfoVO();
		
		searchVO.setOrderId(orderId);
		List<RefundInfoVO> resultList = orderDAO.getRefundInfoAllList(searchVO);
		
		return resultList;
	}
	
	@Override
	public List<RefundInfoVO> getRefundInfoByOrderIdAndOrderSeq(String orderId, int orderSeq) {
		RefundInfoVO searchVO = new RefundInfoVO();
		
		searchVO.setOrderId(orderId);
		searchVO.setOrderSeq(orderSeq);
		List<RefundInfoVO> resultList = orderDAO.getRefundInfoAllList(searchVO);
		
		return resultList;
	}
	
	@Override
	public Integer refundInfoRegistLogic(RefundInfoVO refundInfoVO, String orderStateCd) {
		int result = 0;
		
		OrderMasterVO orderMasterVO = new OrderMasterVO();
		orderMasterVO.setId(refundInfoVO.getOrderId());
		orderMasterVO.setOrderStateCd(orderStateCd);
		
		int updateResult = updateOrderStateCd(orderMasterVO);
		
		if(2 == updateResult) {
			String refundMaxId = orderDAO.getRefundInfoVOMaxId();
			refundInfoVO.setId(refundMaxId);
			// update 성공 시 refund_info insert
			result = orderDAO.insertRefundInfoVO(refundInfoVO);
		}

		return result;
	}
	
	@Override
	public Integer refundInfoUpdateLogic(RefundInfoVO refundInfoVO) {
		int result = 0;
		
		RefundInfoVO updateVO = getRefundInfoById(refundInfoVO.getId());
		// admin page에서 수정 가능한 항목들
//		updateVO.setTotRefundPrice(refundInfoVO.getTotRefundPrice());
		updateVO.setDeterminRefundPrice(refundInfoVO.getDeterminRefundPrice());
		updateVO.setRefundStateCd(refundInfoVO.getRefundStateCd());
		updateVO.setRefundContent(refundInfoVO.getRefundContent());
		updateVO.setRefundRemarks(refundInfoVO.getRefundRemarks());
		updateVO.setRefundPartialAgreeContent(refundInfoVO.getRefundPartialAgreeContent());
		
		result = orderDAO.updateRefundInfoVO(updateVO);
		return result;
	}
	
	@Override
	public Integer refundInfoDeleteLogic(String id, String orderId) {
		int result = 0;
		
		// order id로 환불상태가 환불과 부분환불 관련 4개코드를 제외하고 가장 마지막 history의 상태값을 조회함.
		OrderMasterHistoryVO orderMasterHistoryVO = orderDAO.getMaxOrderMasterHistoryInOrderStateCdRefundExceptById(orderId);
		String orderStateCd = orderMasterHistoryVO.getOrderStateCd();
		
		OrderMasterVO orderMasterVO = new OrderMasterVO();
		orderMasterVO.setId(orderId);
		orderMasterVO.setOrderStateCd(orderStateCd);
		
		int updateResult = updateOrderStateCd(orderMasterVO);
		
		if(2 == updateResult) {
			// update 성공 시 refund_info delete
			orderDAO.deleteRefundInfoVO(id);
			result = 1;
		}
		
		return result;
	}
	
	@Override
	public List<RefundInfoVO> getRefundInfoByUserId(String userId) {
		// 유저아이디로 order master 조회
		List<OrderMasterVO> orderMasterVOList =  getOrderMasterListByOrdererUserId(userId);
		List<RefundInfoVO> resultList = null;
		
		//23.11.07 추가 order건이 있을 경우에만 로직 진행하며 없는 userId인 경우 null값 return
		if(0 < orderMasterVOList.size()) {
			// order id 여러개로 in처리 쿼리 적용
			String[] orderIds = new String[orderMasterVOList.size()];
			
			for(int i = 0; i < orderMasterVOList.size(); i++) {
				orderIds[i] = orderMasterVOList.get(i).getId();
			}
			
			resultList = orderDAO.getRefundInfoListByOrderIds(orderIds);
		}
		
		return resultList;
	}
	
	/*--------------------------------------------------
	 - private method
	*--------------------------------------------------*/
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
