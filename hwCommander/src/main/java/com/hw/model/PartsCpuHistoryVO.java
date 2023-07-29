package com.hw.model;

import java.math.BigDecimal;

import lombok.Data;

@Data
public class PartsCpuHistoryVO {
	private String id;
	private int historySeq;
	private String partsName;
	private int partsPrice;
	private String partsPriceStr;
	private int csv;
	private String iaCd;
	private String iaCdNm;
	private int thermal;
	private int bn;
	private String cpuSocCd;
	private String cpuSocCdNm;
	private BigDecimal vrmRange;
	private int ddr4MaxRange;
	private int ddr5MaxRange;
	private String partsImage;
	private String regDtm;
	private int multiBulk;
	private String apu;
}