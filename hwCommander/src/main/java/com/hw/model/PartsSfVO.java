package com.hw.model;

import java.util.Date;

import lombok.Data;

@Data
public class PartsSfVO {
	private String id;
	private String partsName;
	private int partsPrice;
	private String fledCd;
	private String fmcCd;
	private String fscCd;
	private float fnoi;
	private float ffm;
	private int fh;
	private int ft;
	private String partsImage;
	private Date regDtm;
	private Date updtDtm;
}