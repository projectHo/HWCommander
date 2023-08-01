package com.hw.model;

import java.math.BigDecimal;

import lombok.Data;

@Data
public class PartsSfHistoryVO {
	private String id;
	private int historySeq;
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
	private int multiBulk;
}