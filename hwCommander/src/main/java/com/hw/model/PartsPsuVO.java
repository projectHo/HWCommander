package com.hw.model;

import java.math.BigDecimal;

import lombok.Data;

@Data
public class PartsPsuVO {
	private String id;
	private String partsName;
	private int partsPrice;
	private String partsPriceStr;
	private String pmcCd;
	private String pmcCdNm;
	private String pscCd;
	private String pscCdNm;
	private BigDecimal std;
//	private BigDecimal psuas;
	private String makerId;
	private BigDecimal pfm;
	private BigDecimal sft;
	private int tdp;
	private int pl;
	private int gpl;
	private int twelvePin;
	private String partsImage;
	private String regDtm;
	private String updtDtm;
	private int multiBulk;
	
	private int partsHistorySeq;
}