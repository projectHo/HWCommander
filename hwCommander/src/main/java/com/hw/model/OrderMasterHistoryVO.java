package com.hw.model;

import java.util.Date;

import lombok.Data;

@Data
public class OrderMasterHistoryVO {
	private String id;
	private int seq;
	private Date orderDate;
	private String orderName;
	private int totOrderPrice;
	private String orderStateCd;
	private String ordererName;
	private String ordererHpNumber;
	private String ordererMail;
	private String recipientName;
	private String recipientHpNumber;
	private String recipientHpNumber2;
	private String recipientJibunAddr;
	private String recipientRoadAddr;
	private String recipientDetailAddr;
	private String recipientZipcode;
	private String orderRequest;
	private String deliveryRequest;
	private String paymentMethod;
	private String waybillNumber;
	private String regDtm;
}