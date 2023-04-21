package com.hw.model;

import java.util.Date;

import lombok.Data;

@Data
public class ProductDetailVO {
	private String id;
	private int seq;
	private String partsTypeCd;
	private String partsTypeCdNm;
	private String partsId;
	private int partsQty;
	private int partsPrice;
	private int partsTotalPrice;
	private String partsImage;
	private Date regDtm;
	private Date updtDtm;
}