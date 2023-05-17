package com.hw.model;

import java.util.Date;

import lombok.Data;

@Data
public class PartsHddVO {
	private String id;
	private String partsName;
	private int partsPrice;
	private String partsPriceStr;
	private int spd;
	private float fea;
	private float rel;
	private float noice;
	private int mttf;
	private int gur;
	private int strThreeDotFive;
	private int sata;
	private String partsImage;
	private Date regDtm;
	private Date updtDtm;
	private String multiBulk;
	private int volume;
}