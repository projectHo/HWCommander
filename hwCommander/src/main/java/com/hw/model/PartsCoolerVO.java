package com.hw.model;

import java.util.Date;

import lombok.Data;

@Data
public class PartsCoolerVO {
	private String id;
	private String partsName;
	private int partsPrice;
	private String clledCd;
	private String clmcCd;
	private String clscCd;
	private String formulaCd;
	private float sta;
	private int wcas;
	private int acas;
	private float noi;
	private int cnv;
	private int thermal;
	private int iw;
	private int ih;
	private int it;
	private String partsImage;
	private Date regDtm;
	private Date updtDtm;
}