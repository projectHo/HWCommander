package com.hw.model;

import lombok.Data;

@Data
public class OrderDetailVO {
	private String id;
	private int seq;
	private String productId;
	private int productPrice;
	private int productOrderQty;
	private String regDtm;
	private String updtDtm;
	
}