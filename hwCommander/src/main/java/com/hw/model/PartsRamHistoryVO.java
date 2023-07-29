package com.hw.model;

import java.math.BigDecimal;

import lombok.Data;

@Data
public class PartsRamHistoryVO {
	private String id;
	private int historySeq;
	private String partsName;
	private int partsPrice;
	private String partsPriceStr;
	private String rledCd;
	private String rledCdNm;
	private String rmcCd;
	private String rmcCdNm;
	private String rscCd;
	private String rscCdNm;
	private int cl;
	private BigDecimal latency;
	private String prCd;
	private String prCdNm;
	private String memSocCd;
	private String memSocCdNm;
	private int ddr4MaxRange;
	private int ddr5MaxRange;
	private String partsImage;
	private String regDtm;
	private int multiBulk;
	private int volume;
	private int sd;
}