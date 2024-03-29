package com.hw.model;

import java.math.BigDecimal;

import lombok.Data;

@Data
public class PartsSfVO {
	private String id;
	private String partsName;
	private int partsPrice;
	private String partsPriceStr;
	private String fledCd;
	private String fledCdNm;
	private String fmcCd;
	private String fmcCdNm;
	private String fscCd;
	private String fscCdNm;
	private BigDecimal fnoi;
	private BigDecimal ffm;
	private int fh;
	private int ft;
	private String partsImage;
	private String regDtm;
	private String updtDtm;
	private int multiBulk;
	private int qc;
	
	private int partsHistorySeq;
}