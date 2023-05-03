package com.hw.model;

import java.util.Date;

import lombok.Data;

@Data
public class OrderMasterVO {
	private String id;
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
	private String recipientAddr;
	private String orderRequest;
	private String deliveryRequest;
	private String paymentMethod;
	private String waybillNumber;
	private Date regDtm;
	private Date updtDtm;
}