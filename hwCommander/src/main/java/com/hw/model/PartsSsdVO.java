package com.hw.model;

import java.util.Date;

import lombok.Data;

@Data
public class PartsSsdVO {
	private String id;
	private String partsName;
	private int partsPrice;
	private float basic;
	private int fnc;
	private int cmf;
	private int war;
	private float thr;
	private float rlb;
	private int strTwoDotFive;
	private String scsCd;
	private String scsCdNm;
	private int sata;
	private String partsImage;
	private Date regDtm;
	private Date updtDtm;
}