package com.hw.model;

import java.util.Date;

import lombok.Data;

@Data
public class ProductDetailVO {
	private String id;
	private int seq;
	private String partsTypeCd;
	private String partsTypeCdNm;
	private int qty;
	private int partsPrice;
	private String partsImage;
	private Date regDtm;
	private Date updtDtm;
}