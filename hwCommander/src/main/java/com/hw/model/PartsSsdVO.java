package com.hw.model;

import java.math.BigDecimal;

import lombok.Data;

@Data
public class PartsSsdVO {
	private String id;
	private String partsName;
	private int partsPrice;
	private String partsPriceStr;
	private BigDecimal basic;
	private int fnc;
	private int cmf;
	private int war;
	private BigDecimal thr;
	private BigDecimal rlb;
	private int strTwoDotFive;
	private String scsCd;
	private String scsCdNm;
	private int sata;
	private String partsImage;
	private String regDtm;
	private String updtDtm;
	private int multiBulk;
	private int volume;
	private int qc;
	
	private int partsHistorySeq;
}