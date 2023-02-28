package com.hw.model;

import java.util.Date;

import lombok.Data;

@Data
public class PartsCpuVO {
	private String id;
	private String partsName;
	private int partsPrice;
	private int csv;
	private String makerCd;
	private int thermal;
	private int bn;
	private String cpuSocCd;
	private float vrmRange;
	private int ddr4MaxRange;
	private int ddr5MaxRange;
	private String partsImage;
	private Date regDtm;
	private Date updtDtm;
}