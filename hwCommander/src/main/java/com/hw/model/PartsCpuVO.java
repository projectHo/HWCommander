package com.hw.model;

import java.math.BigDecimal;

import lombok.Data;

@Data
public class PartsCpuVO {
	private String id;
	private String partsName;
	private int partsPrice;
	private String partsPriceStr;
	private int csv;
	private String makerCd;
	private String makerCdNm;
	private int thermal;
	private int bn;
	private String cpuSocCd;
	private String cpuSocCdNm;
	private BigDecimal vrmRange;
	private int ddr4MaxRange;
	private int ddr5MaxRange;
	private String partsImage;
	private String regDtm;
	private String updtDtm;
	private String multiBulk;
	private String apu;
}