package com.hw.model;

import lombok.Data;

@Data
public class ProductDetailVO {
	private String id;
	private int seq;
	private String partsTypeCd;
	private String partsTypeCdNm;
	private String partsId;
	private String partsName;
	private int partsQty;
	private int partsPrice;
	private int partsTotalPrice;
	private String partsImage;
	private String regDtm;
	private String updtDtm;
	
	// product 등록할 시 선택되었던 parts의 이력시퀀스 저장
	private int partsHistorySeq;
}