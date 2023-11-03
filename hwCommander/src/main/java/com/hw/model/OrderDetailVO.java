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
	private int boxQty;
	private int boxTotPrice;
	
	// ProductMasterVO Data
	private String productName;
	private String productDescription;
	private String productImage;
}