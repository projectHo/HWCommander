package com.hw.model;

import java.util.Date;

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
	private float fnoi;
	private float ffm;
	private int fh;
	private int ft;
	private String partsImage;
	private String regDtm;
	private String updtDtm;
	private String multiBulk;
}