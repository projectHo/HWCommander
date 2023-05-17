package com.hw.model;

import java.util.Date;

import lombok.Data;

@Data
public class ProductMasterVO {
	// model
	private String id;
	private String productName;
	private int productPrice;
	private int productQty;
	private String productDescription;
	private String productImage;
	private Date regDtm;
	private Date updtDtm;
	
	//necessity column
	private String eventMallInfo;
	private String productPriceStr;
	private String productDescriptionStr;
	private String productDetailListStr;
}