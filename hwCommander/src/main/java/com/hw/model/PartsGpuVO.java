package com.hw.model;

import java.util.Date;

import lombok.Data;

@Data
public class PartsGpuVO {
	private String id;
	private String partsName;
	private int partsPrice;
	private String partsPriceStr;
	private String gledCd;
	private String gledCdNm;
	private float gn;
	private String gmcCd;
	private String gmcCdNm;
	private String gscCd;
	private String gscCdNm;
	private float gsv;
	private String gpuasCd;
	private String gpuasCdNm;
	private float qc;
	private int tdp;
	private int bn;
	private int il;
	private int gpl;
	private int twelvePin;
	private String partsImage;
	private Date regDtm;
	private Date updtDtm;
	private String multiBulk;
}