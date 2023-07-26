package com.hw.model;

import java.math.BigDecimal;

import lombok.Data;

@Data
public class PartsHddHistoryVO {
	private String id;
	private int historySeq;
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
	private String multiBulk;
	private int volume;
}