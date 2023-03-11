package com.hw.model;

import java.util.Date;

import lombok.Data;

@Data
public class PartsCaseVO {
	private String id;
	private String partsName;
	private int partsPrice;
	private String cledCd;
	private String cmCd;
	private String cmcCd;
	private String cscCd;
	private String caseasCd;
	private float adap;
	private float cool;
	private float end;
	private float conv;
	private int ff;
	private int iw;
	private int il;
	private int ih;
	private int it;
	private int fh;
	private int ft;
	private int strTwoDotFive;
	private int strThreeDotFive;
	private String partsImage;
	private Date regDtm;
	private Date updtDtm;
}