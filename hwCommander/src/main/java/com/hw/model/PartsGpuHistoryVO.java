package com.hw.model;

import java.math.BigDecimal;

import lombok.Data;

@Data
public class PartsGpuHistoryVO {
	private String id;
	private int historySeq;
	private String partsName;
	private int partsPrice;
	private String partsPriceStr;
	private String gledCd;
	private String gledCdNm;
	private BigDecimal gn;
	private String gmcCd;
	private String gmcCdNm;
	private String gscCd;
	private String gscCdNm;
	private BigDecimal gsv;
//	private String gpuasCd;
//	private String gpuasCdNm;
	private String makerId;
	private String makerNm;
	private BigDecimal qc;
	private int tdp;
	private int bn;
	private int il;
	private int gpl;
	private int twelvePin;
	private String partsImage;
	private String regDtm;
	private int multiBulk;
	private int gc;
}