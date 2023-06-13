package com.hw.model;

import java.math.BigDecimal;

import lombok.Data;

@Data
public class PartsHddVO {
	private String id;
	private String partsName;
	private int partsPrice;
	private String partsPriceStr;
	private int spd;
	private BigDecimal fea;
	private BigDecimal rel;
	private BigDecimal noice;
	private BigDecimal mttf;
	private int gur;
	private int strThreeDotFive;
	private int sata;
	private String partsImage;
	private String regDtm;
	private String updtDtm;
	private String multiBulk;
	private int volume;
}