package com.hw.model;

import java.util.Date;

import lombok.Data;

@Data
public class PartsPsuVO {
	private String id;
	private String partsName;
	private int partsPrice;
	private String pmcCd;
	private String pscCd;
	private float std;
	private float psuas;
	private float pfm;
	private float sft;
	private int tdp;
	private int pl;
	private int gpl;
	private String partsImage;
	private Date regDtm;
	private Date updtDtm;
}