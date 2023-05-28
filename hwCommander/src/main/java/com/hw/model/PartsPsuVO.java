package com.hw.model;

import java.util.Date;

import lombok.Data;

@Data
public class PartsPsuVO {
	private String id;
	private String partsName;
	private int partsPrice;
	private String partsPriceStr;
	private String pmcCd;
	private String pmcCdNm;
	private String pscCd;
	private String pscCdNm;
	private float std;
	private float psuas;
	private float pfm;
	private float sft;
	private int tdp;
	private int pl;
	private int gpl;
	private int twelvePin;
	private String partsImage;
	private String regDtm;
	private String updtDtm;
	private String multiBulk;
}