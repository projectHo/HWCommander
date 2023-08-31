package com.hw.model;

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
	private String regDtm;
	private String updtDtm;
	private String productRegistPathCd;
	private String productRegistPathCdNm;
	private String windowsName;
	private int windowsPrice;
	
	//necessity column
	private String eventMallInfo;
	private String productPriceStr;
	private String productDescriptionStr;
	private String productDetailListStr;
	private int orderDetailCnt;
}