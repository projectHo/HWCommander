package com.hw.model;

import java.util.Date;

import lombok.Data;

@Data
public class OrderMasterVO {
	private String id;
	private String productName;
	private int productPrice;
	private int productQty;
	private String productDescription;
	private String productImage;
	private Date regDtm;
	private Date updtDtm;
}