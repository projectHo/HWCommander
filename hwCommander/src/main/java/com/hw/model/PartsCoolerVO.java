package com.hw.model;

import java.math.BigDecimal;

import lombok.Data;

@Data
public class PartsCoolerVO {
	private String id;
	private String partsName;
	private int partsPrice;
	private String partsPriceStr;
	private String clledCd;
	private String clledCdNm;
	private String clmcCd;
	private String clmcCdNm;
	private String clscCd;
	private String clscCdNm;
	private String formulaCd;
	private String formulaCdNm;
	private BigDecimal sta;
	private int wcas;
	private int acas;
	private BigDecimal noi;
	private int cnv;
	private int thermal;
	private int iw;
	private int ih;
	private int it;
	private String partsImage;
	private String regDtm;
	private String updtDtm;
	private int multiBulk;
	private String clSoc;
	private int qc;
	
	private int partsHistorySeq;
}