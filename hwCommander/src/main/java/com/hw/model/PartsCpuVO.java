package com.hw.model;

import java.util.Date;

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
	private float vrmRange;
	private int ddr4MaxRange;
	private int ddr5MaxRange;
	private String partsImage;
	private Date regDtm;
	private Date updtDtm;
	private String multiBulk;
	private String apu;
}