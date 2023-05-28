package com.hw.model;

import java.util.Date;

import lombok.Data;

@Data
public class OrderDetailVO {
	private String id;
	private int seq;
	private String productId;
	private int productOrderQty;
	private int orderPrice;
	private String regDtm;
	private String updtDtm;
	
}