package com.hw.model;

import lombok.Data;

@Data
public class RefundInfoVO {
	// model
	private String id;
	private String orderId;
	private int orderSeq;
	private String productId;
	private int productPrice;
	private int refundQty;
	private int requestRefundPrice;
	private int determinRefundPrice;
	private String refundStateCd;
	private String refundStateCdNm;
	private String refundReasonCd;
	private String refundReasonCdNm;
	private String refundReasonUserWrite;
	private String refundContent;
	private String refundRemarks;
	private String regDtm;
	private String updtDtm;
	private String refundPartialAgreeContent;
	private String refundPartialAgreeCd;
	private String refundPartialAgreeCdNm;
	
	//necessity column
	private String refundContentStr;
	private String refundRemarksStr;
	private String refundPartialAgreeContentStr;
	private String requestRefundPriceStr;
	private String determinRefundPriceStr;
}