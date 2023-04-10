package com.hw.model;

import java.util.Date;

import lombok.Data;

@Data
public class ProductMasterVO {
	private String id;
	private String productName;
	private int productPrice;
	private String productDescription;
	private String productImage;
	private Date regDtm;
	private Date updtDtm;
}